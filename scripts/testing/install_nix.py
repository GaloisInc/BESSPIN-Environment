import getpass
import os
import requests
import shutil
import sys
import tempfile

from besspin_testing import *
from besspin_pexpect import *
from besspin_sudo import call_with_sudo

NIXOS_SUBSTITUTER = 'https://cache.nixos.org/'
NIXOS_PUBLIC_KEY = 'cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY='

BESSPIN_SUBSTITUTER = 'https://artifactory.galois.com/besspin_generic-nix/'
BESSPIN_PUBLIC_KEY = 'besspin.galois.com-1:8IqXQ2FM1J5CuPD+KN9KK4z6WHve4KF3d9zGRK+zsBw='

def get_netrc_username():
    from_env = os.environ.get('BESSPIN_TEST_NETRC_USERNAME')
    if from_env is not None:
        return from_env

    return input('Artifactory username: ')

def get_netrc_password():
    from_env = os.environ.get('BESSPIN_TEST_NETRC_PASSWORD')
    if from_env is not None:
        return from_env

    return getpass.getpass('Artifactory API key: ')


def sudo_command(cmd, reason=None):
    '''Pass environment variables through to sudo when running the command'''
    p = expect_program(('sudo', '-E') + cmd)
    add_sudo_password_handler(p, reason=reason)
    p.expect(pexpect.EOF)
    p.check_wait()

def request_sudo_password(p, reason=None):
    '''Pass through a `sudo` password request to the user.'''
    assert p.waitnoecho(), 'timeout while waiting for `sudo` to disable echo'
    if reason is not None:
        print('Superuser privileges are required %s' % reason)
    prompt = (p.after + p.buffer).decode()
    pw = getpass.getpass(prompt)
    p.send_password_line(pw)

def add_sudo_password_handler(p, reason=None):
    p.add_handler(r'\[sudo\] password', lambda p: request_sudo_password(p, reason=reason))


def install_nix():
    if shutil.which('nix-shell'):
        return
    print('Installing nix-shell')

    # Download the script to a temporary file, then run it
    f = tempfile.NamedTemporaryFile()
    r = requests.get('https://nixos.org/nix/install')
    f.write(r.content)
    f.flush()

    def answer_prompt(msg, resp):
        p.expect_exact(msg)
        p.expect_exact('[y/n] ')
        p.sendline(resp)

    def handle_error(p):
        p.expect_exact('\r\n')
        p.expect(pexpect.EOF)
        status = p.wait()
        report_error(status)
        raise OSError('nix installation failed')

    def report_error(status):
        lprint(' >>> Nix setup returned an error (code %d)' % status)
        print('An error occurred during Nix installation (exit code %d)' % status)
        print('See %s for details' % LOG_FILE_NAME)

    p = expect_program(('/bin/sh', f.name, '--daemon'))
    add_sudo_password_handler(p, 'to install Nix system-wide')
    p.add_handler('oh no!', handle_error)

    answer_prompt('see a more detailed list', 'n')
    answer_prompt('Can we use sudo?', 'y')
    answer_prompt('Ready to continue?', 'y')
    p.expect_exact('Alright! We\'re done!')
    p.expect(pexpect.EOF)
    status = p.wait()
    if status != 0:
        report_error(status)

    f.close()

def edit_nix_conf(path):
    if os.path.exists(path):
        with open(path) as f:
            lines = f.readlines()
    else:
        lines = []

    new_lines = []
    need_substituter = True
    need_public_key = True
    for l in lines:
        k, sep, v = l.partition('=')
        if sep != '=':
            new_lines.append(l)
            continue

        ks = k.strip()
        if not v.startswith(' '):
            v = ' ' + v
        if ks == 'substituters':
            if BESSPIN_SUBSTITUTER not in v:
                l = k + sep + ' ' + BESSPIN_SUBSTITUTER + v
            # Either the substituter was already present, or we just added it.
            need_substituter = False
        if ks == 'trusted-public-keys':
            if BESSPIN_PUBLIC_KEY not in v:
                l = k + sep + ' ' + BESSPIN_PUBLIC_KEY + v
            need_public_key = False
        new_lines.append(l)

    if need_substituter:
        new_lines.append('substituters = %s %s\n' %
                (BESSPIN_SUBSTITUTER, NIXOS_SUBSTITUTER))
    if need_public_key:
        new_lines.append('trusted-public-keys = %s %s\n' %
                (BESSPIN_PUBLIC_KEY, NIXOS_PUBLIC_KEY))

    with open(path, 'w') as f:
        f.write(''.join(new_lines))

def edit_netrc(path):
    if os.path.exists(path):
        with open(path) as f:
            lines = f.readlines()
    else:
        lines = []

    for l in lines:
        words = l.strip().split()
        if words == ['machine', 'artifactory.galois.com']:
            # Entry is already present
            return

    username = get_netrc_username()
    password = get_netrc_password()

    if len(lines) > 0:
        lines.append('\n')
    lines.extend([
        'machine artifactory.galois.com\n',
        'login %s\n' % username,
        'password %s\n' % password,
    ])

    prev_umask = os.umask(0o077)
    try:
        with open(path, 'w') as f:
            f.write(''.join(lines))
    finally:
        os.umask(prev_umask)

def configure_nix():
    print('Setting up Nix configuration in /etc/nix...')
    if not os.path.isdir('/etc/nix'):
        sudo_command(('mkdir', '-p', '/etc/nix'), reason='to create /etc/nix directory')
    print('- Edit /etc/nix/nix.conf')
    call_with_sudo(edit_nix_conf, '/etc/nix/nix.conf')
    print('- Edit /etc/nix/netrc')
    call_with_sudo(edit_netrc, '/etc/nix/netrc')
    sudo_command(('systemctl', 'restart', 'nix-daemon.service'),
            reason='to restart the Nix daemon')

if __name__ == '__main__':
    init_log_file_for_script(__file__)
    install_nix()
    configure_nix()
