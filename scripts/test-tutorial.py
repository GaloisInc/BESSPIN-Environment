import io
import json
import os
import re
import shlex
import shutil
import subprocess
import sys
import tempfile


# Password used for running `sudo`
SUDO_PASSWORD = os.environ['BESSPIN_TEST_SUDO_PASSWORD']


LOG_FILE_NAME = '/dev/stderr'
LOG_FILE_RAW = sys.stderr.buffer
LOG_FILE = sys.stderr

real_print = print

def lprint(*args, **kwargs):
    kwargs['file'] = LOG_FILE
    kwargs['flush'] = True
    return real_print(*args, **kwargs)

def print(*args, **kwargs):
    real_print(*args, **kwargs)
    lprint(*args, **kwargs)

def init_log_file(path):
    global LOG_FILE_NAME, LOG_FILE_RAW, LOG_FILE
    LOG_FILE_NAME = path
    LOG_FILE_RAW = open(LOG_FILE_NAME, 'wb')
    LOG_FILE = io.TextIOWrapper(LOG_FILE_RAW)


def run_program(args):
    lprint(' >>> Running program %s' % (args,))
    proc = subprocess.run(args, check=True, stdout=LOG_FILE, stderr=LOG_FILE)
    lprint(' >>> %s exited with code %d' % (args[0], proc.returncode))

DID_APT_UPDATE = False
def apt_update():
    global DID_APT_UPDATE
    if DID_APT_UPDATE:
        return
    run_program(('sudo', 'apt-get', 'update', '-y'))
    DID_APT_UPDATE = True

def apt_install(pkg):
    apt_update()
    run_program(('sudo', 'apt-get', 'install', '-y', pkg))


try:
    import pexpect
except ImportError:
    print('Python module `pexpect` is missing - installing...')
    apt_install('python3-pexpect')
    import pexpect

try:
    import requests
except ImportError:
    print('Python module `requests` is missing - installing...')
    apt_install('python3-requests')
    import requests


class ExpectAuto(pexpect.spawn):
    '''Like `pexpect.spawn`, except it allows registering handlers for messages
    that may show up at any time between the normal `expect`ed outputs.'''
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.auto_patterns = []
        self.auto_handlers = []
        self.auto_ids = []
        self.next_auto_id = 0

    def add_handler(self, pat, func):
        '''Add an automatic handler for `pat`.  On each call to `expect`, if
        `pat` appears before the `expect`ed pattern, `func(self)` will be
        called and the `expect` will resume searching for its normal patterns.

        Returns an ID that can be passed to `remove_handler`.
        '''
        pat = self.compile_pattern_list(pat)[0]

        auto_id = self.next_auto_id
        self.next_auto_id += 1
        self.auto_patterns.append(pat)
        self.auto_handlers.append(func)
        self.auto_ids.append(auto_id)

    def remove_handler(self, auto_id):
        try:
            idx = self.auto_ids.index(auto_id)
        except ValueError:
            return
        del self.auto_patterns[idx]
        del self.auto_handlers[idx]
        del self.auto_ids[idx]

    def expect_list(self, pats, *args, **kwargs):
        # Note: the `async` kwarg is not supported
        all_pats = self.auto_patterns + self.compile_pattern_list(pats)
        while True:
            # Call `expect` instead of `expect_list` so that elements of
            # `self.auto_patterns` will get the normal processing.
            result = super().expect_list(all_pats, *args, **kwargs)
            if result < len(self.auto_patterns):
                self.auto_handlers[result](self)
            else:
                return result - len(self.auto_patterns)

    def expect_exact(self, pats, *args, **kwargs):
        # The patterns for `expect_exact` are always strings.  We convert them
        # to regexes for compatibility with `self.auto_patterns`.
        def prepare_pattern(p):
            if p in (pexpect.TIMEOUT, pexpect.EOF):
                return p
            if isinstance(p, (str, bytes)):
                return self.compile_pattern_list(re.escape(p))[0]
            raise TypeError('expected str or bytes, but got %r' % (type(p),))

        if not isinstance(pats, list):
            pats = [pats]
        all_pats = self.auto_patterns + [prepare_pattern(p) for p in pats]
        while True:
            result = super().expect_list(all_pats, *args, **kwargs)
            if result < len(self.auto_patterns):
                self.auto_handlers[result](self)
            else:
                return result - len(self.auto_patterns)

    def check_wait(self, *args, **kwargs):
        status = self.wait(*args, **kwargs)
        if status != 0:
            raise OSError('process returned nonzero exit code %d\n%s' % (status, self))

def expect_program(args, **kwargs):
    lprint(' >>> Start interactive program %s' % (args,))
    return ExpectAuto(args[0], list(args[1:]), logfile=LOG_FILE_RAW, **kwargs)

def interact_program(args, **kwargs):
    lprint(' >>> Running program %s with passthrough' % (args,))
    p = expect_program(args, **kwargs)
    p.interact()
    p.check_wait()
    lprint(' >>> %s exited successfully' % (args[0],))


def enter_sudo_password(p):
    assert p.waitnoecho(), 'timeout while waiting for `sudo` to disable echo'
    p.sendline(SUDO_PASSWORD)

def add_sudo_password_handler(p):
    p.add_handler(r'\[sudo\] password', enter_sudo_password)

def install_nix():
    if shutil.which('nix-shell'):
        return
    print('Command `nix-shell` is missing - installing...')

    # Install dependencies of the Nix setup script
    if not shutil.which('curl'):
        print('Command `curl` is missing - installing...')
        apt_install('curl')

    if not shutil.which('rsync'):
        print('Command `curl` is missing - installing...')
        apt_install('rsync')

    # Download the script to a temporary file, then run it
    #f = tempfile.NamedTemporaryFile()
    f = open('faketempfile', 'w+b')
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
    add_sudo_password_handler(p)
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


def sudo_command(cmd):
    p = expect_program(('sudo',) + cmd)
    add_sudo_password_handler(p)
    p.expect(pexpect.EOF)
    p.check_wait()

def sudo_edit_file(cmd, path):
    '''Use `sudo` to run the edit command `cmd` on `path`.  Edit commands are
    defined in the `do_edit_command` function.'''
    args = (sys.executable, sys.argv[0], cmd, path)
    p = expect_program(('sudo',) + args)
    add_sudo_password_handler(p)
    p.expect_exact('finished %s\r\n' % cmd)
    p.check_wait()

def do_edit_command(cmd, path):
    if cmd == 'edit-nix-conf':
        do_edit_nix_conf(path)
    elif cmd == 'edit-netrc':
        do_edit_netrc(path)
    else:
        raise ValueError('unknown edit command edit-%s' % cmd)

NIXOS_SUBSTITUTER = 'https://cache.nixos.org/'
NIXOS_PUBLIC_KEY = 'cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY='

BESSPIN_SUBSTITUTER = 'https://artifactory.galois.com/besspin_generic-nix/'
BESSPIN_PUBLIC_KEY = 'besspin.galois.com-1:8IqXQ2FM1J5CuPD+KN9KK4z6WHve4KF3d9zGRK+zsBw='

NETRC_USERNAME = os.environ['BESSPIN_TEST_NETRC_USERNAME']
NETRC_PASSWORD = os.environ['BESSPIN_TEST_NETRC_PASSWORD']

def do_edit_nix_conf(path):
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

def do_edit_netrc(path):
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

    if len(lines) > 0:
        lines.append('\n')
    lines.extend([
        'machine artifactory.galois.com\n',
        'login %s\n' % NETRC_USERNAME,
        'password %s\n' % NETRC_PASSWORD,
    ])

    prev_umask = os.umask(0o077)
    try:
        with open(path, 'w') as f:
            f.write(''.join(lines))
    finally:
        os.umask(prev_umask)


def configure_nix():
    print('Setting up Nix configuration in /etc/nix...')
    sudo_command(('mkdir', '-p', '/etc/nix'))
    sudo_edit_file('edit-nix-conf', '/etc/nix/nix.conf')
    sudo_edit_file('edit-netrc', '/etc/nix/netrc')
    sudo_command(('systemctl', 'restart', 'nix-daemon.service'))


def install_tool_suite():
    print('Updating BESSPIN Tool Suite packages (this may take a while)...')
    assert os.path.exists('shell.nix'), \
            'must run this script within a tool-suite checkout'
    p = expect_program(('nix-shell', '--run', 'echo setup done'))
    p.expect_exact('setup done', timeout=900)


def clone_piccolo():
    if os.path.isdir('../Piccolo'):
        return
    print('Cloning ssith/Piccolo...')
    run_command(('git', 'clone', 'https://github.com/bluespec/Piccolo.git',
        '../Piccolo'))


def do_tutorial():
    print('Entering Nix shell...')
    args = ' '.join(shlex.quote(s) for s in
            ('python3', sys.argv[0], 'tutorial-inner'))
    interact_program(('nix-shell', '--run', args))

class ProgressCounter:
    def __init__(self, descs, prefix=''):
        self.descs = descs
        self.counts = [0] * len(descs)
        self.prefix = prefix

    def msg(self):
        return self.prefix + ', '.join(d % c for d, c in zip(self.descs, self.counts))

    def count(self, i, display=True):
        self.counts[i] += 1
        if display:
            sys.stdout.write('\r\x1b[K' + self.msg())
            sys.stdout.flush()

    def finish(self):
        sys.stdout.write('\r\x1b[K')
        print(self.msg())

    def mk_counter(self, i):
        return lambda p: self.count(i)

class ProgressGroups:
    def __init__(self, counters):
        self.counters = counters
        self.current = 0
        sys.stdout.write(self.counters[0].msg())
        self.active = True

    def report_special(self, msg):
        self._finish_current()
        print(msg)

    def finish(self):
        self._finish_current()

    def _finish_current(self):
        if self.active:
            sys.stdout.write('\r\x1b[K')
            print(self.counters[self.current].msg())
        self.active = False

    def count(self, i, j):
        if i > self.current:
            self._finish_current()
            self.current = i
        display = self.current == i
        self.counters[i].count(j, display=display)
        if display:
            self.active = True

    def mk_counter(self, i, j):
        return lambda p: self.count(i, j)

def manual_test(msg):
    print('- Manual test: %s' % msg)
    input('  (Press Enter to continue)')

def remove_file_if_exists(path, desc):
    if os.path.exists(path):
        print('- Remove ' + desc)
        os.unlink(path)

def remove_dir_if_exists(path, desc):
    if os.path.isdir(path):
        print('- Remove ' + desc)
        shutil.rmtree(path)

def do_tutorial_inner():
    print('Running tutorial...')

    do_tutorial_arch()
    do_tutorial_feature()
    do_tutorial_ui()

def do_tutorial_arch():
    print('Architecture extraction')

    remove_dir_if_exists('tutorial/piccolo/ast-cache',
            'cached Piccolo AST files')

    do_tutorial_arch_with_config('tutorial/piccolo.toml')
    do_tutorial_arch_with_config('tutorial/piccolo-low-level.toml')
    do_tutorial_arch_with_config('tutorial/piccolo-high-level.toml')

def do_tutorial_arch_with_config(config_path):
    used_cached_ast = os.path.isdir('tutorial/piccolo/ast-cache')
    remove_dir_if_exists('piccolo-arch',
            'old Piccolo architecture diagrams')

    print('- Generate Graphviz architecture files')
    p = expect_program(('besspin-arch-extract', config_path, 'visualize'))
    pg = ProgressGroups([
        ProgressCounter(['Compiled %d BSV packages', 'wrote %d'], prefix='  - '),
        ProgressCounter(['Loaded %d packages'], prefix='  - '),
        ProgressCounter(['Rendered %d modules'], prefix='  - '),
    ])
    p.add_handler(r'compiling.*\.bsv', pg.mk_counter(0, 0))
    p.add_handler(r'writing.*\.cbor', pg.mk_counter(0, 1))
    p.add_handler(r'loading package', pg.mk_counter(1, 0))
    p.add_handler(r'rendering module', pg.mk_counter(2, 0))
    p.expect('processing [0-9]+ structs')
    pg.report_special('  - Processing architecture...')
    p.expect(r'wrote [0-9]* graphviz files to piccolo-arch/')
    p.check_wait()
    pg.finish()
    if used_cached_ast:
        assert pg.counters[0].counts[0] == 0, \
                'expected no compiled packages when using cached ASTs'
    else:
        assert pg.counters[0].counts[0] >= 30, 'expected at least 30 packages compiled'
    assert pg.counters[1].counts[0] >= 30, 'expected at least 30 packages loaded'
    assert pg.counters[2].counts[0] >= 30, 'expected at least 30 modules rendered'

    print('- Convert Graphviz files to PDF')
    pc = ProgressCounter(['Converted %d diagrams'], prefix='  - ')
    ARCH_DIR = 'piccolo-arch'
    for f in os.listdir(ARCH_DIR):
        path = os.path.join(ARCH_DIR, f)
        stem, ext = os.path.splitext(path)
        assert ext == '.dot', 'unexpected file %r in %s' % (f, ARCH_DIR)
        run_program(('dot', '-Tpdf', '-o', stem + '.pdf', path))
        pc.count(0)
    pc.finish()
    assert pc.counts[0] >= 30, 'expected at least 30 diagrams converted'

    example_path = os.path.join(ARCH_DIR, 'Shifter_Box.mkShifter_Box.pdf')
    assert os.path.exists(example_path), 'Shifter_Box PDF diagram is missing'
    manual_test('open %s in a PDF viewer' % os.path.abspath(example_path))

def do_tutorial_feature():
    print('Feature model extraction')

    FMJSON_FILE = 'piccolo.fm.json'
    SIMPLIFIED_FILE = 'piccolo-simple.fm.json'
    CLAFER_FILE = 'piccolo.cfr'

    #remove_file_if_exists(FMJSON_FILE, 'old Piccolo feature model')
    remove_file_if_exists(SIMPLIFIED_FILE, 'old simplified Piccolo feature model')
    remove_file_if_exists(CLAFER_FILE, 'old Piccolo Clafer feature model')

    if not os.path.exists(FMJSON_FILE):
        print('- Extract feature model')
        p = expect_program(('besspin-feature-extract', 'tutorial/piccolo.toml', 'synthesize'),
            timeout=45 * 60)
        def no_positive_configs(p):
            raise ValueError('Piccolo feature extraction config '
                    'provided no positive inputs')
        p.add_handler('\(0 positive\)', no_positive_configs)
        p.expect('starting strategies')
        print('  - Synthesizing...')
        p.expect('struct:feature-model')
        print('  - Generated feature model')
        p.check_wait()

        assert os.path.exists(FMJSON_FILE), \
                'besspin-feature-extract did not produce %s' % FMJSON_FILE
        try:
            with open(FMJSON_FILE, 'r') as f:
                j = json.load(f)
        except json.JSONDecodeError:
            assert False, 'besspin-feature-extract emitted invalid json to %s' % FMJSON_FILE
        assert len(j['features']) >= 15, 'expected at least 15 features in piccolo feature model'

    print('- Simplify feature model')
    p = subprocess.run(('besspin-feature-model-tool', 'simplify', FMJSON_FILE),
            check=True, timeout=15 * 60, stdout=subprocess.PIPE, stderr=LOG_FILE)
    content = p.stdout

    try:
        j = json.loads(content)
    except json.JSONDecodeError:
        assert False, 'besspin-feature-model-tool emitted invalid simplified json'
    with open(SIMPLIFIED_FILE, 'wb') as f:
        f.write(content)
    assert len(j['features']) >= 15, \
            'expected at least 15 features in simplified piccolo feature model'
    assert len(j['constraints']) <= 10, \
            'expected at most 10 constraints in simplified piccolo feature model'

    print('- Validate feature model')
    p = subprocess.run(('besspin-feature-model-tool', 'count-configs', SIMPLIFIED_FILE),
            check=True, timeout=30, stdout=subprocess.PIPE, stderr=LOG_FILE)
    content = p.stdout
    assert int(content) > 0, \
            'expected at least one valid config in piccolo feature model'

    print('- Convert feature model to Clafer syntax')
    p = subprocess.run(('besspin-feature-model-tool', 'print-clafer', SIMPLIFIED_FILE),
            check=True, timeout=30, stdout=subprocess.PIPE, stderr=LOG_FILE)
    content = p.stdout
    with open(CLAFER_FILE, 'wb') as f:
        f.write(content)
    assert len(content.splitlines()) >= 15, \
            'expected at least 15 lines in piccolo clafer feature model'


def do_tutorial_ui():
    print('Tool Suite UI')

    print('- Start tool suite UI')
    p = subprocess.Popen(('besspin-configurator',),
            stdout=LOG_FILE, stderr=LOG_FILE)
    manual_test('access tool suite UI at http://localhost:3784')
    print('- Shut down tool suite UI')
    p.kill()
    p.wait(timeout=5)


def do_tutorial_piccolo_build():
    print('Piccolo build')

    PICCOLO_DIR = os.path.abspath('../Piccolo')
    CONFIGURED_FILE = os.path.abspath('tutorial/piccolo.fm.json.configured')
    BUILD_DIR = 'piccolo-build'

    assert os.path.isdir(PICCOLO_DIR), \
            'missing %s sources needed to run the piccolo build' % PICCOLO_DIR
    assert os.path.isfile(CONFIGURED_FILE), \
            'missing %s needed to run the piccolo build' % CONFIGURED_FILE

    remove_dir_if_exists(BUILD_DIR)
    os.makedirs(BUILD_DIR, exist_ok=True)

    #p = expect_{{{


if __name__ == '__main__':
    if len(sys.argv) >= 2 and sys.argv[1].startswith('edit-'):
        if len(sys.argv) != 3:
            raise ValueError('expected 1 argument after edit command')
        cmd, path = sys.argv[1:3]
        print('running %s on %s' % (cmd, path))
        do_edit_command(cmd, path)
        print('finished %s' % cmd)
        sys.exit(0)

    if len(sys.argv) >= 2 and sys.argv[1] == 'tutorial-inner':
        if len(sys.argv) != 2:
            raise ValueError('expected no arguments after tutorial-inner command')
        init_log_file('test-tutorial-inner.log')
        do_tutorial_inner()
        sys.exit(0)

    init_log_file('test-tutorial.log')
    install_nix()
    configure_nix()
    install_tool_suite()
    clone_piccolo()
    do_tutorial()

    #p = pexpect.spawn('bash', ['test.sh'])
    #p.expect('world')
    #print(p.before)
    #print(p.after)
    #p.expect(pexpect.EOF)
    #print(p.wait())
