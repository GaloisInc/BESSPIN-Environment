import argparse
from collections import namedtuple
import getpass
import json
import os
import requests
from requests.auth import HTTPBasicAuth, HTTPDigestAuth
import subprocess
import sys
import tempfile

DEFAULT_URL = 'https://artifactory.galois.com/besspin_generic-nix'

def parse_args():
    p = argparse.ArgumentParser(
            description='Sign and deploy Nix packages via HTTP.')
    p.add_argument('--url', default=DEFAULT_URL,
            help='URL of the remote repository (default: %s)' % DEFAULT_URL)
    p.add_argument('--user',
            help='username for authenticating HTTP uploads (default: $USER)')
    p.add_argument('--password-file',
            help='file containing password for authenticating HTTP uploads '
                '(default: use $BESSPIN_DEPLOY_PASSWORD as the password)')
    p.add_argument('--nix-private-key-file',
            help='file containing the private key for signing Nix packages '
                '(default: use $BESSPIN_NIX_PRIVATE_KEY as the key)')
    p.add_argument('--skip-signed-by', default='cache.nixos.org-1',
            help='skip deploying packages that already have signatures '
                'from the listed keys '
                '(comma-separated; default: cache.nixos.org-1)')
    p.add_argument('--no-skip-signed-by',
            dest='skip_signed_by', action='store_const', const='')
    p.add_argument('--no-skip-signed-by-self',
            dest='skip_signed_by_self', default=True, action='store_false',
            help="don't skip deploying packages that already have signatures "
                'from the Nix private key we are using for signing')
    p.add_argument('--check-signed-by-self', default=False, action='store_true',
            help='for packages we already signed, only skip if the package '
                'is actually present in the remote repository')
    p.add_argument('--no-skip-fixed-output',
            dest='skip_fixed_output', default=True, action='store_false',
            help="don't skip deploying fixed-output packages")
    p.add_argument('--dry-run',
            dest='dry_run', default=False, action='store_true',
            help='compute the list of packages to deploy, '
            "but don't actually upload anything")
    p.add_argument('nix_paths', nargs='+',
            help='deploy the packages at these paths, and all their dependencies')
    return p.parse_args()


# Functions for processing command-line arguments

def get_http_user(args):
    if args.user is not None:
        return args.user

    try:
        return getpass.getuser()
    except Exception as e:
        raise RuntimeError('must provide --user because username is unavailable') from e

def get_http_password(args):
    if args.password_file is not None:
        with open(args.password_file, 'r') as f:
            return f.read().strip()

    p = os.environ.get('BESSPIN_DEPLOY_PASSWORD')
    if p is not None:
        return p

    raise RuntimeError('must provide --password-file or set $BESSPIN_DEPLOY_PASSWORD')

RepoInfo = namedtuple('RepoInfo', ('url', 'user', 'password', 'auth'))

def get_repo_info(args):
    url = args.url
    if not url.endswith('/'):
        url += '/'
    user = get_http_user(args)
    password = get_http_password(args)
    auth = HTTPBasicAuth(user, password)
    return RepoInfo(url, user, password, auth)

# `name` is the name of the key, like "cache.nixos.org-1"
KeyFile = namedtuple('KeyFile', ('name', 'path',))
KeyString = namedtuple('KeyString', ('name', 'key',))

def get_nix_key(args):
    if args.nix_private_key_file is not None:
        with open(args.nix_private_key_file, 'r') as f:
            name = f.read().strip().partition(':')[0]
        return KeyFile(name, args.nix_private_key_file)

    k = os.environ.get('BESSPIN_NIX_PRIVATE_KEY')
    if k is not None:
        name = k.partition(':')[0]
        return KeyString(name, k)

    raise RuntimeError('must provide --nix-private-key-file or set $BESSPIN_NIX_PRIVATE_KEY')

def get_skipped_key_names(args):
    return [k.strip() for k in args.skip_signed_by.split(',')]

def get_raw_package_list(args):
    '''Get the unfiltered list of all packages we might possibly deploy.'''
    p = subprocess.run(
            ('nix', 'path-info', '--recursive', '--sigs', '--json') +
                tuple(args.nix_paths),
            check=True, stdout=subprocess.PIPE)
    return json.loads(p.stdout)


# Functions for checking properties of packages

def package_signed_by(pkg, key):
    sigs = pkg.get('signatures')
    if sigs is None:
        return False
    return any(sig.partition(':')[0] == key for sig in sigs)

def package_signed_by_any(pkg, keys):
    sigs = pkg.get('signatures')
    if sigs is None:
        return False
    return any(sig.partition(':')[0] in keys for sig in sigs)

def nix_path_to_hash(path):
    assert path.startswith('/nix/store/')
    tail = path[len('/nix/store/'):]
    return tail.partition('-')[0]

def package_hash(pkg):
    return nix_path_to_hash(pkg['path'])

def package_present_in_remote(pkg, repo):
    url = repo.url + package_hash(pkg) + '.narinfo'
    print('checking presence of %s ... ' % url, end='')
    r = requests.head(url, auth=repo.auth)
    print('%s (%d)' % (r.ok, r.status_code))
    # If we get a non-404 error, such as 403 Forbidden, raise an exception
    # instead of simply reporting that the package is not present.
    if not r.ok and r.status_code != 404:
        r.raise_for_status()
    return r.ok


# Functions for filtering the package list

def skip_pkgs_with_signatures(pkgs, skipped_key_names):
    keys = set(skipped_key_names)
    return [pkg for pkg in pkgs if not package_signed_by_any(pkg, keys)]

def skip_pkgs_with_self_signature(pkgs, self_key_name, check, repo):
    def keep_pkg(pkg):
        if not package_signed_by(pkg, self_key_name):
            return True
        if check:
            if not package_present_in_remote(pkg, repo):
                return True
        return False

    return [pkg for pkg in pkgs if keep_pkg(pkg)]

def skip_fixed_output_pkgs(pkgs):
    # Fixed-output derivations have a field "ca": "fixed:r:sha256:aabbccdd..."
    return [pkg for pkg in pkgs if 'ca' not in pkg]


def sign_pkgs(pkgs, key):
    if isinstance(key, KeyFile):
        key_path = key.path
        input_str = None
    elif isinstance(key, KeyString):
        key_path = '/dev/stdin'
        input_str = None
    else:
        raise TypeError('expected KeyFile or KeyString, not `%s`' % type(key).__name__)

    if len(pkgs) == 0:
        return
    paths = tuple(pkg['path'] for pkg in pkgs)
    subprocess.run(
            ('nix', 'sign-paths', '--key-file', key_path) + paths,
            input=input_str, check=True)

def copy_pkgs_to_dir(pkgs, work_dir):
    '''Copy each package in `pkgs` to a temporary binary cache in `work_dir`.'''
    if len(pkgs) == 0:
        return

    # Tricky optimization: we want to copy only the packages we actually plan to
    # upload into `work_dir`.  Doing a full recursive copy is slow and uses a
    # lot of disk space.  But partial copies aren't allowed: `nix copy` throws
    # an error if a package it's copying depends on something not present in the
    # destination cache.  So we prepopulate the cache with dummy `.narinfo`s for
    # all the dependencies, then do the non-recursive copy.
    #
    # The narinfo format has several fields, but based on some experiments, it
    # seems that only a few of them are checked:
    # - `StorePath` must be the package's actual store path, matching the path
    #   that appears in its dependents' `references` list.
    # - `URL` must point to an existing file in the binary cache.
    # - `NarSize` must be nonzero.
    # If these checks fail, `nix copy` reports only that the narinfo is corrupt.
    # We satisfy these requirements by setting `StorePath` properly, seting
    # `URL` to the name of the narinfo itself, and setting `NarSize` to 1.
    #
    # However, we must avoid creating these dummy narinfos for packages in
    # `pkgs` (when one package in the list depends on another), since `nix copy`
    # will only add packages it believes are missing.
    paths = set(pkg['path'] for pkg in pkgs)
    for pkg in pkgs:
        for dep_path in pkg['references']:
            if dep_path in paths:
                continue
            dep_hash = nix_path_to_hash(dep_path)
            narinfo_path = os.path.join(work_dir, dep_hash) + '.narinfo'
            if not os.path.exists(narinfo_path):
                with open(narinfo_path, 'w') as f:
                    f.write('StorePath: %s\n' % dep_path)
                    f.write('URL: %s.narinfo\n' % dep_hash)
                    f.write('Compression: none\n')
                    f.write('FileHash: sha256:%s\n' % ('0' * 52))
                    f.write('FileSize: 0\n')
                    f.write('NarHash: sha256:%s\n' % ('0' * 52))
                    f.write('NarSize: 1\n')
                    # Note the trailing space is required
                    f.write('References: \n')
                    f.write('Deriver: %s\n' % ('0' * 52))

    subprocess.run(
            ('nix', 'copy', '--to', 'file://' + work_dir,
                '--no-recursive', '--no-check-sigs') + tuple(paths),
            check=True)

def read_nar_path_from_narinfo(narinfo_path):
    with open(narinfo_path) as f:
        nar_rel = None
        for line in f:
            if line.startswith('URL: nar/'):
                nar_rel = line.strip()[len('URL: '):]
                break
        assert nar_rel is not None, 'missing NAR path in %s' % narinfo_path
    assert nar_rel.startswith('nar/')
    assert '/' not in nar_rel[len('nar/'):]
    return os.path.join(nar_rel)

def get_pkg_file_paths(pkg_hash, work_dir):
    narinfo_path = os.path.join(work_dir, pkg_hash + '.narinfo')
    nar_rel = read_nar_path_from_narinfo(narinfo_path)
    nar_path = os.path.join(work_dir, nar_rel)
    return narinfo_path, nar_path

def pkg_upload_size(pkg, work_dir):
    pkg_hash = nix_path_to_hash(pkg['path'])
    narinfo_path, nar_path = get_pkg_file_paths(pkg_hash, work_dir)
    return os.path.getsize(narinfo_path) + os.path.getsize(nar_path)

def upload_pkg_from_dir(pkg, repo, work_dir):
    pkg_hash = nix_path_to_hash(pkg['path'])
    narinfo_path, nar_path = get_pkg_file_paths(pkg_hash, work_dir)

    with open(narinfo_path, 'rb') as f:
        dest_url = repo.url + pkg_hash + '.narinfo'
        print('uploading %s' % dest_url)
        r = requests.put(dest_url, auth=repo.auth, data=f)
        r.raise_for_status()

    with open(nar_path, 'rb') as f:
        dest_url = repo.url + 'nar/' + os.path.basename(nar_path)
        print('uploading %s' % dest_url)
        r = requests.put(dest_url, auth=repo.auth, data=f)
        r.raise_for_status()


def main():
    args = parse_args()

    self_key = get_nix_key(args)
    repo = get_repo_info(args)

    pkgs = get_raw_package_list(args)
    print('raw package list: %d' % len(pkgs))
    pkgs = skip_pkgs_with_signatures(pkgs, get_skipped_key_names(args))
    if args.skip_fixed_output:
        pkgs = skip_fixed_output_pkgs(pkgs)
    if args.skip_signed_by_self:
        pkgs = skip_pkgs_with_self_signature(pkgs, self_key.name,
                args.check_signed_by_self, repo)
    # TODO: filter by package name
    # TODO: filter by package contents
    print('found %d packages to deploy, %.1f MB uncompressed' %
            (len(pkgs), sum(p['narSize'] for p in pkgs) / (1024 * 1024)))

    if args.dry_run:
        print('would sign and upload %d packages:' % len(pkgs))
        for pkg in pkgs:
            print(pkg['path'])
        return


    with tempfile.TemporaryDirectory() as work_dir:
        sign_pkgs(pkgs, self_key)
        copy_pkgs_to_dir(pkgs, work_dir)

        print('populated package dir, %.1f MB compressed' %
                (sum(pkg_upload_size(p, work_dir) for p in pkgs) / (1024 * 1024)))

        for pkg in pkgs:
            upload_pkg_from_dir(pkg, repo, work_dir)

if __name__ == '__main__':
    main()
