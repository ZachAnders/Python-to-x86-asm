from ..debug import dbg
from .base import AbstractOperation, BasicOperation
from .helpers import LabelManager
from .helpers import call_func_asm, inject_int, inject_bool, inject_big
from .helpers import PYOBJ_TYPE, PYOBJ_TYPE_PTR, PYOBJ_TYPE_DEF
from .helpers import BIGOBJ_TYPE, BIGOBJ_TYPE_PTR, BIGOBJ_TYPE_DEF

class OpModule(BasicOperation):
    def __init__(self, *args, **kwargs):
        super(OpModule, self).__init__(*args, **kwargs)
        self.true = self.mem.allocate(name="True")
        self.false = self.mem.allocate(name="false")
    def write(self):
        true = self.mem.get(self.true)
        false = self.mem.get(self.false)
        return """
            @false = global i32 5, align 4
            @true = global i32 5, align 4
            @g = global {pyobj_t} {{ i32 1 }}, align 4
            @g = global {pyobj_t} {{ i32 1 }}, align 4
        """

class OpStmt(BasicOperation):
    def write(self):
        return """
        define i32 @main() {
            """

class OpNewConst(BasicOperation):
    HAS_OUTPUT_KEY = True
    def __init__(self, *args, **kwargs):
        super(OpNewConst, self).__init__(*args, **kwargs)
        #self.temp = self.mem.allocate()

    def write(self):
        label = self.mem.get(self.output_key)
        value = self.args[0]
        code = inject_int(value, label)

        return """
        {code}
            """.format(
                    code=code,
                    )

class OpAdd(BasicOperation):
    HAS_OUTPUT_KEY = True
    def __init__(self, *args, **kwargs):
        super(OpAdd, self).__init__(*args, **kwargs)
        self.left = self.args[0]
        self.right = self.args[1]
        self.temp_out = self.mem.allocate()
        self.temp_left = self.mem.allocate()
        self.temp_right = self.mem.allocate()
    
    def write(self):
        dbg.log(self.left)
        left = self.mem.get(self.left)
        right = self.mem.get(self.right)
        output = self.mem.get(self.output_key)

        temp = self.mem.get(self.temp_out)
        t_left = self.mem.get(self.temp_left)
        t_right = self.mem.get(self.temp_right)

        proj_left = call_func_asm('project_int',
                arguments=[(PYOBJ_TYPE_PTR, left)],
                output=('i32', t_left),
                )
        
        proj_right = call_func_asm('project_int',
                arguments=[(PYOBJ_TYPE_PTR, right)],
                output=('i32', t_right),
                )

        save_code = inject_int(temp, output)

        add_code = """
            {proj_left}
            {proj_right}
            {temp} = add i32 {temp_left}, {temp_right}
            {save}
        """.format(
                proj_left=proj_left,
                proj_right=proj_right,
                temp=temp,
                temp_left=t_left,
                temp_right=t_right,
                save=save_code,
                )

        return """
            {add_code}
        """.format(add_code=add_code)


class OpUnarySub(BasicOperation):
    HAS_OUTPUT_KEY = True
    def write(self):
        node = self.mem.get(self.args[0])
        output = self.mem.get(self.output_key)
        projected_output = self.mem.get(self.mem.allocate())
        op_output = self.mem.get(self.mem.allocate())

        load_code = call_func_asm('project_int',
                arguments=[(PYOBJ_TYPE_PTR, node)],
                output=('i32', projected_output),
                )

        save_code = inject_int(op_output, output)

        return """
            {load_code}
            {tmp_out} = sub i32 0, {node}
            {save_code}
        """.format(
                load_code=load_code,
                save_code=save_code,
                tmp_out=op_output,
                node=projected_output)

class OpCallFunc(BasicOperation):
    HAS_OUTPUT_KEY = True
    def write(self):
        output = self.mem.get(self.output_key)
        code = call_func_asm('input_int',
                output=(PYOBJ_TYPE, output))

        return """
            {output} = alloca {pyobj_t}
            {input_code}
            """.format(
                    input_code=code,
                    output=output,
                    pyobj_t=PYOBJ_TYPE,
                    )

class OpPrintnl(BasicOperation):
    HAS_OUTPUT_KEY = False
    def write(self):
        left = self.mem.get(self.args[0])
        return call_func_asm('print_any', arguments=[(PYOBJ_TYPE_PTR, left)])

class OpReturn(BasicOperation):
    HAS_OUTPUT_KEY = False
    def write(self):
        return """
        ret i32 0
    }
        """

class OpAssign(AbstractOperation):
    def __init__(self, mem, name, value_ref):
        self.mem = mem
        self.name = name
        self.value_ref = value_ref

        self.alloc_var = mem.allocate(name)
        self.output = self.mem.allocate(name)

    def write(self):
        output = self.mem.get(self.output)
        value_ref = self.mem.get(self.value_ref)
        if not self.output.allocated:
            self.output.allocated = True
            allocator = "{output} = alloca {pyobj_t}".format(
                    output=output, pyobj_t=PYOBJ_TYPE)
        else:
            allocator = ""
        copy_code = call_func_asm("copy",
                arguments=[(PYOBJ_TYPE_PTR + " byval", value_ref)],
                output=(PYOBJ_TYPE, output))
        return """
            {allocator}
            {copy_code}
        """.format(
                allocator=allocator,
                copy_code=copy_code,
                )

class OpLabel(AbstractOperation):
    def __init__(self, label_name):
        self.label = label_name
    def write(self):
        return self.label + ":"

class OpDeclarations(BasicOperation):
    def write(self):
        return """
        ; C runtime method declarations below

        declare i32 @tag(%struct.base_pyobj* byval align 8)
        declare void @copy(%struct.base_pyobj* sret, %struct.base_pyobj* byval align 8)
        declare i32 @is_int(%struct.base_pyobj* byval align 8)
        declare i32 @is_bool(%struct.base_pyobj* byval align 8)
        declare i32 @is_big(%struct.base_pyobj* byval align 8)
        declare i32 @is_function(%struct.base_pyobj* byval align 8)
        declare i32 @is_object(%struct.base_pyobj* byval align 8)
        declare i32 @is_class(%struct.base_pyobj* byval align 8)
        declare i32 @is_unbound_method(%struct.base_pyobj* byval align 8)
        declare i32 @is_bound_method(%struct.base_pyobj* byval align 8)
        declare void @inject_int(%struct.base_pyobj* sret, i32)
        declare void @inject_bool(%struct.base_pyobj* sret, i32)
        declare void @inject_big(%struct.base_pyobj* sret, %struct.pyobj_struct*)
        declare i32 @project_int(%struct.base_pyobj* byval align 8)
        declare i32 @project_bool(%struct.base_pyobj* byval align 8)
        declare %struct.pyobj_struct* @project_big(%struct.base_pyobj* byval align 8)
        declare i32 @is_true(%struct.base_pyobj* byval align 8)
        declare void @print_any(%struct.base_pyobj* byval align 8)
        declare void @input_int(%struct.base_pyobj* sret)
        declare %struct.pyobj_struct* @create_list(%struct.base_pyobj* byval align 8)
        declare %struct.pyobj_struct* @create_dict()
        declare void @set_subscript(%struct.base_pyobj* sret, %struct.base_pyobj* byval align 8, %struct.base_pyobj* byval align 8, %struct.base_pyobj* byval align 8)
        declare void @get_subscript(%struct.base_pyobj* sret, %struct.base_pyobj* byval align 8, %struct.base_pyobj* byval align 8)
        declare %struct.pyobj_struct* @add(%struct.pyobj_struct*, %struct.pyobj_struct*)
        declare i32 @equal(%struct.pyobj_struct*, %struct.pyobj_struct*)
        declare i32 @not_equal(%struct.pyobj_struct*, %struct.pyobj_struct*)

        ; Struct declarations below

        {pyobj_def}
        {bigobj_def}
            """.format(
                    pyobj_def=PYOBJ_TYPE_DEF,
                    bigobj_def=BIGOBJ_TYPE_DEF,
                    )
