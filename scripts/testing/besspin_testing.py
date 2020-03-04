import io
import os
import subprocess
import sys


LOG_FILE_NAME = '/dev/stderr'
LOG_FILE_RAW = sys.stderr.buffer
LOG_FILE = sys.stderr

_real_print = print

def lprint(*args, **kwargs):
    '''Print a message to the log file.'''
    kwargs['file'] = LOG_FILE
    kwargs['flush'] = True
    return _real_print(*args, **kwargs)

def print(*args, **kwargs):
    '''Print a message to both stdout and the log file.'''
    _real_print(*args, **kwargs)
    lprint(*args, **kwargs)

def init_log_file(path):
    init_log_file_raw(path, open(path, 'wb'))

def init_log_file_for_script(path):
    name, _ = os.path.splitext(os.path.basename(path))
    init_log_file('testing_%s.log' % name)

def init_log_file_raw(name, raw):
    global LOG_FILE_NAME, LOG_FILE_RAW, LOG_FILE
    LOG_FILE_NAME = name
    LOG_FILE_RAW = raw
    LOG_FILE = io.TextIOWrapper(LOG_FILE_RAW)


def run_program(args):
    lprint(' >>> Running program %s' % (args,))
    proc = subprocess.run(args, check=True, stdout=LOG_FILE, stderr=LOG_FILE)
    lprint(' >>> %s exited with code %d' % (args[0], proc.returncode))


class cwd:
    def __init__(self, path):
        self.path = os.path.abspath(path)
        self.prev_path = None

    def __enter__(self):
        assert self.prev_path is None, 'cannot reuse cwd context object'
        self.prev_path = os.getcwd()
        os.chdir(self.path)

    def __exit__(self, exc_type, exc_value, traceback):
        assert os.path.samefile(os.getcwd(), self.path), \
                'working directory changed inside `with cwd` block'
        os.chdir(self.prev_path)
