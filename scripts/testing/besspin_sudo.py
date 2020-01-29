import importlib
import io
import os
import pickle
import runpy
import shlex
import socket
import subprocess
import sys
import tempfile
import threading
import types

import besspin_testing


def _call_with_python_wrapper(callback, func, args, kwargs):

    server = HostServer(func, args, kwargs)
    server.start()
    server.ready.wait()

    cmd = callback((__file__, 'bootstrap', server.sock_path))
    proc = subprocess.Popen(cmd)
    proc.wait()

    server.join()
    if server.exc is not None:
        raise server.exc
    return server.result

def call_with_sudo(func, *args, **kwargs):
    '''Invoke `func` in a separate Python process, running as superuser via
    `sudo`.  `func` must be a top-level function, accessible via
    `func.__module__` and `func.__name__`.  Communication is handled via
    `pickle`, so `args` and `kwargs` must contain only pickleable values, and
    the return value of `func` must also be pickleable.

    In the subprocess, `besspin_testing.LOG_FILE` will be a file-like object
    that forwards all output to the `LOG_FILE` of the parent process.
    '''
    return _call_with_python_wrapper(
            lambda args: ('sudo', '-E', sys.executable) + args,
            func, args, kwargs)

def call_with_nix_shell(path, func, *args, **kwargs):
    '''Invoke `func` within `nix-shell <path>`.  The same requirements apply as
    for `call_with_sudo`, but `func` runs under a nix shell instead of under
    `sudo`.'''
    def wrapper_callback(args):
        cmd_str = ' '.join(shlex.quote(x) for x in (sys.executable,) + args)
        return ('nix-shell', path, '--run', cmd_str)
    return _call_with_python_wrapper(wrapper_callback, func, args, kwargs) 


_OP_INIT = 0
_OP_LOG = 1
_OP_FLUSH = 2
_OP_RESULT = 3
_OP_EXC = 4

class HostServer(threading.Thread):
    def __init__(self, func, args, kwargs):
        super(HostServer, self).__init__()

        self.func = func
        self.args = args
        self.kwargs = kwargs

        self.tempdir = tempfile.TemporaryDirectory()
        self.sock_path = os.path.join(self.tempdir.name, 'python.socket')
        self.ready = threading.Event()
        self.result = None
        self.exc = None

        self.daemon = True

    def run(self):
        server_sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        server_sock.bind(self.sock_path)
        server_sock.listen(1)
        self.ready.set()
        sock, _ = server_sock.accept()
        fr = sock.makefile(mode='rb', buffering=io.DEFAULT_BUFFER_SIZE)
        fw = sock.makefile(mode='wb', buffering=io.DEFAULT_BUFFER_SIZE)

        main_module_file = None
        if self.func.__module__ == '__main__':
            main_module_file = sys.modules['__main__'].__file__

        pickle.dump((_OP_INIT, (
            sys.path, main_module_file, besspin_testing.LOG_FILE_NAME,
            self.func.__module__, self.func.__name__, self.args, self.kwargs,
        )), fw)
        fw.flush()

        while True:
            try:
                op, val = pickle.load(fr)
            except EOFError as e:
                self.exc = e
                break
            if op == _OP_LOG:
                besspin_testing.LOG_FILE_RAW.write(val)
            elif op == _OP_FLUSH:
                besspin_testing.LOG_FILE_RAW.flush()
            elif op == _OP_RESULT:
                self.result = val
                break
            elif op == _OP_EXC:
                self.exc = val
                break
            else:
                raise ValueError('bad opcode %s' % op)

        fr.close()
        fw.close()


def _sudo_main(sock_path):
    sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    sock.connect(sock_path)
    fr = sock.makefile(mode='rb', buffering=io.DEFAULT_BUFFER_SIZE)
    fw = sock.makefile(mode='wb', buffering=io.DEFAULT_BUFFER_SIZE)

    op, val = pickle.load(fr)
    if op != _OP_INIT:
        raise ValueError('expected INIT message, but got %s' % op)
    sys_path, main_module_file, log_file_name, func_module, func_name, args, kwargs = val

    sys.path = sys_path
    if main_module_file is not None:
        # Run the main script under an alternate module name, to avoid
        # triggering its `if __name__ == '__main__'` block.
        mod = types.ModuleType("__sudo_main__")
        dct = runpy.run_path(main_module_file, run_name=mod.__name__)
        mod.__dict__.update(dct)
        sys.modules[mod.__name__] = mod
        sys.modules['__main__'] = mod
    mod = importlib.import_module(func_module)
    func = getattr(mod, func_name)

    buffered = io.BufferedWriter(RemoteFile(fw))
    besspin_testing.init_log_file_raw(log_file_name, buffered)

    try:
        result = func(*args, **kwargs)
        pickle.dump((_OP_RESULT, result), fw)
    except Exception as e:
        pickle.dump((_OP_EXC, e), fw)
    fw.flush()

class RemoteFile(io.RawIOBase):
    def __init__(self, f):
        self.f = f

    def writable(self):
        return True

    def write(self, b):
        if not isinstance(b, bytes):
            b = bytes(b)
        pickle.dump((_OP_LOG, b), self.f)
        return len(b)

    def flush(self):
        pickle.dump((_OP_FLUSH, None), self.f)
        self.f.flush()


if __name__ == '__main__':
    # NB: This is NOT the sort of testing or script code you might normally see
    # at the bottom of a python module!  Instead, it is the entry point for the
    # superuser subprocess, which is used to bootstrap.
    assert len(sys.argv) == 3
    assert sys.argv[1] == 'bootstrap'
    _sudo_main(sys.argv[2])

