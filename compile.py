import sys, os

from python_compiler.dispatch.dispatcher import Dispatcher
from python_compiler.debug import dbg
from python_compiler.parser import lex

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
dispatcher2 = Dispatcher()

with open(test_file, "r") as in_f:
    data = in_f.read()

#if "paren-test" in test_file:
#    raise RuntimeError("Failed to compile:" + data)

ast = lex.yacc.parse(data)
#print ast
#ast2 = compiler.parse(data)

#print "Ours:\n" , str(ast)
#print "Official:\n" , str(ast2)

#if str(ast) == str(ast2):
#    print "MATCHES"

dbg.log("Parsing AST:", ast)

dispatcher.dispatch(ast)
#dispatcher2.dispatch(ast)

filename = os.path.basename(test_file)[:-3] + ".s"
#filename2 = os.path.basename(test_file)[:-3] + "_good.s"

dispatcher.writeOut(fname=filename)
#dispatcher2.writeOut(fname=filename2)
