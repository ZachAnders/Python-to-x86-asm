import sys

from python_compiler.dispatch.dispatcher import Dispatcher
from python_compiler.debug import dbg

import compiler

"""
Rudimentary main function.

Run like this:

    python main.py <testfiletocompile.py>
        [Spits out ASM to stdout]
"""

#dbg.log.enable()

test_file = sys.argv[1]

dispatcher = Dispatcher()

with open(test_file, "r") as in_f:
    data = in_f.read()

ast = compiler.parse(data)

dbg.log("Parsing AST:", ast)

dispatcher.dispatch(ast)

val = dispatcher.writeOut()

print "Final code:"
print val
