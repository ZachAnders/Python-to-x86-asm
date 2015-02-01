import sys, os

from python_compiler.dispatch.dispatcher import Dispatcher
from python_compiler.debug import dbg
from python_compiler.parser import lex

#import compiler

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

#ast = compiler.parse(data)
ast = lex.yacc.parse(data)

dbg.log("Parsing AST:", ast)

dispatcher.dispatch(ast)

filename = os.path.basename(test_file)[:-3] + ".s"

dispatcher.writeOut(fname=filename)
