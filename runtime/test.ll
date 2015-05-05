; ModuleID = 'test.c'
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.10.0"

%struct.base_pyobj = type { i64, i8*, i8 }
%struct.pyobj_struct = type { i32, %union.anon }
%union.anon = type { %struct.bound_method_struct }
%struct.bound_method_struct = type { %struct.fun_struct, %struct.object_struct }
%struct.fun_struct = type { i8*, %struct.base_pyobj }
%struct.object_struct = type { %struct.hashtable*, %struct.class_struct }
%struct.hashtable = type { i32, %struct.entry**, i32, i32, i32, i32 (i8*)*, i32 (i8*, i8*)* }
%struct.entry = type { i8*, i8*, i32, %struct.entry* }
%struct.class_struct = type { %struct.hashtable*, i32, %struct.class_struct* }

; Function Attrs: nounwind ssp uwtable
define i32 @main() #0 {
  %a = alloca %struct.base_pyobj, align 8
  %b = alloca %struct.pyobj_struct, align 8
  %1 = alloca %struct.base_pyobj, align 8
  %2 = alloca %struct.base_pyobj, align 8
  %3 = alloca %struct.base_pyobj, align 8
  %4 = alloca %struct.base_pyobj, align 8
  %5 = alloca %struct.base_pyobj, align 8
  %6 = alloca %struct.base_pyobj, align 8
  %7 = alloca %struct.base_pyobj, align 8
  %8 = call i32 @tag(%struct.base_pyobj* byval align 8 %a)
  call void @copy(%struct.base_pyobj* sret %1, %struct.base_pyobj* byval align 8 %a)
  %9 = call i32 @is_int(%struct.base_pyobj* byval align 8 %a)
  %10 = call i32 @is_bool(%struct.base_pyobj* byval align 8 %a)
  %11 = call i32 @is_big(%struct.base_pyobj* byval align 8 %a)
  %12 = call i32 @is_function(%struct.base_pyobj* byval align 8 %a)
  %13 = call i32 @is_object(%struct.base_pyobj* byval align 8 %a)
  %14 = call i32 @is_class(%struct.base_pyobj* byval align 8 %a)
  %15 = call i32 @is_unbound_method(%struct.base_pyobj* byval align 8 %a)
  %16 = call i32 @is_bound_method(%struct.base_pyobj* byval align 8 %a)
  call void @inject_int(%struct.base_pyobj* sret %2, i32 0)
  call void @inject_bool(%struct.base_pyobj* sret %3, i32 0)
  call void @inject_big(%struct.base_pyobj* sret %4, %struct.pyobj_struct* %b)
  %17 = call i32 @project_int(%struct.base_pyobj* byval align 8 %a)
  %18 = call i32 @project_bool(%struct.base_pyobj* byval align 8 %a)
  %19 = call %struct.pyobj_struct* @project_big(%struct.base_pyobj* byval align 8 %a)
  %20 = call i32 @is_true(%struct.base_pyobj* byval align 8 %a)
  call void @print_any(%struct.base_pyobj* byval align 8 %a)
  call void (%struct.base_pyobj*, ...)* @input_int(%struct.base_pyobj* sret %5)
  %21 = call %struct.pyobj_struct* @create_list(%struct.base_pyobj* byval align 8 %a)
  %22 = call %struct.pyobj_struct* (...)* @create_dict()
  call void @set_subscript(%struct.base_pyobj* sret %6, %struct.base_pyobj* byval align 8 %a, %struct.base_pyobj* byval align 8 %a, %struct.base_pyobj* byval align 8 %a)
  call void @get_subscript(%struct.base_pyobj* sret %7, %struct.base_pyobj* byval align 8 %a, %struct.base_pyobj* byval align 8 %a)
  %23 = call %struct.pyobj_struct* @add(%struct.pyobj_struct* %b, %struct.pyobj_struct* %b)
  %24 = call i32 @equal(%struct.pyobj_struct* %b, %struct.pyobj_struct* %b)
  %25 = call i32 @not_equal(%struct.pyobj_struct* %b, %struct.pyobj_struct* %b)
  ret i32 0
}

declare i32 @tag(%struct.base_pyobj* byval align 8) #1

declare void @copy(%struct.base_pyobj* sret, %struct.base_pyobj* byval align 8) #1

declare i32 @is_int(%struct.base_pyobj* byval align 8) #1

declare i32 @is_bool(%struct.base_pyobj* byval align 8) #1

declare i32 @is_big(%struct.base_pyobj* byval align 8) #1

declare i32 @is_function(%struct.base_pyobj* byval align 8) #1

declare i32 @is_object(%struct.base_pyobj* byval align 8) #1

declare i32 @is_class(%struct.base_pyobj* byval align 8) #1

declare i32 @is_unbound_method(%struct.base_pyobj* byval align 8) #1

declare i32 @is_bound_method(%struct.base_pyobj* byval align 8) #1

declare void @inject_int(%struct.base_pyobj* sret, i32) #1

declare void @inject_bool(%struct.base_pyobj* sret, i32) #1

declare void @inject_big(%struct.base_pyobj* sret, %struct.pyobj_struct*) #1

declare i32 @project_int(%struct.base_pyobj* byval align 8) #1

declare i32 @project_bool(%struct.base_pyobj* byval align 8) #1

declare %struct.pyobj_struct* @project_big(%struct.base_pyobj* byval align 8) #1

declare i32 @is_true(%struct.base_pyobj* byval align 8) #1

declare void @print_any(%struct.base_pyobj* byval align 8) #1

declare void @input_int(%struct.base_pyobj* sret, ...) #1

declare %struct.pyobj_struct* @create_list(%struct.base_pyobj* byval align 8) #1

declare %struct.pyobj_struct* @create_dict(...) #1

declare void @set_subscript(%struct.base_pyobj* sret, %struct.base_pyobj* byval align 8, %struct.base_pyobj* byval align 8, %struct.base_pyobj* byval align 8) #1

declare void @get_subscript(%struct.base_pyobj* sret, %struct.base_pyobj* byval align 8, %struct.base_pyobj* byval align 8) #1

declare %struct.pyobj_struct* @add(%struct.pyobj_struct*, %struct.pyobj_struct*) #1

declare i32 @equal(%struct.pyobj_struct*, %struct.pyobj_struct*) #1

declare i32 @not_equal(%struct.pyobj_struct*, %struct.pyobj_struct*) #1

attributes #0 = { nounwind ssp uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Apple LLVM version 6.0 (clang-600.0.56) (based on LLVM 3.5svn)"}
