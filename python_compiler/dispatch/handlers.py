from ..operations.x86 import OpAdd, OpModule, OpStmt, OpPrintnl, OpAssign
from ..operations.x86 import OpCallFunc, OpUnarySub, OpNewConst, OpReturn, OpJumpOnBool
from ..operations.x86 import OpBoolSetCondition, OpList, OpLabel, OpJumpOnSame, OpJumpOnTag, OpJump, OpDict
from ..operations.x86 import OpSetSubscript, OpSubscript, OpIs, OpNot, OpPrimEquals, OpBigEquals
from ..operations.x86 import OpDirectAssign, OpIfExpr
from ..operations.helpers import LabelManager, CONST
from compiler.ast import Subscript

class Handler():
    def __init__(self, dispatcher, mem, instrWriter):
        self.mem = mem
        self.instrWriter = instrWriter
        self.dispatcher = dispatcher

    def doAdd(self, ast):
        # Lables:
        label_type = LabelManager.newLabel("type_set_same")
        label_list = LabelManager.newLabel("list_addition")
        label_end = LabelManager.newLabel("end_addition")

        # Execute Left and Right
        left = self.dispatcher.dispatch(ast.left)
        right = self.dispatcher.dispatch(ast.right)
        
        # Check if both are the same Type:
        jump_type = OpJumpOnSame(self.mem, left, right, label_type)
        self.instrWriter.write(jump_type)

        # TODO: Error
        self.instrWriter.write(OpLabel(label_type))

        # Check if list:
        jump_list = OpJumpOnTag(self.mem, left, label_list, 'big', isTag=True)
        self.instrWriter.write(jump_list)

        # Int addition
        op_add = OpAdd(self.mem, left, right, is_int=True)
        self.instrWriter.write(op_add)
        self.instrWriter.write(OpJump(label_end))

        # GOTO: END

        self.instrWriter.write(OpLabel(label_list))

        op = OpAdd(self.mem, left, right,
                is_int=False, output_key=op_add.output_key)
        self.instrWriter.write(op)

        self.instrWriter.write(OpLabel(label_end))

        return op_add.output_key
        
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
            if isinstance(name, Subscript):
                pyobj = self.dispatcher.dispatch(name.expr)
                key = self.dispatcher.dispatch(name.subs[0])
                # pyobj[key] = value_ref
                op = OpSetSubscript(self.mem, pyobj, key, value_ref)

                #Subscript
            else:
                #AssName
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
        if ast.name == "True":
            op = OpNewConst(self.mem, 1, tag='BOOL')
            self.instrWriter.write(op)
            return op.output_key
        elif ast.name == "False":
            op = OpNewConst(self.mem, 0, tag='BOOL')
            self.instrWriter.write(op)
            return op.output_key

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
        nodes = [(self.dispatcher.dispatch(item[0]),
            self.dispatcher.dispatch(item[1])) for item in ast.items]

        op = OpDict(self.mem, nodes)
        self.instrWriter.write(op)
        return op.output_key

    def doOr(self, ast):
        # Labels:
        label_true = LabelManager.newLabel("or_set_true")
        label_end = LabelManager.newLabel("end")

        left = self.dispatcher.dispatch(ast.nodes[0])

        # Check left, jump if true
        jump_true = OpJumpOnBool(self.mem, left, label_true, boolean=True)
        self.instrWriter.write(jump_true)

        # Execute Right
        right = self.dispatcher.dispatch(ast.nodes[1])

        op = OpBoolSetCondition(self.mem,
                left, right,
                label_true, label_end)

        self.instrWriter.write(op)

        return op.output_key
        
        """
        r1 = exec e1
        if r1 = true jump set_true

        r2 = exec r2
        r3 = r2
        jump end

        set_true:
        r3 = r1

        end:

        """
        
        #right = self.dispatcher.dispatch(ast.right)
        #op = OpOr(self.mem, left, right)
        #self.instrWriter.write(op)
        #return op.output_key
    
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
        left = self.dispatcher.dispatch(ast.expr)
        ops = ast.ops[0]
        val = self.dispatcher.dispatch(ops[1])

        if ops[0] == 'is':
            op = OpIs(self.mem, left, val)
        elif ops[0] == '==' or ops[0] == "!=":
            shouldInvert = '!' in ops[0]

            dobig_label = LabelManager.newLabel('op_eq_bothbig')
            false_label = LabelManager.newLabel('op_eq_false')
            true_label = LabelManager.newLabel('op_eq_true')
            end_label = LabelManager.newLabel('op_eq_end')
            
            left_big = OpJumpOnTag(self.mem, left, dobig_label, 'BIG')
            self.instrWriter.write(left_big)

            # Left was NOT big. If Right is big, jump to false
            right_big = OpJumpOnTag(self.mem, val, false_label, 'BIG')
            self.instrWriter.write(right_big)

            # Neither were big. We project and compare
            op = OpPrimEquals(self.mem, left, val, invert=shouldInvert)
            self.instrWriter.write(op)
            self.instrWriter.write(OpJump(end_label))

            # Label for comparing
            self.instrWriter.write(OpLabel(dobig_label))

            both_objs = OpJumpOnTag(self.mem, val, false_label, 'BIG', isTag=False)
            self.instrWriter.write(both_objs)

            op2 = OpBigEquals(self.mem, left, val, invert=shouldInvert, output_key=op.output_key)
            self.instrWriter.write(op2)
            self.instrWriter.write(OpJump(end_label))

            self.instrWriter.write(OpLabel(false_label))
            opFalse = OpDirectAssign(self.mem, op.output_key, CONST(shouldInvert, tag="BOOL"))
            self.instrWriter.write(opFalse)

            self.instrWriter.write(OpJump(end_label))

            self.instrWriter.write(OpLabel(true_label))
            # SET op.output_key = True
            opTrue = OpDirectAssign(self.mem, op.output_key, CONST(not shouldInvert, tag="BOOL"))
            self.instrWriter.write(opTrue)

            self.instrWriter.write(OpLabel(end_label))

            return op.output_key

            """
                r1 = exec e1
                r2 = exec 2
                if r1.tag == BIG jump DOBIG
                if r2.tag == BIG jump FALSE

||                r2 >> 2
||                r1 >> 2
||
||                r3 = r1 == r2
                jump END

                DOBIG:
                if r2.tag != BIG jump FALSE
||                call is_equal(r1, r2)
||                r3 = eax
||                jump END
||
||
||                FALSE:
||                    r3 = false
||                    jump END
||                TRUE:
||                    r3 = true
||                    jump END
  
                  END:
                    

            """
            pass
        elif ops[0] == '!=':
            pass

        self.instrWriter.write(op)
        #(middle, right) = self.dispatcher.dispatch(ast.right)
        #op = OpCompare(self.mem, left, middle, right)
        #self.instrWriter.write(op)

        return op.output_key


    def doNot(self, ast):
        node = self.dispatcher.dispatch(ast.expr)

        op = OpNot(self.mem, node)
        self.instrWriter.write(op)

        return op.output_key

    def doSubscript(self, ast):
        key, pyobj = self.dispatcher.dispatch(ast.subs[0]), self.dispatcher.dispatch(ast.expr)

        op = OpSubscript(self.mem, pyobj, key)
        self.instrWriter.write(op)

        return op.output_key

    def doIfExp(self, ast):
        test = self.dispatcher.dispatch(ast.test)
        then = LabelManager.newLabel('ifexp_then')
        end = LabelManager.newLabel('ifexp_end')

        op = OpIfExpr(self.mem, test)
        self.instrWriter.write(op)
        out_var = op.output_key

        branch = OpJumpOnBool(self.mem, test, then)
        self.instrWriter.write(branch)

        val1 = self.dispatcher.dispatch(ast.else_)
        copy1 = OpDirectAssign(self.mem, out_var, val1, value_is_const=False)
        self.instrWriter.write(copy1)

        self.instrWriter.write(OpJump(end))

        self.instrWriter.write(OpLabel(then))
        val2 = self.dispatcher.dispatch(ast.then)
        copy2 = OpDirectAssign(self.mem, out_var, val2, value_is_const=False)
        self.instrWriter.write(copy2)

        self.instrWriter.write(OpLabel(end))

        return out_var
