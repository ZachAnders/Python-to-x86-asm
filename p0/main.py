import sys, os

from python_compiler.dispatch.dispatcher import Dispatcher
from python_compiler.debug import dbg

import compiler

"""
Rudimentary main function.

Run like this:

    python main.py <testfiletocompile.py>
        [Spits out ASM to stdout]
"""

dbg.log.enable()

test_file = sys.argv[1]

dispatcher = Dispatcher()

with open(test_file, "r") as in_f:
    data = in_f.read()

ast = compiler.parse(data)

dbg.log("Parsing AST:", ast)

dispatcher.dispatch(ast)

filename = os.path.basename(test_file)[:-3] + ".s"

val = dispatcher.writeOut(fname=filename)

print "Final code:"
print val
