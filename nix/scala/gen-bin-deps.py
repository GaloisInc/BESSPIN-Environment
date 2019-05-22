import os
import subprocess
import sys
import textwrap
import urllib.request
import xml.etree.ElementTree as ET

def prefetch(url):
    cache_path = 'cache/prefetch_%s' % url.replace('/', '_')
    if os.path.exists(cache_path):
        return open(cache_path).read()

    try:
        p = subprocess.run(('nix-prefetch-url', url), check=True, capture_output=True)
        h = p.stdout.decode('utf-8').strip()
    except subprocess.CalledProcessError:
        h = '0' * 52
    with open(cache_path, 'w') as f:
        f.write(h)
    return h

def nix_safe(s):
    return s.replace('.', '_')

SBT_PLUGIN_PREFIX = 'https://repo.scala-sbt.org/scalasbt/sbt-plugin-releases/'
MAVEN_PREFIX = 'https://repo1.maven.org/maven2/'

print('{ mkBinPackage, mkMetadataPackage, genRepo }:')
print('genRepo [\n')

for url in sys.stdin:
    url = url.strip()
    if url == '' or url.startswith('#'):
        continue

    meta_only = False

    if url.startswith(SBT_PLUGIN_PREFIX):
        kind = 'SbtPlugin'
        rel = url[len(SBT_PLUGIN_PREFIX):]
        parts = rel.split('/')

        name = parts[1]
        version = parts[-3]
        org = parts[0]

        if url.endswith('.xml'):
            meta_only = True
        else:
            jar_url = url
            jar_dest = '/'.join(('ivy2', org, name, version, 'jars', '%s.jar' % name))

        if not meta_only:
            meta_url = SBT_PLUGIN_PREFIX + '/'.join(parts[:-2]) + '/ivys/ivy.xml'
        else:
            meta_url = url
        meta_dest = '/'.join(('ivy2', org, name, version, 'ivys', 'ivy.xml'))

    elif url.startswith(MAVEN_PREFIX):
        kind = 'Maven'
        rel = url[len(MAVEN_PREFIX):]
        parts = rel.split('/')

        name = parts[-3]
        version = parts[-2]
        org = '.'.join(parts[:-3])

        if url.endswith('.pom'):
            meta_only = True
        else:
            jar_url = url
            jar_dest = 'maven/' + rel

        if not meta_only:
            if url.endswith('-sources.jar'):
                suffix = '-sources.jar'
            else:
                suffix = '.jar'
            meta_url = url[:-len(suffix)] + '.pom'
            meta_dest = 'maven/' + rel[:-len(suffix)] + '.pom'
        else:
            meta_url = url
            meta_dest = 'maven/' + rel

    else:
        sys.stderr.write('unknown url prefix: %s' % url)


    if not meta_only:
        jar_hash = prefetch(jar_url)
    meta_hash = prefetch(meta_url)

    nix_name = nix_safe(name + '_' + version)

    if not meta_only:
        print(textwrap.dedent('''
            (mkBinPackage {{
              name = "{nix_name}";
              pname = "{name}";
              version = "{version}";
              org = "{org}";
              jarUrl = "{jar_url}";
              jarSha256 = "{jar_hash}";
              jarDest = "{jar_dest}";
              metaUrl = "{meta_url}";
              metaSha256 = "{meta_hash}";
              metaDest = "{meta_dest}";
            }})
        ''').strip().format(**locals()))
    else:
        print(textwrap.dedent('''
            (mkMetadataPackage {{
              name = "{nix_name}";
              pname = "{name}";
              version = "{version}";
              org = "{org}";
              metaUrl = "{meta_url}";
              metaSha256 = "{meta_hash}";
              metaDest = "{meta_dest}";
            }})
        ''').strip().format(**locals()))
    print()

print(']')
