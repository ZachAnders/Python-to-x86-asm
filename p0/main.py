import sys

from python_compiler.dispatch.dispatcher import Dispatcher
from python_compiler.debug import dbg

import compiler

test_file = "test.py"

dispatcher = Dispatcher()

with open(test_file, "r") as in_f:
    data = in_f.read()

ast = compiler.parse(data)

dbg.log("Parsing AST:", ast)

dispatcher.dispatch(ast)
