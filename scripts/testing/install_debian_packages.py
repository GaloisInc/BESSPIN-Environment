import shutil

from besspin_testing import *

_DID_APT_UPDATE = False
def apt_update():
    global _DID_APT_UPDATE
    if _DID_APT_UPDATE:
        return
    print('Updating APT package lists')
    run_program(('sudo', 'apt-get', 'update', '-y'))
    _DID_APT_UPDATE = True

def apt_install(pkg):
    apt_update()
    print('Installing `%s` via APT' % pkg)
    run_program(('sudo', 'apt-get', 'install', '-y', pkg))

if __name__ == '__main__':
    init_log_file_for_script(__file__)
    try:
        import pexpect
    except ImportError:
        apt_install('python3-pexpect')
    try:
        import requests
    except ImportError:
        apt_install('python3-requests')
    if not shutil.which('curl'):
        apt_install('curl')
    if not shutil.which('rsync'):
        apt_install('rsync')
    print('All required packages are installed')
