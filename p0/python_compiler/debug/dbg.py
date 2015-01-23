""" Little debug log. """

import inspect
import os

class __logger__():
    def __init__(self):
        self.enabled = False
    def __call__(self, *args, **kwargs):
        if self.enabled:
            _, fullname, lnum, fun_name, _, _ = inspect.stack()[1]
            fname = os.path.basename(fullname)
            out = lambda x: os.sys.stdout.write(str(x))
            out("<")
            out(fun_name)
            out("() in ")
            out(fname)
            out(":")
            out(lnum)
            out("> ")
            out(" ".join([str(i) for i in args]))
            out("\n")
    def enable(self):
        self.enabled = True

    def disable(self):
        self.enabled = False

log = __logger__()
