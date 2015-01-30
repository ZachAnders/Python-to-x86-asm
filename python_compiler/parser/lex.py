import ply.lex as lex
import ply.yacc as yacc
from compiler.ast import *

class Input():
    def __init__(self, *args):
        self.args = args
    def __repr__(self):
        args = " ".join([arg for arg in self.args])
        return "Input({args})".format(args=args)

# Lexer
tokens = (
    'PRINT',
    'INPUT', 
    'INT',
    'PLUS',
    'EQUALS', 
    'NAME',
    'UMINUS',
    'LPAREN',
    'RPAREN',
)

# Regular expression rules for tokens
t_PRINT = r'print'
t_INPUT = r'input'
t_PLUS = r'\+'
t_UMINUS = r'-'
t_EQUALS = r'='
t_LPAREN = r'\('
t_RPAREN = r'\)'

def t_NAME(t):
    '[a-zA-Z][a-zA-Z]*'
    return t

#t_NAME = r'[a-zA-Z]+'
#t_NAME = r'a.*'

def t_INT(t):
    r'\d+'
    try:
        t.value = int(t.value)
    except ValueError:
        print "integer value too large", t.value
        t.value = 0
    return t

t_ignore = ' \t'

def t_newline(t):
    r'\n+'
    t.lexer.lineno += t.value.count("\n")

def t_error(t):
    print "Illegal character '%s'" % t.value[0]
    t.lexer.skip(1)

lex.lex()

# Parser
precedence = (
        ('nonassoc','PRINT'),
        ('left','PLUS'),
        ('right','UMINUS')
        )

# Statement
def p_print_statement(t):
    'statement : PRINT expression'
    t[0] = Printnl([t[2]], None)

def p_Assign_statement(t):
    'statement : NAME EQUALS expression'
    t[0] = Assign(t[1], t[3])

def p_discard_statement(t):
    'statement : expression'
    t[0] = Discard(t[1])

# Expression       
def p_plus_expression(t):
    'expression : expression PLUS expression'
    t[0] = Add((t[1], t[3]))
    
def p_name_expression(t):
    'expression : NAME'
    t[0] = Name(t[1])

def p_int_expression(t):
    'expression : INT'
    t[0] = Const(t[1])

def p_group_expression(t):
    'expression : LPAREN expression RPAREN'
    t[0] =t[2]

def p_input_expression(t):
    'expression : INPUT LPAREN RPAREN'
    t[0] = Input()

def p_unarysub_expression(t):
    'expression : UMINUS expression'
    t[0] = UnarySub(t[2])

def p_error(t):
    print "Syntax error at '%s'" % t.value

yacc.yacc()
print yacc.parse("print abc")
