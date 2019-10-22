# usage: python3 scripts/update-debian-repo-files.py [--replace] nix/misc/debian-repo-files.json
# Adds the files listed in `debian-urls.txt` (produced by debian-repo-proxy.py)
# to debian-repo-files.json.  With --replace, replaces the json file with one
# containing only the files listed in debian-urls.txt, instead of adding to it.
import http.client
import json
import os
import re
import subprocess
import sys
import urllib.parse

assert __name__ == '__main__', 'this module should only be executed, not imported'

REAL_HOST = 'snapshot.debian.org'
REAL_PATH = '/archive/debian-ports/20190915T062333Z'

BAD_CHAR_RE = re.compile(r'[^a-zA-Z0-9_.-]')


with open('debian-urls.txt', 'r') as f:
    paths = set(x.strip() for x in f.readlines())

json_path = None
replace = False
for arg in sys.argv[1:]:
    if arg == '--replace':
        replace = True
    else:
        assert json_path is None, \
                'usage: python3 %s [--replace] debian-repo-files.json' % sys.argv[0]
        json_path = arg

if not replace and os.path.exists(json_path):
    with open(json_path, 'r') as f:
        old_files = json.load(f)
else:
    old_files = []

old_files_by_path = dict((x['path'], x) for x in old_files)

new_files = []
for raw_path in sorted(paths):
    path = urllib.parse.unquote(raw_path)

    if path in old_files_by_path:
        new_files.append(old_files_by_path[path])
        continue

    name = BAD_CHAR_RE.sub('_', os.path.basename(path))
    url = 'https://%s%s%s' % (REAL_HOST, REAL_PATH, raw_path)

    print('fetching %s' % url)

    p = subprocess.run(('nix-prefetch-url', '--name', name, url), capture_output=True)
    sha256 = p.stdout.decode('ascii').strip()

    new_files.append({
        'name': name,
        'path': path,
        'url': url,
        'sha256': sha256,
    })

with open(json_path, 'w') as f:
    json.dump(new_files, f)

print('emitted entries for %d files' % len(new_files))
