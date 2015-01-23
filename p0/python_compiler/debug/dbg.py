""" Little debug log. """

import inspect
import os

class __logger__():
    def __init__(self):
        self.enabled = False
    def __call__(self, *args, **kwargs):
        if self.enabled:
            frame = inspect.stack()[1]
            out = lambda x: os.sys.stdout.write(str(x))
            self.print_frame(frame)
            out(" ".join([str(i) for i in args]))
            out("\n")
    def enable(self):
        self.enabled = True

    def disable(self):
        self.enabled = False

    def printstack(self):
        if self.enabled:
            for frame in inspect.stack():
                self.print_frame(frame)
                print

    def print_frame(self, frame):
        _, fullname, lnum, fun_name, _, _ = frame
        fname = os.path.basename(fullname)
        out = lambda x: os.sys.stdout.write(str(x))
        out("<")
        out(fun_name)
        out("() in ")
        out(fname)
        out(":")
        out(lnum)
        out("> ")

log = __logger__()
