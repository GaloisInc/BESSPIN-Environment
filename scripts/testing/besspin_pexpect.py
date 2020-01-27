import getpass
import pexpect
import re

import besspin_testing
from besspin_testing import print, lprint


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

    def send_password_line(self, pw):
        real_logfile = self.logfile
        self.logfile = None
        self.sendline(pw)
        if real_logfile is not None:
            real_logfile.write(b'[password hidden]\n')
        self.logfile = real_logfile

def expect_program(args, **kwargs):
    lprint(' >>> Start interactive program %s' % (args,))
    return ExpectAuto(args[0], list(args[1:]), logfile=besspin_testing.LOG_FILE_RAW, **kwargs)

def interact_program(args, **kwargs):
    lprint(' >>> Running program %s with passthrough' % (args,))
    p = expect_program(args, **kwargs)
    p.interact()
    p.check_wait()
    lprint(' >>> %s exited successfully' % (args[0],))


def forward_prompt(p, reason=None):
    '''Forward a prompt to the user of the script.  Intended to be used like:

        p.add_handler(r'Continue\? ', forward_prompt)

    Then if the subprocess `p` outputs the prompt 'Continue?', the script will
    output the same prompt and relay the user's answer back to the subprocess.
    '''
    if reason is not None:
        print(reason)
    prompt = p.match.group().decode()
    response = input(prompt)
    p.sendline(response)

def forward_password_prompt(p, reason=None):
    '''Forward a password prompt to the user of the script.  Expects the
    subprocess `p` to disable echo after printing the prompt.  The user's
    response is read without echoing, and is relayed to `p` without writing it
    to `p.logfile`.'''
    assert p.waitnoecho(), 'timeout while waiting for password prompt'
    if reason is not None:
        print(reason)
    prompt = (p.after + p.buffer).decode()
    pw = getpass.getpass(prompt)
    p.send_password_line(pw)


def add_sudo_password_handler(p, reason=None):
    if reason is not None:
        reason = 'Superuser privileges are required %s' % reason
    p.add_handler(r'\[sudo\] password', lambda p: forward_password_prompt(p, reason=reason))

SSH_HOST_KEY_PROMPT_REGEX = re.compile(
    br'''The authenticity of host '[^']*' can't be established.\r\n'''
    br'''[^\r\n]* key fingerprint is [^.]*\.\r\n'''
    br'''Are you sure you want to continue connecting \(yes/no\)\? '''
)

def add_ssh_host_key_handler(p):
    p.add_handler(SSH_HOST_KEY_PROMPT_REGEX, forward_prompt)

GIT_PASSWORD_PROMPT_REGEX = re.compile(
    br'''Password for '(https?|git)://[^']*': '''
)

def add_git_password_handler(p):
    p.add_handler(GIT_PASSWORD_PROMPT_REGEX, forward_password_prompt)
