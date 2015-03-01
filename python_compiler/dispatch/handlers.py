from ..operations.x86 import OpAdd, OpModule, OpStmt, OpPrintnl, OpAssign
from ..operations.x86 import OpCallFunc, OpUnarySub, OpNewConst, OpReturn, OpJumpOnBool
from ..operations.x86 import OpBoolSetCondition, OpList
from ..operations.polymorphism import OpIsBig
from ..operations.helpers import LabelManager

class Handler():
    def __init__(self, dispatcher, mem, instrWriter):
        self.mem = mem
        self.instrWriter = instrWriter
        self.dispatcher = dispatcher

    def doAdd(self, ast):
        # Lables:
        label_type = LabelManager.newLabel("type_set_same")
        label_list = LabelManager.newLabel("list_addition")
        label_int = LabelManager.newLabel("int_addition")

        # Execute Left and Right
        left = self.dispatcher.dispatch(ast.left)
        right = self.dispatcher.dispatch(ast.right)
        
        # Check if both are the same Type:
        jump_type = OpJumpOnSame(self.mem, left, right, label_type)
        self.instrWriter.write(jump_type)

        # Check if list:
        jump_list = OpJumpOnTag(self.mem, left, label_list, 'big', isTag=True)
        
        # Handle Addition:
        #op = OpAdd(self.mem, left, right)

        op = OpAddNew(self.mem, left, right, label_list, lable_int)
        """
            - Call Function list_add for label_list
            - Perform a regular add for lable_int
        """
        """both_lists = OpAnd(OpIsBig(left), OpIsBig(right))

        do_ints = OpIntAdd(left, right)
        do_lists = OpListAdd(left, right)

        result = self.doBranch(both_lists, do_lists, do_ints)"""

        return result
        
    def doModule(self, ast):
        op = OpModule(self.mem)
        self.instrWriter.write(op)
        _ = self.dispatcher.dispatch(ast.node)
        return None

    def doStmt(self, ast):
        op = OpStmt(self.mem)
        self.instrWriter.write(op)
        _ = self.dispatcher.dispatch_many(ast)
        ret = OpReturn(self.mem)
        self.mem.finalize()
        self.instrWriter.write(ret)
        return None

    def doPrintnl(self, ast):
        items = self.dispatcher.dispatch_many(ast)
        # l: value to print, r: destination to print to
        for node in items:
            op = OpPrintnl(self.mem, node)
            self.instrWriter.write(op)
        return None
    
    def doCallFunc(self, ast):
        name = self.dispatcher.dispatch(ast.node)
        #args[self.dispatcher.dispatch(arg) for arg in ast.args] 

        """
        CallFunc(Name(''), [], None, None))
        First is name of function
        Second is arguments
        Unsure about last two
        """
        op = OpCallFunc(self.mem, name)
        self.instrWriter.write(op)
        return op.output_key
                    
    def doAssign(self, ast):
        names, value_ref = ast.nodes, self.dispatcher.dispatch(ast.expr)
        for name in names:
            op = OpAssign(self.mem, name.name, value_ref)
            self.instrWriter.write(op)
        return None

    def doDiscard(self, ast):
        _ = self.dispatcher.dispatch(ast.expr)
        return None

    def doConst(self, ast):
        # No dispatch on const decls
        op = OpNewConst(self.mem, ast.value)
        self.instrWriter.write(op)
        return op.output_key

    def doName(self, ast):
        #left, right = self.dispatcher.dispatch_many(self, ast)
        #op = OpAdd(self.mem, left, right)
        #self.instrWriter.write(op)

        # Return NameIdentifier
        return self.mem.getReference(ast.name)

    def doUnarySub(self, ast):
        node = self.dispatcher.dispatch(ast.expr)
        op = OpUnarySub(self.mem, node)
        self.instrWriter.write(op)
        return op.output_key

    def doList(self, ast):
        nodes = [self.dispatcher.dispatch(item) for item in ast.nodes]
        op = OpList(self.mem, nodes)
        self.instrWriter.write(op)
        return op.output_key 
    
    def doDict(self, ast):
        # Uses a tuple
        nodes = [(self.dispatcher.dispatch(ast.left), self.dispatcher.dispatch(ast.right)) for item in ast.expr]
        op = OpDict(self.mem, nodes)
        self.instrWriter.write(op)
        return op.output_key

    def doOr(self, ast):
        left = self.dispatcher.dispatch(ast.left)
        right = self.dispatcher.dispatch(ast.right)
        op = OpOr(self.mem, left, right)
        self.instrWriter.write(op)
        return op.output_key
    
    def doAnd(self, ast):
        # Labels:
        label_false = LabelManager.newLabel("and_set_false")
        label_end = LabelManager.newLabel("and_end")

        # Execute Left
        left = self.dispatcher.dispatch(ast.nodes[0])

        # Check left, jump if False
        jump_false = OpJumpOnBool(self.mem, left, label_false, boolean=False)
        self.instrWriter.write(jump_false)

        # Execute Right
        right = self.dispatcher.dispatch(ast.nodes[1])

        op = OpBoolSetCondition(self.mem,
                left, right,
                label_false, label_end)
        self.instrWriter.write(op)

        return op.output_key

    def doCompare(self, ast):
    # Compare(expr, [(OP, expr)] )
        left = self.dispatcher.dispatch(ast.left)
        (middle, right) = self.dispatcher.dispatch(ast.right)
        op = OpCompare(self.mem, left, middle, right)
        self.instrWriter.write(op)
        return op.output_key


    def doNot(self, ast):
        node = self.dispatcher.dispatch(ast.expr)
        op = OpNot(self.mem, node)
        self.instrWriter.write(op)
        return op.output_key

    def doSubscript(self, ast):
    # Subscript(Name('Var'), 'OP_APPLY', [Const(5)])
        names, apply_typ, value_ref = ast.nodes, ast.nodes, self.dispatcher.dispatch(ast.expr)
        for name in names:
            op = OpSubscript(self.mem, name.name, value_ref)
            self.instrWriter.write(op)
        return op.output_key

    """def doIfExp(self, ast):"""


