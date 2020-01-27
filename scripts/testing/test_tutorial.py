import io
import json
import os
import re
import shlex
import shutil
import subprocess
import sys
import tempfile

from besspin_testing import *
from besspin_pexpect import *
from besspin_sudo import call_with_nix_shell


def run_program(args):
    lprint(' >>> Running program %s' % (args,))
    proc = subprocess.run(args, check=True, stdout=LOG_FILE, stderr=LOG_FILE)
    lprint(' >>> %s exited with code %d' % (args[0], proc.returncode))


def update_tool_suite():
    print('Updating BESSPIN Tool Suite packages (this may take a while)...')
    assert os.path.exists('shell.nix'), \
            'must run this script within a tool-suite checkout'
    p = expect_program(('nix-shell', '--run', 'echo setup done'))
    add_ssh_host_key_handler(p)
    add_ssh_passphrase_handler(p)
    add_git_password_handler(p)
    p.expect_exact('setup done', timeout=900)


def clone_piccolo():
    if os.path.isdir('../Piccolo'):
        return
    print('Cloning ssith/Piccolo...')
    run_program(('git', 'clone', 'https://github.com/bluespec/Piccolo.git',
        '../Piccolo'))


def do_tutorial():
    print('Entering Nix shell...')
    call_with_nix_shell('shell.nix', do_tutorial_inner)

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
        self.active = False

    def start(self):
        sys.stdout.write(self.counters[0].msg())
        self.active = True

    def finish(self):
        if self.active:
            sys.stdout.write('\r\x1b[K')
            print(self.counters[self.current].msg())
        self.active = False

    def report_special(self, msg):
        self.finish()
        print(msg)

    def count(self, i, j):
        if i > self.current:
            self.finish()
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

OUTPUTS_DIR = 'test-outputs'

def do_tutorial_inner():
    print('Running tutorial...')

    remove_dir_if_exists(OUTPUTS_DIR,
            'previous tutorial outputs')
    os.makedirs(OUTPUTS_DIR, exist_ok=True)

    do_tutorial_arch()
    do_tutorial_feature()

def copy_output(path, name_parts):
    if isinstance(name_parts, str):
        name_parts = [name_parts]
    ext = os.path.splitext(path)[1]
    dest = os.path.join(OUTPUTS_DIR, '-'.join(name_parts) + ext)
    print('- Copy output %s to %s' % (os.path.basename(path), dest))
    assert not os.path.exists(dest), 'duplicate tutorial output %s' % dest
    shutil.copy(path, dest)

def do_tutorial_arch():
    print('Architecture extraction')

    remove_dir_if_exists('tutorial/piccolo/ast-cache',
            'cached Piccolo AST files')

    do_tutorial_piccolo_arch_with_config('tutorial/piccolo.toml')
    do_tutorial_piccolo_arch_with_config('tutorial/piccolo-low-level.toml')
    do_tutorial_piccolo_arch_with_config('tutorial/piccolo-high-level.toml')
    do_tutorial_rocket_arch_with_config('tutorial/rocket-p1.toml')

def do_tutorial_piccolo_arch_with_config(config_path):
    DIAGRAM_DIR = 'piccolo-arch'
    used_cached_ast = os.path.isdir('tutorial/piccolo/ast-cache')
    remove_dir_if_exists(DIAGRAM_DIR,
            'old Piccolo architecture diagrams')

    print('- Generate Graphviz architecture files')
    p = expect_program(('besspin-arch-extract', config_path, 'visualize'))
    pg = ProgressGroups([
        ProgressCounter(['Compiled %d BSV packages', 'wrote %d'], prefix='  - '),
        ProgressCounter(['Loaded %d packages'], prefix='  - '),
        ProgressCounter(['Rendered %d modules'], prefix='  - '),
    ])
    pg.start()
    p.add_handler(r'compiling.*\.bsv', pg.mk_counter(0, 0))
    p.add_handler(r'writing.*\.cbor', pg.mk_counter(0, 1))
    p.add_handler(r'loading package', pg.mk_counter(1, 0))
    p.add_handler(r'rendering module', pg.mk_counter(2, 0))
    p.expect('processing [0-9]+ structs')
    pg.report_special('  - Processing architecture...')
    p.expect(r'wrote [0-9]* graphviz files to %s/' % DIAGRAM_DIR)
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
    for f in os.listdir(DIAGRAM_DIR):
        path = os.path.join(DIAGRAM_DIR, f)
        stem, ext = os.path.splitext(path)
        assert ext == '.dot', 'unexpected file %r in %s' % (f, DIAGRAM_DIR)
        run_program(('dot', '-Tpdf', '-o', stem + '.pdf', path))
        pc.count(0)
    pc.finish()
    assert pc.counts[0] >= 30, 'expected at least 30 diagrams converted'

    example_path = os.path.join(DIAGRAM_DIR, 'Shifter_Box.mkShifter_Box.pdf')
    assert os.path.exists(example_path), 'Shifter_Box PDF diagram is missing'
    copy_output(example_path, [
        os.path.splitext(os.path.basename(config_path))[0],
        os.path.splitext(os.path.basename(example_path))[0],
    ])

def do_tutorial_rocket_arch_with_config(config_path):
    DIAGRAM_DIR = 'out'
    remove_dir_if_exists(DIAGRAM_DIR,
            'old rocket-p1 architecture diagrams')

    print('- Generate Graphviz architecture files')
    p = expect_program(('besspin-arch-extract', config_path, 'visualize'),
            timeout=300)
    pg = ProgressGroups([
        ProgressCounter(['Rendered %d modules'], prefix='  - '),
    ])
    # No pg.start() - only print "rendered N modules" once rendering begins
    pg.report_special('  - Loading modules...')
    p.add_handler(r'rendering module', pg.mk_counter(0, 0))
    p.expect(r'wrote [0-9]* graphviz files to %s/' % DIAGRAM_DIR)
    p.check_wait()
    pg.finish()
    assert pg.counters[0].counts[0] >= 30, 'expected at least 30 modules rendered'

    print('- Convert Graphviz files to PDF')
    pc = ProgressCounter(['Converted %d diagrams', '%d timed out'], prefix='  - ')
    for f in os.listdir(DIAGRAM_DIR):
        path = os.path.join(DIAGRAM_DIR, f)
        stem, ext = os.path.splitext(path)
        assert ext == '.dot', 'unexpected file %r in %s' % (f, DIAGRAM_DIR)
        p = expect_program(('dot', '-Tpdf', '-o', stem + '.pdf', path))
        r = p.expect([pexpect.EOF, pexpect.TIMEOUT], timeout=3)
        pc.count(r)
        assert p.terminate(force=True)
    pc.finish()
    assert pc.counts[0] >= 30, 'expected at least 30 diagrams converted'

    example_path = os.path.join(DIAGRAM_DIR, 'ALU.pdf')
    assert os.path.exists(example_path), 'ALU PDF diagram is missing'
    copy_output(example_path, [
        os.path.splitext(os.path.basename(config_path))[0],
        os.path.splitext(os.path.basename(example_path))[0],
    ])

def do_tutorial_feature():
    print('Feature model extraction')

    FMJSON_FILE = 'piccolo.fm.json'
    SIMPLIFIED_FILE = 'piccolo-simple.fm.json'
    CLAFER_FILE = 'piccolo.cfr'

    remove_file_if_exists(FMJSON_FILE, 'old Piccolo feature model')
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

    copy_output(SIMPLIFIED_FILE, 'piccolo-fm')
    copy_output(CLAFER_FILE, 'piccolo-fm')


if __name__ == '__main__':
    init_log_file_for_script(__file__)
    update_tool_suite()
    clone_piccolo()
    do_tutorial()
