"""
    LLVM IR related helper functions.

"""

PYOBJ_TYPE = "%struct.base_pyobj"
PYOBJ_TYPE_PTR = PYOBJ_TYPE + "*"
PYOBJ_TYPE_DEF = "%struct.base_pyobj = type { i64, i8*, i8 }"

BIGOBJ_TYPE = "%struct.pyobj_struct"
BIGOBJ_TYPE_PTR = BIGOBJ_TYPE + "*"
BIGOBJ_TYPE_DEF = """
%struct.pyobj_struct = type { i32, %union.anon }
%union.anon = type { %struct.bound_method_struct }
%struct.bound_method_struct = type { %struct.fun_struct, %struct.object_struct }
%struct.fun_struct = type { i8*, %struct.base_pyobj }
%struct.object_struct = type { %struct.hashtable*, %struct.class_struct }
%struct.hashtable = type { i32, %struct.entry**, i32, i32, i32, i32 (i8*)*, i32 (i8*, i8*)* }
%struct.entry = type { i8*, i8*, i32, %struct.entry* }
%struct.class_struct = type { %struct.hashtable*, i32, %struct.class_struct* }
"""

def call_func_asm(funcname, arguments=None, output=None):
    """
        funcname: Name of function (String)
        arguments: List of (type, allocations) List( (type, Allocation) )
        output: Function return destination (type, Allocation)
    """
    if arguments == None:
        arguments = []

    assert isinstance(arguments, list), "Arguments must be lists, not " + str(type(arguments))
    if output:
        assert isinstance(output, tuple), "Output must by tuple (type, variable)!"

    if output:
        ret_type = output[0]
        ret_var = output[1]
        if ret_type.startswith("%struct") and not ret_type.endswith("*"):
            # Need to pass return struct as first arg, with sret
            arguments.insert(0, (ret_type + "* sret", ret_var))
            # No return argument type if struct-ret
            assignment = ""
            ret_type = "void"
        else:
            # Can do direct assignment
            assignment = ret_var + " = "
    else:
        ret_type = "void"
        assignment = ""

    arg_str = ",". join([typ + " " + str(val) for (typ, val) in arguments])

    return """
    {assignment} call {ret_type} @{funcname}({arguments})
    """.format(
            funcname=funcname,
            arguments=arg_str,
            assignment=assignment,
            ret_type=ret_type,
            )

class __LabelManager__(object):
    def __init__(self):
        self.labels = {}

    def newLabel(self, name):
        if name not in self.labels:
            self.labels[name] = 0

        next_label = name + "_" + str(self.labels[name])
        self.labels[name] += 1

        return next_label

LabelManager = __LabelManager__()

def inject_int(value, output):
    func_code = call_func_asm('inject_int',
            arguments=[('i32', value)],
            output=(PYOBJ_TYPE, output),
            )

    return """
    {output} = alloca {pyobj_t}
    {func_code}
    """.format(
            output=output,
            func_code=func_code,
            pyobj_t=PYOBJ_TYPE,
            )

def inject_bool(value, output):
    func_code = call_func_asm('inject_bool',
            arguments=[('i32', value)],
            output=(PYOBJ_TYPE, output),
            )

    return """
    {output} = alloca {pyobj_t}
    {func_code}
    """.format(
            output=output,
            func_code=func_code,
            pyobj_t=PYOBJ_TYPE,
            )

def inject_big(value, output):
    func_code = call_func_asm('inject_big',
            arguments=[(BIGOBJ_TYPE_PTR, value)],
            output=(PYOBJ_TYPE, output),
            )

    return """
    {output} = alloca {pyobj_t}
    {func_code}
    """.format(
            output=output,
            func_code=func_code,
            pyobj_t=PYOBJ_TYPE,
            )
