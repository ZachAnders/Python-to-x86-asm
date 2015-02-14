import sys, os

from python_compiler.debug import dbg
from python_compiler.parser import lex

from python_compiler.compiler_main.py_compiler import Compiler


"""
Rudimentary main function.

Run like this:

    python main.py <testfiletocompile.py>
        [Spits out ASM to stdout]
"""

if __name__ == '__main__':
#dbg.log.enable()
    test_file = sys.argv[1]

    my_compiler = Compiler()

    my_compiler.compileFile(filename=test_file)

#    dispatcher = Dispatcher()
#
#    with open(test_file, "r") as in_f:
#        data = in_f.read()
#
#    ast = compiler.parse(data)
#
#    dispatcher.dispatch(ast)
#
#    filename = os.path.basename(test_file)[:-3] + ".s"
#
#    dispatcher.writeOut(fname=filename)
