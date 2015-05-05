; ModuleID = 'runtime.c'
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.10.0"

%struct.base_pyobj = type { i64, i8*, i8 }
%struct.list_struct = type { %struct.base_pyobj*, i32 }
%struct.hashtable = type { i32, %struct.entry**, i32, i32, i32, i32 (i8*)*, i32 (i8*, i8*)* }
%struct.entry = type { i8*, i8*, i32, %struct.entry* }
%struct.pyobj_struct = type { i32, %union.anon }
%union.anon = type { %struct.bound_method_struct }
%struct.bound_method_struct = type { %struct.fun_struct, %struct.object_struct }
%struct.fun_struct = type { i8*, %struct.base_pyobj }
%struct.object_struct = type { %struct.hashtable*, %struct.class_struct }
%struct.class_struct = type { %struct.hashtable*, i32, %struct.class_struct* }
%struct.unbound_method_struct = type { %struct.fun_struct, %struct.class_struct }
%struct.hashtable_itr = type { %struct.hashtable*, %struct.entry*, %struct.entry*, i32 }

@__func__.project_int = private unnamed_addr constant [12 x i8] c"project_int\00", align 1
@.str = private unnamed_addr constant [10 x i8] c"runtime.c\00", align 1
@.str1 = private unnamed_addr constant [19 x i8] c"val.tag == INT_TAG\00", align 1
@__func__.project_bool = private unnamed_addr constant [13 x i8] c"project_bool\00", align 1
@__func__.project_float = private unnamed_addr constant [14 x i8] c"project_float\00", align 1
@__func__.project_big = private unnamed_addr constant [12 x i8] c"project_big\00", align 1
@__func__.project_function = private unnamed_addr constant [17 x i8] c"project_function\00", align 1
@.str2 = private unnamed_addr constant [14 x i8] c"p->tag == FUN\00", align 1
@__func__.project_class = private unnamed_addr constant [14 x i8] c"project_class\00", align 1
@.str3 = private unnamed_addr constant [16 x i8] c"p->tag == CLASS\00", align 1
@__func__.project_object = private unnamed_addr constant [15 x i8] c"project_object\00", align 1
@.str4 = private unnamed_addr constant [17 x i8] c"p->tag == OBJECT\00", align 1
@__func__.project_bound_method = private unnamed_addr constant [21 x i8] c"project_bound_method\00", align 1
@.str5 = private unnamed_addr constant [18 x i8] c"p->tag == BMETHOD\00", align 1
@__func__.project_unbound_method = private unnamed_addr constant [23 x i8] c"project_unbound_method\00", align 1
@.str6 = private unnamed_addr constant [19 x i8] c"p->tag == UBMETHOD\00", align 1
@.str7 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@.str8 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str9 = private unnamed_addr constant [31 x i8] c"error in add, expected a list\0A\00", align 1
@.str10 = private unnamed_addr constant [50 x i8] c"error in set subscript, not a list or dictionary\0A\00", align 1
@__func__.set_subscript = private unnamed_addr constant [14 x i8] c"set_subscript\00", align 1
@.str11 = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str12 = private unnamed_addr constant [50 x i8] c"error in get_subscript, not a list or dictionary\0A\00", align 1
@__func__.get_subscript = private unnamed_addr constant [14 x i8] c"get_subscript\00", align 1
@.str13 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str14 = private unnamed_addr constant [34 x i8] c"error, unhandled case in is_true\0A\00", align 1
@__func__.is_true = private unnamed_addr constant [8 x i8] c"is_true\00", align 1
@__func__.get_fun_ptr = private unnamed_addr constant [12 x i8] c"get_fun_ptr\00", align 1
@.str15 = private unnamed_addr constant [14 x i8] c"b->tag == FUN\00", align 1
@__func__.get_free_vars = private unnamed_addr constant [14 x i8] c"get_free_vars\00", align 1
@__func__.set_free_vars = private unnamed_addr constant [14 x i8] c"set_free_vars\00", align 1
@.str16 = private unnamed_addr constant [34 x i8] c"in make object, expected a class\0A\00", align 1
@.str17 = private unnamed_addr constant [45 x i8] c"get_class expected object or unbound method\0A\00", align 1
@.str18 = private unnamed_addr constant [36 x i8] c"get_receiver expected bound method\0A\00", align 1
@.str19 = private unnamed_addr constant [32 x i8] c"get_function expected a method\0A\00", align 1
@.str20 = private unnamed_addr constant [47 x i8] c"error in get attribute, not a class or object\0A\00", align 1
@.str21 = private unnamed_addr constant [50 x i8] c"error, expected object or class in set attribute\0A\00", align 1
@.str22 = private unnamed_addr constant [14 x i8] c"out of memory\00", align 1
@.str23 = private unnamed_addr constant [3 x i8] c"%s\00", align 1
@.str24 = private unnamed_addr constant [24 x i8] c"attribute %s not found\0A\00", align 1
@__func__.print_pyobj = private unnamed_addr constant [12 x i8] c"print_pyobj\00", align 1
@current_list = internal global %struct.base_pyobj* null, align 8
@.str25 = private unnamed_addr constant [6 x i8] c"[...]\00", align 1
@.str26 = private unnamed_addr constant [2 x i8] c"[\00", align 1
@.str27 = private unnamed_addr constant [3 x i8] c", \00", align 1
@.str28 = private unnamed_addr constant [2 x i8] c"]\00", align 1
@inside = internal global i8 0, align 1
@printing_list = internal global %struct.list_struct zeroinitializer, align 8
@.str29 = private unnamed_addr constant [6 x i8] c"{...}\00", align 1
@.str30 = private unnamed_addr constant [2 x i8] c"{\00", align 1
@.str31 = private unnamed_addr constant [3 x i8] c": \00", align 1
@.str32 = private unnamed_addr constant [2 x i8] c"}\00", align 1
@.str33 = private unnamed_addr constant [6 x i8] c"%.12g\00", align 1
@printed_0 = internal global i8 0, align 1
@printed_0_neg = internal global i8 0, align 1
@.str34 = private unnamed_addr constant [5 x i8] c"-0.0\00", align 1
@.str35 = private unnamed_addr constant [4 x i8] c"0.0\00", align 1
@.str36 = private unnamed_addr constant [5 x i8] c"%s.0\00", align 1
@.str37 = private unnamed_addr constant [5 x i8] c"True\00", align 1
@.str38 = private unnamed_addr constant [6 x i8] c"False\00", align 1
@__func__.subscript = private unnamed_addr constant [10 x i8] c"subscript\00", align 1
@.str39 = private unnamed_addr constant [39 x i8] c"ERROR: list_nth index larger than list\00", align 1
@.str40 = private unnamed_addr constant [39 x i8] c"ERROR: list_nth expected integer index\00", align 1
@__func__.subscript_assign = private unnamed_addr constant [17 x i8] c"subscript_assign\00", align 1
@current_cmp_a = internal global %struct.hashtable* null, align 8
@current_cmp_b = internal global %struct.hashtable* null, align 8
@.str41 = private unnamed_addr constant [30 x i8] c"unrecognized tag in hash_any\0A\00", align 1

; Function Attrs: nounwind ssp uwtable
define i32 @min(i32 %x, i32 %y) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 %x, i32* %1, align 4
  store i32 %y, i32* %2, align 4
  %3 = load i32* %2, align 4
  %4 = load i32* %1, align 4
  %5 = icmp slt i32 %3, %4
  br i1 %5, label %6, label %8

; <label>:6                                       ; preds = %0
  %7 = load i32* %2, align 4
  br label %10

; <label>:8                                       ; preds = %0
  %9 = load i32* %1, align 4
  br label %10

; <label>:10                                      ; preds = %8, %6
  %11 = phi i32 [ %7, %6 ], [ %9, %8 ]
  ret i32 %11
}

; Function Attrs: nounwind ssp uwtable
define i32 @tag(%struct.base_pyobj* byval align 8 %val) #0 {
  %1 = getelementptr inbounds %struct.base_pyobj* %val, i32 0, i32 2
  %2 = load i8* %1, align 1
  %3 = sext i8 %2 to i32
  ret i32 %3
}

; Function Attrs: nounwind ssp uwtable
define i32 @is_int(%struct.base_pyobj* byval align 8 %val) #0 {
  %1 = getelementptr inbounds %struct.base_pyobj* %val, i32 0, i32 2
  %2 = load i8* %1, align 1
  %3 = sext i8 %2 to i32
  %4 = icmp eq i32 %3, 0
  %5 = zext i1 %4 to i32
  ret i32 %5
}

; Function Attrs: nounwind ssp uwtable
define i32 @is_bool(%struct.base_pyobj* byval align 8 %val) #0 {
  %1 = getelementptr inbounds %struct.base_pyobj* %val, i32 0, i32 2
  %2 = load i8* %1, align 1
  %3 = sext i8 %2 to i32
  %4 = icmp eq i32 %3, 1
  %5 = zext i1 %4 to i32
  ret i32 %5
}

; Function Attrs: nounwind ssp uwtable
define i32 @is_float(%struct.base_pyobj* byval align 8 %val) #0 {
  %1 = getelementptr inbounds %struct.base_pyobj* %val, i32 0, i32 2
  %2 = load i8* %1, align 1
  %3 = sext i8 %2 to i32
  %4 = icmp eq i32 %3, 2
  %5 = zext i1 %4 to i32
  ret i32 %5
}

; Function Attrs: nounwind ssp uwtable
define i32 @is_big(%struct.base_pyobj* byval align 8 %val) #0 {
  %1 = getelementptr inbounds %struct.base_pyobj* %val, i32 0, i32 2
  %2 = load i8* %1, align 1
  %3 = sext i8 %2 to i32
  %4 = icmp eq i32 %3, 2
  %5 = zext i1 %4 to i32
  ret i32 %5
}

; Function Attrs: nounwind ssp uwtable
define i32 @is_function(%struct.base_pyobj* byval align 8 %val) #0 {
  %1 = alloca i32, align 4
  %ret = alloca i32, align 4
  %2 = call i32 @is_big(%struct.base_pyobj* byval align 8 %val)
  %3 = icmp ne i32 %2, 0
  br i1 %3, label %4, label %11

; <label>:4                                       ; preds = %0
  %5 = call %struct.pyobj_struct* @project_big(%struct.base_pyobj* byval align 8 %val)
  %6 = getelementptr inbounds %struct.pyobj_struct* %5, i32 0, i32 0
  %7 = load i32* %6, align 4
  %8 = icmp eq i32 %7, 2
  %9 = zext i1 %8 to i32
  store i32 %9, i32* %ret, align 4
  %10 = load i32* %ret, align 4
  store i32 %10, i32* %1
  br label %12

; <label>:11                                      ; preds = %0
  store i32 0, i32* %1
  br label %12

; <label>:12                                      ; preds = %11, %4
  %13 = load i32* %1
  ret i32 %13
}

; Function Attrs: nounwind ssp uwtable
define %struct.pyobj_struct* @project_big(%struct.base_pyobj* byval align 8 %val) #0 {
  %1 = getelementptr inbounds %struct.base_pyobj* %val, i32 0, i32 2
  %2 = load i8* %1, align 1
  %3 = sext i8 %2 to i32
  %4 = icmp eq i32 %3, 0
  %5 = xor i1 %4, true
  %6 = zext i1 %5 to i32
  %7 = sext i32 %6 to i64
  %8 = call i64 @llvm.expect.i64(i64 %7, i64 0)
  %9 = icmp ne i64 %8, 0
  br i1 %9, label %10, label %12

; <label>:10                                      ; preds = %0
  call void @__assert_rtn(i8* getelementptr inbounds ([12 x i8]* @__func__.project_big, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8]* @.str, i32 0, i32 0), i32 109, i8* getelementptr inbounds ([19 x i8]* @.str1, i32 0, i32 0)) #6
  unreachable
                                                  ; No predecessors!
  br label %13

; <label>:12                                      ; preds = %0
  br label %13

; <label>:13                                      ; preds = %12, %11
  %14 = getelementptr inbounds %struct.base_pyobj* %val, i32 0, i32 1
  %15 = load i8** %14, align 8
  %16 = bitcast i8* %15 to %struct.pyobj_struct*
  ret %struct.pyobj_struct* %16
}

; Function Attrs: nounwind ssp uwtable
define i32 @is_object(%struct.base_pyobj* byval align 8 %val) #0 {
  %1 = call i32 @is_big(%struct.base_pyobj* byval align 8 %val)
  %2 = icmp ne i32 %1, 0
  br i1 %2, label %3, label %8

; <label>:3                                       ; preds = %0
  %4 = call %struct.pyobj_struct* @project_big(%struct.base_pyobj* byval align 8 %val)
  %5 = getelementptr inbounds %struct.pyobj_struct* %4, i32 0, i32 0
  %6 = load i32* %5, align 4
  %7 = icmp eq i32 %6, 4
  br label %8

; <label>:8                                       ; preds = %3, %0
  %9 = phi i1 [ false, %0 ], [ %7, %3 ]
  %10 = zext i1 %9 to i32
  ret i32 %10
}

; Function Attrs: nounwind ssp uwtable
define i32 @is_class(%struct.base_pyobj* byval align 8 %val) #0 {
  %1 = call i32 @is_big(%struct.base_pyobj* byval align 8 %val)
  %2 = icmp ne i32 %1, 0
  br i1 %2, label %3, label %8

; <label>:3                                       ; preds = %0
  %4 = call %struct.pyobj_struct* @project_big(%struct.base_pyobj* byval align 8 %val)
  %5 = getelementptr inbounds %struct.pyobj_struct* %4, i32 0, i32 0
  %6 = load i32* %5, align 4
  %7 = icmp eq i32 %6, 3
  br label %8

; <label>:8                                       ; preds = %3, %0
  %9 = phi i1 [ false, %0 ], [ %7, %3 ]
  %10 = zext i1 %9 to i32
  ret i32 %10
}

; Function Attrs: nounwind ssp uwtable
define i32 @is_unbound_method(%struct.base_pyobj* byval align 8 %val) #0 {
  %1 = call i32 @is_big(%struct.base_pyobj* byval align 8 %val)
  %2 = icmp ne i32 %1, 0
  br i1 %2, label %3, label %8

; <label>:3                                       ; preds = %0
  %4 = call %struct.pyobj_struct* @project_big(%struct.base_pyobj* byval align 8 %val)
  %5 = getelementptr inbounds %struct.pyobj_struct* %4, i32 0, i32 0
  %6 = load i32* %5, align 4
  %7 = icmp eq i32 %6, 5
  br label %8

; <label>:8                                       ; preds = %3, %0
  %9 = phi i1 [ false, %0 ], [ %7, %3 ]
  %10 = zext i1 %9 to i32
  ret i32 %10
}

; Function Attrs: nounwind ssp uwtable
define i32 @is_bound_method(%struct.base_pyobj* byval align 8 %val) #0 {
  %1 = call i32 @is_big(%struct.base_pyobj* byval align 8 %val)
  %2 = icmp ne i32 %1, 0
  br i1 %2, label %3, label %8

; <label>:3                                       ; preds = %0
  %4 = call %struct.pyobj_struct* @project_big(%struct.base_pyobj* byval align 8 %val)
  %5 = getelementptr inbounds %struct.pyobj_struct* %4, i32 0, i32 0
  %6 = load i32* %5, align 4
  %7 = icmp eq i32 %6, 6
  br label %8

; <label>:8                                       ; preds = %3, %0
  %9 = phi i1 [ false, %0 ], [ %7, %3 ]
  %10 = zext i1 %9 to i32
  ret i32 %10
}

; Function Attrs: nounwind ssp uwtable
define void @inject_int(%struct.base_pyobj* noalias sret %agg.result, i32 %i) #0 {
  %1 = alloca i32, align 4
  %val = alloca %struct.base_pyobj, align 8
  store i32 %i, i32* %1, align 4
  %2 = load i32* %1, align 4
  %3 = sext i32 %2 to i64
  %4 = getelementptr inbounds %struct.base_pyobj* %val, i32 0, i32 0
  store i64 %3, i64* %4, align 8
  %5 = getelementptr inbounds %struct.base_pyobj* %val, i32 0, i32 2
  store i8 0, i8* %5, align 1
  %6 = bitcast %struct.base_pyobj* %agg.result to i8*
  %7 = bitcast %struct.base_pyobj* %val to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %6, i8* %7, i64 24, i32 8, i1 false)
  ret void
}

; Function Attrs: nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #1

; Function Attrs: nounwind ssp uwtable
define void @inject_bool(%struct.base_pyobj* noalias sret %agg.result, i32 %b) #0 {
  %1 = alloca i32, align 4
  %val = alloca %struct.base_pyobj, align 8
  store i32 %b, i32* %1, align 4
  %2 = load i32* %1, align 4
  %3 = sext i32 %2 to i64
  %4 = getelementptr inbounds %struct.base_pyobj* %val, i32 0, i32 0
  store i64 %3, i64* %4, align 8
  %5 = getelementptr inbounds %struct.base_pyobj* %val, i32 0, i32 2
  store i8 1, i8* %5, align 1
  %6 = bitcast %struct.base_pyobj* %agg.result to i8*
  %7 = bitcast %struct.base_pyobj* %val to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %6, i8* %7, i64 24, i32 8, i1 false)
  ret void
}

; Function Attrs: nounwind ssp uwtable
define void @inject_float(%struct.base_pyobj* noalias sret %agg.result, i32 %f) #0 {
  %1 = alloca i32, align 4
  %val = alloca %struct.base_pyobj, align 8
  store i32 %f, i32* %1, align 4
  %2 = load i32* %1, align 4
  %3 = sext i32 %2 to i64
  %4 = getelementptr inbounds %struct.base_pyobj* %val, i32 0, i32 0
  store i64 %3, i64* %4, align 8
  %5 = getelementptr inbounds %struct.base_pyobj* %val, i32 0, i32 2
  store i8 2, i8* %5, align 1
  %6 = bitcast %struct.base_pyobj* %agg.result to i8*
  %7 = bitcast %struct.base_pyobj* %val to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %6, i8* %7, i64 24, i32 8, i1 false)
  ret void
}

; Function Attrs: nounwind ssp uwtable
define void @inject_big(%struct.base_pyobj* noalias sret %agg.result, %struct.pyobj_struct* %p) #0 {
  %1 = alloca %struct.pyobj_struct*, align 8
  %val = alloca %struct.base_pyobj, align 8
  store %struct.pyobj_struct* %p, %struct.pyobj_struct** %1, align 8
  %2 = load %struct.pyobj_struct** %1, align 8
  %3 = bitcast %struct.pyobj_struct* %2 to i8*
  %4 = getelementptr inbounds %struct.base_pyobj* %val, i32 0, i32 1
  store i8* %3, i8** %4, align 8
  %5 = getelementptr inbounds %struct.base_pyobj* %val, i32 0, i32 2
  store i8 3, i8* %5, align 1
  %6 = bitcast %struct.base_pyobj* %agg.result to i8*
  %7 = bitcast %struct.base_pyobj* %val to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %6, i8* %7, i64 24, i32 8, i1 false)
  ret void
}

; Function Attrs: nounwind ssp uwtable
define i32 @project_int(%struct.base_pyobj* byval align 8 %val) #0 {
  %1 = getelementptr inbounds %struct.base_pyobj* %val, i32 0, i32 2
  %2 = load i8* %1, align 1
  %3 = sext i8 %2 to i32
  %4 = icmp eq i32 %3, 0
  %5 = xor i1 %4, true
  %6 = zext i1 %5 to i32
  %7 = sext i32 %6 to i64
  %8 = call i64 @llvm.expect.i64(i64 %7, i64 0)
  %9 = icmp ne i64 %8, 0
  br i1 %9, label %10, label %12

; <label>:10                                      ; preds = %0
  call void @__assert_rtn(i8* getelementptr inbounds ([12 x i8]* @__func__.project_int, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8]* @.str, i32 0, i32 0), i32 94, i8* getelementptr inbounds ([19 x i8]* @.str1, i32 0, i32 0)) #6
  unreachable
                                                  ; No predecessors!
  br label %13

; <label>:12                                      ; preds = %0
  br label %13

; <label>:13                                      ; preds = %12, %11
  %14 = getelementptr inbounds %struct.base_pyobj* %val, i32 0, i32 0
  %15 = load i64* %14, align 8
  %16 = trunc i64 %15 to i32
  ret i32 %16
}

; Function Attrs: nounwind readnone
declare i64 @llvm.expect.i64(i64, i64) #2

; Function Attrs: noreturn
declare void @__assert_rtn(i8*, i8*, i32, i8*) #3

; Function Attrs: nounwind ssp uwtable
define i32 @project_bool(%struct.base_pyobj* byval align 8 %val) #0 {
  %1 = getelementptr inbounds %struct.base_pyobj* %val, i32 0, i32 2
  %2 = load i8* %1, align 1
  %3 = sext i8 %2 to i32
  %4 = icmp eq i32 %3, 0
  %5 = xor i1 %4, true
  %6 = zext i1 %5 to i32
  %7 = sext i32 %6 to i64
  %8 = call i64 @llvm.expect.i64(i64 %7, i64 0)
  %9 = icmp ne i64 %8, 0
  br i1 %9, label %10, label %12

; <label>:10                                      ; preds = %0
  call void @__assert_rtn(i8* getelementptr inbounds ([13 x i8]* @__func__.project_bool, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8]* @.str, i32 0, i32 0), i32 99, i8* getelementptr inbounds ([19 x i8]* @.str1, i32 0, i32 0)) #6
  unreachable
                                                  ; No predecessors!
  br label %13

; <label>:12                                      ; preds = %0
  br label %13

; <label>:13                                      ; preds = %12, %11
  %14 = getelementptr inbounds %struct.base_pyobj* %val, i32 0, i32 0
  %15 = load i64* %14, align 8
  %16 = trunc i64 %15 to i32
  ret i32 %16
}

; Function Attrs: nounwind ssp uwtable
define float @project_float(%struct.base_pyobj* byval align 8 %val) #0 {
  %1 = getelementptr inbounds %struct.base_pyobj* %val, i32 0, i32 2
  %2 = load i8* %1, align 1
  %3 = sext i8 %2 to i32
  %4 = icmp eq i32 %3, 0
  %5 = xor i1 %4, true
  %6 = zext i1 %5 to i32
  %7 = sext i32 %6 to i64
  %8 = call i64 @llvm.expect.i64(i64 %7, i64 0)
  %9 = icmp ne i64 %8, 0
  br i1 %9, label %10, label %12

; <label>:10                                      ; preds = %0
  call void @__assert_rtn(i8* getelementptr inbounds ([14 x i8]* @__func__.project_float, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8]* @.str, i32 0, i32 0), i32 104, i8* getelementptr inbounds ([19 x i8]* @.str1, i32 0, i32 0)) #6
  unreachable
                                                  ; No predecessors!
  br label %13

; <label>:12                                      ; preds = %0
  br label %13

; <label>:13                                      ; preds = %12, %11
  %14 = getelementptr inbounds %struct.base_pyobj* %val, i32 0, i32 0
  %15 = load i64* %14, align 8
  %16 = sitofp i64 %15 to float
  ret float %16
}

; Function Attrs: nounwind ssp uwtable
define void @project_function(%struct.fun_struct* noalias sret %agg.result, %struct.base_pyobj* byval align 8 %val) #0 {
  %p = alloca %struct.pyobj_struct*, align 8
  %1 = call %struct.pyobj_struct* @project_big(%struct.base_pyobj* byval align 8 %val)
  store %struct.pyobj_struct* %1, %struct.pyobj_struct** %p, align 8
  %2 = load %struct.pyobj_struct** %p, align 8
  %3 = getelementptr inbounds %struct.pyobj_struct* %2, i32 0, i32 0
  %4 = load i32* %3, align 4
  %5 = icmp eq i32 %4, 2
  %6 = xor i1 %5, true
  %7 = zext i1 %6 to i32
  %8 = sext i32 %7 to i64
  %9 = call i64 @llvm.expect.i64(i64 %8, i64 0)
  %10 = icmp ne i64 %9, 0
  br i1 %10, label %11, label %13

; <label>:11                                      ; preds = %0
  call void @__assert_rtn(i8* getelementptr inbounds ([17 x i8]* @__func__.project_function, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8]* @.str, i32 0, i32 0), i32 115, i8* getelementptr inbounds ([14 x i8]* @.str2, i32 0, i32 0)) #6
  unreachable
                                                  ; No predecessors!
  br label %14

; <label>:13                                      ; preds = %0
  br label %14

; <label>:14                                      ; preds = %13, %12
  %15 = load %struct.pyobj_struct** %p, align 8
  %16 = getelementptr inbounds %struct.pyobj_struct* %15, i32 0, i32 1
  %17 = bitcast %union.anon* %16 to %struct.fun_struct*
  %18 = bitcast %struct.fun_struct* %agg.result to i8*
  %19 = bitcast %struct.fun_struct* %17 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %18, i8* %19, i64 32, i32 8, i1 false)
  ret void
}

; Function Attrs: nounwind ssp uwtable
define void @project_class(%struct.class_struct* noalias sret %agg.result, %struct.base_pyobj* byval align 8 %val) #0 {
  %p = alloca %struct.pyobj_struct*, align 8
  %1 = call %struct.pyobj_struct* @project_big(%struct.base_pyobj* byval align 8 %val)
  store %struct.pyobj_struct* %1, %struct.pyobj_struct** %p, align 8
  %2 = load %struct.pyobj_struct** %p, align 8
  %3 = getelementptr inbounds %struct.pyobj_struct* %2, i32 0, i32 0
  %4 = load i32* %3, align 4
  %5 = icmp eq i32 %4, 3
  %6 = xor i1 %5, true
  %7 = zext i1 %6 to i32
  %8 = sext i32 %7 to i64
  %9 = call i64 @llvm.expect.i64(i64 %8, i64 0)
  %10 = icmp ne i64 %9, 0
  br i1 %10, label %11, label %13

; <label>:11                                      ; preds = %0
  call void @__assert_rtn(i8* getelementptr inbounds ([14 x i8]* @__func__.project_class, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8]* @.str, i32 0, i32 0), i32 120, i8* getelementptr inbounds ([16 x i8]* @.str3, i32 0, i32 0)) #6
  unreachable
                                                  ; No predecessors!
  br label %14

; <label>:13                                      ; preds = %0
  br label %14

; <label>:14                                      ; preds = %13, %12
  %15 = load %struct.pyobj_struct** %p, align 8
  %16 = getelementptr inbounds %struct.pyobj_struct* %15, i32 0, i32 1
  %17 = bitcast %union.anon* %16 to %struct.class_struct*
  %18 = bitcast %struct.class_struct* %agg.result to i8*
  %19 = bitcast %struct.class_struct* %17 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %18, i8* %19, i64 24, i32 8, i1 false)
  ret void
}

; Function Attrs: nounwind ssp uwtable
define void @project_object(%struct.object_struct* noalias sret %agg.result, %struct.base_pyobj* byval align 8 %val) #0 {
  %p = alloca %struct.pyobj_struct*, align 8
  %1 = call %struct.pyobj_struct* @project_big(%struct.base_pyobj* byval align 8 %val)
  store %struct.pyobj_struct* %1, %struct.pyobj_struct** %p, align 8
  %2 = load %struct.pyobj_struct** %p, align 8
  %3 = getelementptr inbounds %struct.pyobj_struct* %2, i32 0, i32 0
  %4 = load i32* %3, align 4
  %5 = icmp eq i32 %4, 4
  %6 = xor i1 %5, true
  %7 = zext i1 %6 to i32
  %8 = sext i32 %7 to i64
  %9 = call i64 @llvm.expect.i64(i64 %8, i64 0)
  %10 = icmp ne i64 %9, 0
  br i1 %10, label %11, label %13

; <label>:11                                      ; preds = %0
  call void @__assert_rtn(i8* getelementptr inbounds ([15 x i8]* @__func__.project_object, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8]* @.str, i32 0, i32 0), i32 125, i8* getelementptr inbounds ([17 x i8]* @.str4, i32 0, i32 0)) #6
  unreachable
                                                  ; No predecessors!
  br label %14

; <label>:13                                      ; preds = %0
  br label %14

; <label>:14                                      ; preds = %13, %12
  %15 = load %struct.pyobj_struct** %p, align 8
  %16 = getelementptr inbounds %struct.pyobj_struct* %15, i32 0, i32 1
  %17 = bitcast %union.anon* %16 to %struct.object_struct*
  %18 = bitcast %struct.object_struct* %agg.result to i8*
  %19 = bitcast %struct.object_struct* %17 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %18, i8* %19, i64 32, i32 8, i1 false)
  ret void
}

; Function Attrs: nounwind ssp uwtable
define void @project_bound_method(%struct.bound_method_struct* noalias sret %agg.result, %struct.base_pyobj* byval align 8 %val) #0 {
  %p = alloca %struct.pyobj_struct*, align 8
  %1 = call %struct.pyobj_struct* @project_big(%struct.base_pyobj* byval align 8 %val)
  store %struct.pyobj_struct* %1, %struct.pyobj_struct** %p, align 8
  %2 = load %struct.pyobj_struct** %p, align 8
  %3 = getelementptr inbounds %struct.pyobj_struct* %2, i32 0, i32 0
  %4 = load i32* %3, align 4
  %5 = icmp eq i32 %4, 6
  %6 = xor i1 %5, true
  %7 = zext i1 %6 to i32
  %8 = sext i32 %7 to i64
  %9 = call i64 @llvm.expect.i64(i64 %8, i64 0)
  %10 = icmp ne i64 %9, 0
  br i1 %10, label %11, label %13

; <label>:11                                      ; preds = %0
  call void @__assert_rtn(i8* getelementptr inbounds ([21 x i8]* @__func__.project_bound_method, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8]* @.str, i32 0, i32 0), i32 130, i8* getelementptr inbounds ([18 x i8]* @.str5, i32 0, i32 0)) #6
  unreachable
                                                  ; No predecessors!
  br label %14

; <label>:13                                      ; preds = %0
  br label %14

; <label>:14                                      ; preds = %13, %12
  %15 = load %struct.pyobj_struct** %p, align 8
  %16 = getelementptr inbounds %struct.pyobj_struct* %15, i32 0, i32 1
  %17 = bitcast %union.anon* %16 to %struct.bound_method_struct*
  %18 = bitcast %struct.bound_method_struct* %agg.result to i8*
  %19 = bitcast %struct.bound_method_struct* %17 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %18, i8* %19, i64 64, i32 8, i1 false)
  ret void
}

; Function Attrs: nounwind ssp uwtable
define void @project_unbound_method(%struct.unbound_method_struct* noalias sret %agg.result, %struct.base_pyobj* byval align 8 %val) #0 {
  %p = alloca %struct.pyobj_struct*, align 8
  %1 = call %struct.pyobj_struct* @project_big(%struct.base_pyobj* byval align 8 %val)
  store %struct.pyobj_struct* %1, %struct.pyobj_struct** %p, align 8
  %2 = load %struct.pyobj_struct** %p, align 8
  %3 = getelementptr inbounds %struct.pyobj_struct* %2, i32 0, i32 0
  %4 = load i32* %3, align 4
  %5 = icmp eq i32 %4, 5
  %6 = xor i1 %5, true
  %7 = zext i1 %6 to i32
  %8 = sext i32 %7 to i64
  %9 = call i64 @llvm.expect.i64(i64 %8, i64 0)
  %10 = icmp ne i64 %9, 0
  br i1 %10, label %11, label %13

; <label>:11                                      ; preds = %0
  call void @__assert_rtn(i8* getelementptr inbounds ([23 x i8]* @__func__.project_unbound_method, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8]* @.str, i32 0, i32 0), i32 135, i8* getelementptr inbounds ([19 x i8]* @.str6, i32 0, i32 0)) #6
  unreachable
                                                  ; No predecessors!
  br label %14

; <label>:13                                      ; preds = %0
  br label %14

; <label>:14                                      ; preds = %13, %12
  %15 = load %struct.pyobj_struct** %p, align 8
  %16 = getelementptr inbounds %struct.pyobj_struct* %15, i32 0, i32 1
  %17 = bitcast %union.anon* %16 to %struct.unbound_method_struct*
  %18 = bitcast %struct.unbound_method_struct* %agg.result to i8*
  %19 = bitcast %struct.unbound_method_struct* %17 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %18, i8* %19, i64 56, i32 8, i1 false)
  ret void
}

; Function Attrs: nounwind ssp uwtable
define void @print_int_nl(i32 %x) #0 {
  %1 = alloca i32, align 4
  store i32 %x, i32* %1, align 4
  %2 = load i32* %1, align 4
  %3 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str7, i32 0, i32 0), i32 %2)
  ret void
}

declare i32 @printf(i8*, ...) #4

; Function Attrs: nounwind ssp uwtable
define i32 @input() #0 {
  %i = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @scanf(i8* getelementptr inbounds ([3 x i8]* @.str8, i32 0, i32 0), i32* %i)
  %2 = load i32* %i, align 4
  ret i32 %2
}

declare i32 @scanf(i8*, ...) #4

; Function Attrs: nounwind ssp uwtable
define void @input_int(%struct.base_pyobj* noalias sret %agg.result) #0 {
  %i = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @scanf(i8* getelementptr inbounds ([3 x i8]* @.str8, i32 0, i32 0), i32* %i)
  %2 = load i32* %i, align 4
  call void @inject_int(%struct.base_pyobj* sret %agg.result, i32 %2)
  ret void
}

; Function Attrs: nounwind ssp uwtable
define %struct.pyobj_struct* @create_list(%struct.base_pyobj* byval align 8 %length) #0 {
  %l = alloca %struct.list_struct, align 8
  %1 = call i32 @project_int(%struct.base_pyobj* byval align 8 %length)
  %2 = getelementptr inbounds %struct.list_struct* %l, i32 0, i32 1
  store i32 %1, i32* %2, align 4
  %3 = getelementptr inbounds %struct.list_struct* %l, i32 0, i32 1
  %4 = load i32* %3, align 4
  %5 = zext i32 %4 to i64
  %6 = mul i64 24, %5
  %7 = call i8* @malloc(i64 %6)
  %8 = bitcast i8* %7 to %struct.base_pyobj*
  %9 = getelementptr inbounds %struct.list_struct* %l, i32 0, i32 0
  store %struct.base_pyobj* %8, %struct.base_pyobj** %9, align 8
  %10 = bitcast %struct.list_struct* %l to { %struct.base_pyobj*, i32 }*
  %11 = getelementptr { %struct.base_pyobj*, i32 }* %10, i32 0, i32 0
  %12 = load %struct.base_pyobj** %11, align 1
  %13 = getelementptr { %struct.base_pyobj*, i32 }* %10, i32 0, i32 1
  %14 = load i32* %13, align 1
  %15 = call %struct.pyobj_struct* @list_to_big(%struct.base_pyobj* %12, i32 %14)
  ret %struct.pyobj_struct* %15
}

declare i8* @malloc(i64) #4

; Function Attrs: nounwind ssp uwtable
define internal %struct.pyobj_struct* @list_to_big(%struct.base_pyobj* %l.coerce0, i32 %l.coerce1) #0 {
  %l = alloca %struct.list_struct, align 8
  %v = alloca %struct.pyobj_struct*, align 8
  %1 = bitcast %struct.list_struct* %l to { %struct.base_pyobj*, i32 }*
  %2 = getelementptr { %struct.base_pyobj*, i32 }* %1, i32 0, i32 0
  store %struct.base_pyobj* %l.coerce0, %struct.base_pyobj** %2
  %3 = getelementptr { %struct.base_pyobj*, i32 }* %1, i32 0, i32 1
  store i32 %l.coerce1, i32* %3
  %4 = call i8* @malloc(i64 72)
  %5 = bitcast i8* %4 to %struct.pyobj_struct*
  store %struct.pyobj_struct* %5, %struct.pyobj_struct** %v, align 8
  %6 = load %struct.pyobj_struct** %v, align 8
  %7 = getelementptr inbounds %struct.pyobj_struct* %6, i32 0, i32 0
  store i32 0, i32* %7, align 4
  %8 = load %struct.pyobj_struct** %v, align 8
  %9 = getelementptr inbounds %struct.pyobj_struct* %8, i32 0, i32 1
  %10 = bitcast %union.anon* %9 to %struct.list_struct*
  %11 = bitcast %struct.list_struct* %10 to i8*
  %12 = bitcast %struct.list_struct* %l to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %11, i8* %12, i64 16, i32 8, i1 false)
  %13 = load %struct.pyobj_struct** %v, align 8
  ret %struct.pyobj_struct* %13
}

; Function Attrs: nounwind ssp uwtable
define %struct.pyobj_struct* @create_dict() #0 {
  %v = alloca %struct.pyobj_struct*, align 8
  %1 = call i8* @malloc(i64 72)
  %2 = bitcast i8* %1 to %struct.pyobj_struct*
  store %struct.pyobj_struct* %2, %struct.pyobj_struct** %v, align 8
  %3 = load %struct.pyobj_struct** %v, align 8
  %4 = getelementptr inbounds %struct.pyobj_struct* %3, i32 0, i32 0
  store i32 1, i32* %4, align 4
  %5 = call %struct.hashtable* @create_hashtable(i32 4, i32 (i8*)* @hash_any, i32 (i8*, i8*)* @equal_any)
  %6 = load %struct.pyobj_struct** %v, align 8
  %7 = getelementptr inbounds %struct.pyobj_struct* %6, i32 0, i32 1
  %8 = bitcast %union.anon* %7 to %struct.hashtable**
  store %struct.hashtable* %5, %struct.hashtable** %8, align 8
  %9 = load %struct.pyobj_struct** %v, align 8
  ret %struct.pyobj_struct* %9
}

declare %struct.hashtable* @create_hashtable(i32, i32 (i8*)*, i32 (i8*, i8*)*) #4

; Function Attrs: nounwind ssp uwtable
define internal i32 @hash_any(i8* %o) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i8*, align 8
  %obj = alloca %struct.base_pyobj, align 8
  %b = alloca %struct.pyobj_struct*, align 8
  %i = alloca i64, align 8
  %h = alloca i64, align 8
  %i1 = alloca %struct.hashtable_itr*, align 8
  %h2 = alloca i64, align 8
  store i8* %o, i8** %2, align 8
  %3 = load i8** %2, align 8
  %4 = bitcast i8* %3 to %struct.base_pyobj*
  %5 = bitcast %struct.base_pyobj* %obj to i8*
  %6 = bitcast %struct.base_pyobj* %4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %5, i8* %6, i64 24, i32 8, i1 false)
  %7 = call i32 @tag(%struct.base_pyobj* byval align 8 %obj)
  switch i32 %7, label %86 [
    i32 0, label %8
    i32 2, label %11
    i32 1, label %15
    i32 3, label %18
  ]

; <label>:8                                       ; preds = %0
  %9 = call i32 @project_int(%struct.base_pyobj* byval align 8 %obj)
  %10 = call i32 @hash32shift(i32 %9)
  store i32 %10, i32* %1
  br label %88

; <label>:11                                      ; preds = %0
  %12 = call float @project_float(%struct.base_pyobj* byval align 8 %obj)
  %13 = fptosi float %12 to i32
  %14 = call i32 @hash32shift(i32 %13)
  store i32 %14, i32* %1
  br label %88

; <label>:15                                      ; preds = %0
  %16 = call i32 @project_bool(%struct.base_pyobj* byval align 8 %obj)
  %17 = call i32 @hash32shift(i32 %16)
  store i32 %17, i32* %1
  br label %88

; <label>:18                                      ; preds = %0
  %19 = call %struct.pyobj_struct* @project_big(%struct.base_pyobj* byval align 8 %obj)
  store %struct.pyobj_struct* %19, %struct.pyobj_struct** %b, align 8
  %20 = load %struct.pyobj_struct** %b, align 8
  %21 = getelementptr inbounds %struct.pyobj_struct* %20, i32 0, i32 0
  %22 = load i32* %21, align 4
  switch i32 %22, label %84 [
    i32 0, label %23
    i32 1, label %53
  ]

; <label>:23                                      ; preds = %18
  store i64 0, i64* %h, align 8
  store i64 0, i64* %i, align 8
  br label %24

; <label>:24                                      ; preds = %47, %23
  %25 = load i64* %i, align 8
  %26 = load %struct.pyobj_struct** %b, align 8
  %27 = getelementptr inbounds %struct.pyobj_struct* %26, i32 0, i32 1
  %28 = bitcast %union.anon* %27 to %struct.list_struct*
  %29 = getelementptr inbounds %struct.list_struct* %28, i32 0, i32 1
  %30 = load i32* %29, align 4
  %31 = zext i32 %30 to i64
  %32 = icmp ne i64 %25, %31
  br i1 %32, label %33, label %50

; <label>:33                                      ; preds = %24
  %34 = load i64* %h, align 8
  %35 = mul i64 5, %34
  %36 = load i64* %i, align 8
  %37 = load %struct.pyobj_struct** %b, align 8
  %38 = getelementptr inbounds %struct.pyobj_struct* %37, i32 0, i32 1
  %39 = bitcast %union.anon* %38 to %struct.list_struct*
  %40 = getelementptr inbounds %struct.list_struct* %39, i32 0, i32 0
  %41 = load %struct.base_pyobj** %40, align 8
  %42 = getelementptr inbounds %struct.base_pyobj* %41, i64 %36
  %43 = bitcast %struct.base_pyobj* %42 to i8*
  %44 = call i32 @hash_any(i8* %43)
  %45 = zext i32 %44 to i64
  %46 = add i64 %35, %45
  store i64 %46, i64* %h, align 8
  br label %47

; <label>:47                                      ; preds = %33
  %48 = load i64* %i, align 8
  %49 = add i64 %48, 1
  store i64 %49, i64* %i, align 8
  br label %24

; <label>:50                                      ; preds = %24
  %51 = load i64* %h, align 8
  %52 = trunc i64 %51 to i32
  store i32 %52, i32* %1
  br label %88

; <label>:53                                      ; preds = %18
  store i64 0, i64* %h2, align 8
  %54 = load %struct.pyobj_struct** %b, align 8
  %55 = getelementptr inbounds %struct.pyobj_struct* %54, i32 0, i32 1
  %56 = bitcast %union.anon* %55 to %struct.hashtable**
  %57 = load %struct.hashtable** %56, align 8
  %58 = call i32 @hashtable_count(%struct.hashtable* %57)
  %59 = icmp eq i32 %58, 0
  br i1 %59, label %60, label %63

; <label>:60                                      ; preds = %53
  %61 = load i64* %h2, align 8
  %62 = trunc i64 %61 to i32
  store i32 %62, i32* %1
  br label %88

; <label>:63                                      ; preds = %53
  %64 = load %struct.pyobj_struct** %b, align 8
  %65 = getelementptr inbounds %struct.pyobj_struct* %64, i32 0, i32 1
  %66 = bitcast %union.anon* %65 to %struct.hashtable**
  %67 = load %struct.hashtable** %66, align 8
  %68 = call %struct.hashtable_itr* @hashtable_iterator(%struct.hashtable* %67)
  store %struct.hashtable_itr* %68, %struct.hashtable_itr** %i1, align 8
  br label %69

; <label>:69                                      ; preds = %77, %63
  %70 = load i64* %h2, align 8
  %71 = mul i64 5, %70
  %72 = load %struct.hashtable_itr** %i1, align 8
  %73 = call i8* @hashtable_iterator_value(%struct.hashtable_itr* %72)
  %74 = call i32 @hash_any(i8* %73)
  %75 = zext i32 %74 to i64
  %76 = add i64 %71, %75
  store i64 %76, i64* %h2, align 8
  br label %77

; <label>:77                                      ; preds = %69
  %78 = load %struct.hashtable_itr** %i1, align 8
  %79 = call i32 @hashtable_iterator_advance(%struct.hashtable_itr* %78)
  %80 = icmp ne i32 %79, 0
  br i1 %80, label %69, label %81

; <label>:81                                      ; preds = %77
  %82 = load i64* %h2, align 8
  %83 = trunc i64 %82 to i32
  store i32 %83, i32* %1
  br label %88

; <label>:84                                      ; preds = %18
  %85 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([30 x i8]* @.str41, i32 0, i32 0))
  call void @exit(i32 1) #6
  unreachable

; <label>:86                                      ; preds = %0
  %87 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([30 x i8]* @.str41, i32 0, i32 0))
  call void @exit(i32 1) #6
  unreachable

; <label>:88                                      ; preds = %81, %60, %50, %15, %11, %8
  %89 = load i32* %1
  ret i32 %89
}

; Function Attrs: nounwind ssp uwtable
define internal i32 @equal_any(i8* %a, i8* %b) #0 {
  %1 = alloca i8*, align 8
  %2 = alloca i8*, align 8
  store i8* %a, i8** %1, align 8
  store i8* %b, i8** %2, align 8
  %3 = load i8** %1, align 8
  %4 = bitcast i8* %3 to %struct.base_pyobj*
  %5 = load i8** %2, align 8
  %6 = bitcast i8* %5 to %struct.base_pyobj*
  %7 = call i32 @equal_pyobj(%struct.base_pyobj* byval align 8 %4, %struct.base_pyobj* byval align 8 %6)
  ret i32 %7
}

; Function Attrs: nounwind ssp uwtable
define %struct.pyobj_struct* @add(%struct.pyobj_struct* %a, %struct.pyobj_struct* %b) #0 {
  %1 = alloca %struct.pyobj_struct*, align 8
  %2 = alloca %struct.pyobj_struct*, align 8
  %3 = alloca %struct.list_struct, align 8
  store %struct.pyobj_struct* %a, %struct.pyobj_struct** %1, align 8
  store %struct.pyobj_struct* %b, %struct.pyobj_struct** %2, align 8
  %4 = load %struct.pyobj_struct** %1, align 8
  %5 = getelementptr inbounds %struct.pyobj_struct* %4, i32 0, i32 0
  %6 = load i32* %5, align 4
  switch i32 %6, label %42 [
    i32 0, label %7
  ]

; <label>:7                                       ; preds = %0
  %8 = load %struct.pyobj_struct** %2, align 8
  %9 = getelementptr inbounds %struct.pyobj_struct* %8, i32 0, i32 0
  %10 = load i32* %9, align 4
  switch i32 %10, label %40 [
    i32 0, label %11
  ]

; <label>:11                                      ; preds = %7
  %12 = load %struct.pyobj_struct** %1, align 8
  %13 = getelementptr inbounds %struct.pyobj_struct* %12, i32 0, i32 1
  %14 = bitcast %union.anon* %13 to %struct.list_struct*
  %15 = load %struct.pyobj_struct** %2, align 8
  %16 = getelementptr inbounds %struct.pyobj_struct* %15, i32 0, i32 1
  %17 = bitcast %union.anon* %16 to %struct.list_struct*
  %18 = bitcast %struct.list_struct* %14 to { %struct.base_pyobj*, i32 }*
  %19 = getelementptr { %struct.base_pyobj*, i32 }* %18, i32 0, i32 0
  %20 = load %struct.base_pyobj** %19, align 1
  %21 = getelementptr { %struct.base_pyobj*, i32 }* %18, i32 0, i32 1
  %22 = load i32* %21, align 1
  %23 = bitcast %struct.list_struct* %17 to { %struct.base_pyobj*, i32 }*
  %24 = getelementptr { %struct.base_pyobj*, i32 }* %23, i32 0, i32 0
  %25 = load %struct.base_pyobj** %24, align 1
  %26 = getelementptr { %struct.base_pyobj*, i32 }* %23, i32 0, i32 1
  %27 = load i32* %26, align 1
  %28 = call { %struct.base_pyobj*, i32 } @list_add(%struct.base_pyobj* %20, i32 %22, %struct.base_pyobj* %25, i32 %27)
  %29 = bitcast %struct.list_struct* %3 to { %struct.base_pyobj*, i32 }*
  %30 = getelementptr { %struct.base_pyobj*, i32 }* %29, i32 0, i32 0
  %31 = extractvalue { %struct.base_pyobj*, i32 } %28, 0
  store %struct.base_pyobj* %31, %struct.base_pyobj** %30, align 1
  %32 = getelementptr { %struct.base_pyobj*, i32 }* %29, i32 0, i32 1
  %33 = extractvalue { %struct.base_pyobj*, i32 } %28, 1
  store i32 %33, i32* %32, align 1
  %34 = bitcast %struct.list_struct* %3 to { %struct.base_pyobj*, i32 }*
  %35 = getelementptr { %struct.base_pyobj*, i32 }* %34, i32 0, i32 0
  %36 = load %struct.base_pyobj** %35, align 1
  %37 = getelementptr { %struct.base_pyobj*, i32 }* %34, i32 0, i32 1
  %38 = load i32* %37, align 1
  %39 = call %struct.pyobj_struct* @list_to_big(%struct.base_pyobj* %36, i32 %38)
  ret %struct.pyobj_struct* %39

; <label>:40                                      ; preds = %7
  %41 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([31 x i8]* @.str9, i32 0, i32 0))
  call void @exit(i32 -1) #6
  unreachable

; <label>:42                                      ; preds = %0
  %43 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([31 x i8]* @.str9, i32 0, i32 0))
  call void @exit(i32 -1) #6
  unreachable
}

; Function Attrs: nounwind ssp uwtable
define internal { %struct.base_pyobj*, i32 } @list_add(%struct.base_pyobj* %a.coerce0, i32 %a.coerce1, %struct.base_pyobj* %b.coerce0, i32 %b.coerce1) #0 {
  %1 = alloca %struct.list_struct, align 8
  %a = alloca %struct.list_struct, align 8
  %b = alloca %struct.list_struct, align 8
  %c = alloca %struct.list_struct, align 8
  %i = alloca i64, align 8
  %2 = bitcast %struct.list_struct* %a to { %struct.base_pyobj*, i32 }*
  %3 = getelementptr { %struct.base_pyobj*, i32 }* %2, i32 0, i32 0
  store %struct.base_pyobj* %a.coerce0, %struct.base_pyobj** %3
  %4 = getelementptr { %struct.base_pyobj*, i32 }* %2, i32 0, i32 1
  store i32 %a.coerce1, i32* %4
  %5 = bitcast %struct.list_struct* %b to { %struct.base_pyobj*, i32 }*
  %6 = getelementptr { %struct.base_pyobj*, i32 }* %5, i32 0, i32 0
  store %struct.base_pyobj* %b.coerce0, %struct.base_pyobj** %6
  %7 = getelementptr { %struct.base_pyobj*, i32 }* %5, i32 0, i32 1
  store i32 %b.coerce1, i32* %7
  %8 = getelementptr inbounds %struct.list_struct* %a, i32 0, i32 1
  %9 = load i32* %8, align 4
  %10 = getelementptr inbounds %struct.list_struct* %b, i32 0, i32 1
  %11 = load i32* %10, align 4
  %12 = add i32 %9, %11
  %13 = getelementptr inbounds %struct.list_struct* %c, i32 0, i32 1
  store i32 %12, i32* %13, align 4
  %14 = getelementptr inbounds %struct.list_struct* %c, i32 0, i32 1
  %15 = load i32* %14, align 4
  %16 = zext i32 %15 to i64
  %17 = mul i64 24, %16
  %18 = call i8* @malloc(i64 %17)
  %19 = bitcast i8* %18 to %struct.base_pyobj*
  %20 = getelementptr inbounds %struct.list_struct* %c, i32 0, i32 0
  store %struct.base_pyobj* %19, %struct.base_pyobj** %20, align 8
  store i64 0, i64* %i, align 8
  br label %21

; <label>:21                                      ; preds = %38, %0
  %22 = load i64* %i, align 8
  %23 = getelementptr inbounds %struct.list_struct* %a, i32 0, i32 1
  %24 = load i32* %23, align 4
  %25 = zext i32 %24 to i64
  %26 = icmp ne i64 %22, %25
  br i1 %26, label %27, label %41

; <label>:27                                      ; preds = %21
  %28 = load i64* %i, align 8
  %29 = getelementptr inbounds %struct.list_struct* %c, i32 0, i32 0
  %30 = load %struct.base_pyobj** %29, align 8
  %31 = getelementptr inbounds %struct.base_pyobj* %30, i64 %28
  %32 = load i64* %i, align 8
  %33 = getelementptr inbounds %struct.list_struct* %a, i32 0, i32 0
  %34 = load %struct.base_pyobj** %33, align 8
  %35 = getelementptr inbounds %struct.base_pyobj* %34, i64 %32
  %36 = bitcast %struct.base_pyobj* %31 to i8*
  %37 = bitcast %struct.base_pyobj* %35 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %36, i8* %37, i64 24, i32 8, i1 false)
  br label %38

; <label>:38                                      ; preds = %27
  %39 = load i64* %i, align 8
  %40 = add i64 %39, 1
  store i64 %40, i64* %i, align 8
  br label %21

; <label>:41                                      ; preds = %21
  store i64 0, i64* %i, align 8
  br label %42

; <label>:42                                      ; preds = %63, %41
  %43 = load i64* %i, align 8
  %44 = getelementptr inbounds %struct.list_struct* %b, i32 0, i32 1
  %45 = load i32* %44, align 4
  %46 = zext i32 %45 to i64
  %47 = icmp ne i64 %43, %46
  br i1 %47, label %48, label %66

; <label>:48                                      ; preds = %42
  %49 = getelementptr inbounds %struct.list_struct* %a, i32 0, i32 1
  %50 = load i32* %49, align 4
  %51 = zext i32 %50 to i64
  %52 = load i64* %i, align 8
  %53 = add i64 %51, %52
  %54 = getelementptr inbounds %struct.list_struct* %c, i32 0, i32 0
  %55 = load %struct.base_pyobj** %54, align 8
  %56 = getelementptr inbounds %struct.base_pyobj* %55, i64 %53
  %57 = load i64* %i, align 8
  %58 = getelementptr inbounds %struct.list_struct* %b, i32 0, i32 0
  %59 = load %struct.base_pyobj** %58, align 8
  %60 = getelementptr inbounds %struct.base_pyobj* %59, i64 %57
  %61 = bitcast %struct.base_pyobj* %56 to i8*
  %62 = bitcast %struct.base_pyobj* %60 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %61, i8* %62, i64 24, i32 8, i1 false)
  br label %63

; <label>:63                                      ; preds = %48
  %64 = load i64* %i, align 8
  %65 = add i64 %64, 1
  store i64 %65, i64* %i, align 8
  br label %42

; <label>:66                                      ; preds = %42
  %67 = bitcast %struct.list_struct* %1 to i8*
  %68 = bitcast %struct.list_struct* %c to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %67, i8* %68, i64 16, i32 8, i1 false)
  %69 = bitcast %struct.list_struct* %1 to { %struct.base_pyobj*, i32 }*
  %70 = load { %struct.base_pyobj*, i32 }* %69, align 1
  ret { %struct.base_pyobj*, i32 } %70
}

; Function Attrs: noreturn
declare void @exit(i32) #3

; Function Attrs: nounwind ssp uwtable
define i32 @equal(%struct.pyobj_struct* %a, %struct.pyobj_struct* %b) #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.pyobj_struct*, align 8
  %3 = alloca %struct.pyobj_struct*, align 8
  store %struct.pyobj_struct* %a, %struct.pyobj_struct** %2, align 8
  store %struct.pyobj_struct* %b, %struct.pyobj_struct** %3, align 8
  %4 = load %struct.pyobj_struct** %2, align 8
  %5 = getelementptr inbounds %struct.pyobj_struct* %4, i32 0, i32 0
  %6 = load i32* %5, align 4
  switch i32 %6, label %56 [
    i32 0, label %7
    i32 1, label %30
    i32 3, label %46
  ]

; <label>:7                                       ; preds = %0
  %8 = load %struct.pyobj_struct** %3, align 8
  %9 = getelementptr inbounds %struct.pyobj_struct* %8, i32 0, i32 0
  %10 = load i32* %9, align 4
  switch i32 %10, label %29 [
    i32 0, label %11
  ]

; <label>:11                                      ; preds = %7
  %12 = load %struct.pyobj_struct** %2, align 8
  %13 = getelementptr inbounds %struct.pyobj_struct* %12, i32 0, i32 1
  %14 = bitcast %union.anon* %13 to %struct.list_struct*
  %15 = load %struct.pyobj_struct** %3, align 8
  %16 = getelementptr inbounds %struct.pyobj_struct* %15, i32 0, i32 1
  %17 = bitcast %union.anon* %16 to %struct.list_struct*
  %18 = bitcast %struct.list_struct* %14 to { %struct.base_pyobj*, i32 }*
  %19 = getelementptr { %struct.base_pyobj*, i32 }* %18, i32 0, i32 0
  %20 = load %struct.base_pyobj** %19, align 1
  %21 = getelementptr { %struct.base_pyobj*, i32 }* %18, i32 0, i32 1
  %22 = load i32* %21, align 1
  %23 = bitcast %struct.list_struct* %17 to { %struct.base_pyobj*, i32 }*
  %24 = getelementptr { %struct.base_pyobj*, i32 }* %23, i32 0, i32 0
  %25 = load %struct.base_pyobj** %24, align 1
  %26 = getelementptr { %struct.base_pyobj*, i32 }* %23, i32 0, i32 1
  %27 = load i32* %26, align 1
  %28 = call i32 @list_equal(%struct.base_pyobj* %20, i32 %22, %struct.base_pyobj* %25, i32 %27)
  store i32 %28, i32* %1
  br label %57

; <label>:29                                      ; preds = %7
  store i32 0, i32* %1
  br label %57

; <label>:30                                      ; preds = %0
  %31 = load %struct.pyobj_struct** %3, align 8
  %32 = getelementptr inbounds %struct.pyobj_struct* %31, i32 0, i32 0
  %33 = load i32* %32, align 4
  switch i32 %33, label %45 [
    i32 1, label %34
  ]

; <label>:34                                      ; preds = %30
  %35 = load %struct.pyobj_struct** %2, align 8
  %36 = getelementptr inbounds %struct.pyobj_struct* %35, i32 0, i32 1
  %37 = bitcast %union.anon* %36 to %struct.hashtable**
  %38 = load %struct.hashtable** %37, align 8
  %39 = load %struct.pyobj_struct** %3, align 8
  %40 = getelementptr inbounds %struct.pyobj_struct* %39, i32 0, i32 1
  %41 = bitcast %union.anon* %40 to %struct.hashtable**
  %42 = load %struct.hashtable** %41, align 8
  %43 = call signext i8 @dict_equal(%struct.hashtable* %38, %struct.hashtable* %42)
  %44 = sext i8 %43 to i32
  store i32 %44, i32* %1
  br label %57

; <label>:45                                      ; preds = %30
  store i32 0, i32* %1
  br label %57

; <label>:46                                      ; preds = %0
  %47 = load %struct.pyobj_struct** %3, align 8
  %48 = getelementptr inbounds %struct.pyobj_struct* %47, i32 0, i32 0
  %49 = load i32* %48, align 4
  switch i32 %49, label %55 [
    i32 3, label %50
  ]

; <label>:50                                      ; preds = %46
  %51 = load %struct.pyobj_struct** %2, align 8
  %52 = load %struct.pyobj_struct** %3, align 8
  %53 = icmp eq %struct.pyobj_struct* %51, %52
  %54 = zext i1 %53 to i32
  store i32 %54, i32* %1
  br label %57

; <label>:55                                      ; preds = %46
  store i32 0, i32* %1
  br label %57

; <label>:56                                      ; preds = %0
  store i32 0, i32* %1
  br label %57

; <label>:57                                      ; preds = %56, %55, %50, %45, %34, %29, %11
  %58 = load i32* %1
  ret i32 %58
}

; Function Attrs: nounwind ssp uwtable
define internal i32 @list_equal(%struct.base_pyobj* %x.coerce0, i32 %x.coerce1, %struct.base_pyobj* %y.coerce0, i32 %y.coerce1) #0 {
  %1 = alloca i32, align 4
  %x = alloca %struct.list_struct, align 8
  %y = alloca %struct.list_struct, align 8
  %eq = alloca i8, align 1
  %i = alloca i32, align 4
  %2 = bitcast %struct.list_struct* %x to { %struct.base_pyobj*, i32 }*
  %3 = getelementptr { %struct.base_pyobj*, i32 }* %2, i32 0, i32 0
  store %struct.base_pyobj* %x.coerce0, %struct.base_pyobj** %3
  %4 = getelementptr { %struct.base_pyobj*, i32 }* %2, i32 0, i32 1
  store i32 %x.coerce1, i32* %4
  %5 = bitcast %struct.list_struct* %y to { %struct.base_pyobj*, i32 }*
  %6 = getelementptr { %struct.base_pyobj*, i32 }* %5, i32 0, i32 0
  store %struct.base_pyobj* %y.coerce0, %struct.base_pyobj** %6
  %7 = getelementptr { %struct.base_pyobj*, i32 }* %5, i32 0, i32 1
  store i32 %y.coerce1, i32* %7
  store i8 1, i8* %eq, align 1
  store i32 0, i32* %i, align 4
  br label %8

; <label>:8                                       ; preds = %37, %0
  %9 = load i32* %i, align 4
  %10 = getelementptr inbounds %struct.list_struct* %x, i32 0, i32 1
  %11 = load i32* %10, align 4
  %12 = getelementptr inbounds %struct.list_struct* %y, i32 0, i32 1
  %13 = load i32* %12, align 4
  %14 = call i32 @min(i32 %11, i32 %13)
  %15 = icmp ne i32 %9, %14
  br i1 %15, label %16, label %40

; <label>:16                                      ; preds = %8
  %17 = load i8* %eq, align 1
  %18 = sext i8 %17 to i32
  %19 = icmp ne i32 %18, 0
  br i1 %19, label %20, label %33

; <label>:20                                      ; preds = %16
  %21 = load i32* %i, align 4
  %22 = sext i32 %21 to i64
  %23 = getelementptr inbounds %struct.list_struct* %x, i32 0, i32 0
  %24 = load %struct.base_pyobj** %23, align 8
  %25 = getelementptr inbounds %struct.base_pyobj* %24, i64 %22
  %26 = load i32* %i, align 4
  %27 = sext i32 %26 to i64
  %28 = getelementptr inbounds %struct.list_struct* %y, i32 0, i32 0
  %29 = load %struct.base_pyobj** %28, align 8
  %30 = getelementptr inbounds %struct.base_pyobj* %29, i64 %27
  %31 = call i32 @equal_pyobj(%struct.base_pyobj* byval align 8 %25, %struct.base_pyobj* byval align 8 %30)
  %32 = icmp ne i32 %31, 0
  br label %33

; <label>:33                                      ; preds = %20, %16
  %34 = phi i1 [ false, %16 ], [ %32, %20 ]
  %35 = zext i1 %34 to i32
  %36 = trunc i32 %35 to i8
  store i8 %36, i8* %eq, align 1
  br label %37

; <label>:37                                      ; preds = %33
  %38 = load i32* %i, align 4
  %39 = add nsw i32 %38, 1
  store i32 %39, i32* %i, align 4
  br label %8

; <label>:40                                      ; preds = %8
  %41 = getelementptr inbounds %struct.list_struct* %x, i32 0, i32 1
  %42 = load i32* %41, align 4
  %43 = getelementptr inbounds %struct.list_struct* %y, i32 0, i32 1
  %44 = load i32* %43, align 4
  %45 = icmp eq i32 %42, %44
  br i1 %45, label %46, label %49

; <label>:46                                      ; preds = %40
  %47 = load i8* %eq, align 1
  %48 = sext i8 %47 to i32
  store i32 %48, i32* %1
  br label %50

; <label>:49                                      ; preds = %40
  store i32 0, i32* %1
  br label %50

; <label>:50                                      ; preds = %49, %46
  %51 = load i32* %1
  ret i32 %51
}

; Function Attrs: nounwind ssp uwtable
define internal signext i8 @dict_equal(%struct.hashtable* %x, %struct.hashtable* %y) #0 {
  %1 = alloca i8, align 1
  %2 = alloca %struct.hashtable*, align 8
  %3 = alloca %struct.hashtable*, align 8
  %will_reset = alloca i8, align 1
  %same = alloca i8, align 1
  %max = alloca i32, align 4
  %itr_a = alloca %struct.hashtable_itr*, align 8
  %itr_b = alloca %struct.hashtable_itr*, align 8
  %k_a = alloca %struct.base_pyobj, align 8
  %v_a = alloca %struct.base_pyobj, align 8
  %k_b = alloca %struct.base_pyobj, align 8
  %v_b = alloca %struct.base_pyobj, align 8
  store %struct.hashtable* %x, %struct.hashtable** %2, align 8
  store %struct.hashtable* %y, %struct.hashtable** %3, align 8
  %4 = load %struct.hashtable** %2, align 8
  %5 = call i32 @hashtable_count(%struct.hashtable* %4)
  %6 = load %struct.hashtable** %3, align 8
  %7 = call i32 @hashtable_count(%struct.hashtable* %6)
  %8 = icmp ne i32 %5, %7
  br i1 %8, label %9, label %10

; <label>:9                                       ; preds = %0
  store i8 0, i8* %1
  br label %121

; <label>:10                                      ; preds = %0
  %11 = load %struct.hashtable** @current_cmp_a, align 8
  %12 = icmp ne %struct.hashtable* %11, null
  br i1 %12, label %13, label %35

; <label>:13                                      ; preds = %10
  %14 = load %struct.hashtable** @current_cmp_a, align 8
  %15 = load %struct.hashtable** %2, align 8
  %16 = icmp eq %struct.hashtable* %14, %15
  br i1 %16, label %17, label %23

; <label>:17                                      ; preds = %13
  %18 = load %struct.hashtable** @current_cmp_a, align 8
  %19 = load %struct.hashtable** %3, align 8
  %20 = icmp eq %struct.hashtable* %18, %19
  %21 = zext i1 %20 to i32
  %22 = trunc i32 %21 to i8
  store i8 %22, i8* %1
  br label %121

; <label>:23                                      ; preds = %13
  %24 = load %struct.hashtable** @current_cmp_a, align 8
  %25 = load %struct.hashtable** %3, align 8
  %26 = icmp eq %struct.hashtable* %24, %25
  br i1 %26, label %27, label %33

; <label>:27                                      ; preds = %23
  %28 = load %struct.hashtable** @current_cmp_a, align 8
  %29 = load %struct.hashtable** %2, align 8
  %30 = icmp eq %struct.hashtable* %28, %29
  %31 = zext i1 %30 to i32
  %32 = trunc i32 %31 to i8
  store i8 %32, i8* %1
  br label %121

; <label>:33                                      ; preds = %23
  br label %34

; <label>:34                                      ; preds = %33
  br label %35

; <label>:35                                      ; preds = %34, %10
  %36 = load %struct.hashtable** @current_cmp_b, align 8
  %37 = icmp ne %struct.hashtable* %36, null
  br i1 %37, label %38, label %60

; <label>:38                                      ; preds = %35
  %39 = load %struct.hashtable** @current_cmp_b, align 8
  %40 = load %struct.hashtable** %3, align 8
  %41 = icmp eq %struct.hashtable* %39, %40
  br i1 %41, label %42, label %48

; <label>:42                                      ; preds = %38
  %43 = load %struct.hashtable** @current_cmp_b, align 8
  %44 = load %struct.hashtable** %2, align 8
  %45 = icmp eq %struct.hashtable* %43, %44
  %46 = zext i1 %45 to i32
  %47 = trunc i32 %46 to i8
  store i8 %47, i8* %1
  br label %121

; <label>:48                                      ; preds = %38
  %49 = load %struct.hashtable** @current_cmp_b, align 8
  %50 = load %struct.hashtable** %2, align 8
  %51 = icmp eq %struct.hashtable* %49, %50
  br i1 %51, label %52, label %58

; <label>:52                                      ; preds = %48
  %53 = load %struct.hashtable** @current_cmp_b, align 8
  %54 = load %struct.hashtable** %3, align 8
  %55 = icmp eq %struct.hashtable* %53, %54
  %56 = zext i1 %55 to i32
  %57 = trunc i32 %56 to i8
  store i8 %57, i8* %1
  br label %121

; <label>:58                                      ; preds = %48
  br label %59

; <label>:59                                      ; preds = %58
  br label %60

; <label>:60                                      ; preds = %59, %35
  store i8 0, i8* %will_reset, align 1
  store i8 1, i8* %same, align 1
  %61 = load %struct.hashtable** @current_cmp_a, align 8
  %62 = icmp ne %struct.hashtable* %61, null
  br i1 %62, label %66, label %63

; <label>:63                                      ; preds = %60
  %64 = load %struct.hashtable** %2, align 8
  store %struct.hashtable* %64, %struct.hashtable** @current_cmp_a, align 8
  %65 = load %struct.hashtable** %3, align 8
  store %struct.hashtable* %65, %struct.hashtable** @current_cmp_b, align 8
  store i8 1, i8* %will_reset, align 1
  br label %66

; <label>:66                                      ; preds = %63, %60
  %67 = load %struct.hashtable** %2, align 8
  %68 = call i32 @hashtable_count(%struct.hashtable* %67)
  store i32 %68, i32* %max, align 4
  %69 = load %struct.hashtable** %2, align 8
  %70 = call %struct.hashtable_itr* @hashtable_iterator(%struct.hashtable* %69)
  store %struct.hashtable_itr* %70, %struct.hashtable_itr** %itr_a, align 8
  %71 = load %struct.hashtable** %3, align 8
  %72 = call %struct.hashtable_itr* @hashtable_iterator(%struct.hashtable* %71)
  store %struct.hashtable_itr* %72, %struct.hashtable_itr** %itr_b, align 8
  %73 = load i32* %max, align 4
  %74 = icmp ne i32 %73, 0
  br i1 %74, label %75, label %115

; <label>:75                                      ; preds = %66
  br label %76

; <label>:76                                      ; preds = %112, %75
  %77 = load %struct.hashtable_itr** %itr_a, align 8
  %78 = call i8* @hashtable_iterator_key(%struct.hashtable_itr* %77)
  %79 = bitcast i8* %78 to %struct.base_pyobj*
  %80 = bitcast %struct.base_pyobj* %k_a to i8*
  %81 = bitcast %struct.base_pyobj* %79 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %80, i8* %81, i64 24, i32 8, i1 false)
  %82 = load %struct.hashtable_itr** %itr_a, align 8
  %83 = call i8* @hashtable_iterator_value(%struct.hashtable_itr* %82)
  %84 = bitcast i8* %83 to %struct.base_pyobj*
  %85 = bitcast %struct.base_pyobj* %v_a to i8*
  %86 = bitcast %struct.base_pyobj* %84 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %85, i8* %86, i64 24, i32 8, i1 false)
  %87 = load %struct.hashtable_itr** %itr_b, align 8
  %88 = call i8* @hashtable_iterator_key(%struct.hashtable_itr* %87)
  %89 = bitcast i8* %88 to %struct.base_pyobj*
  %90 = bitcast %struct.base_pyobj* %k_b to i8*
  %91 = bitcast %struct.base_pyobj* %89 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %90, i8* %91, i64 24, i32 8, i1 false)
  %92 = load %struct.hashtable_itr** %itr_b, align 8
  %93 = call i8* @hashtable_iterator_value(%struct.hashtable_itr* %92)
  %94 = bitcast i8* %93 to %struct.base_pyobj*
  %95 = bitcast %struct.base_pyobj* %v_b to i8*
  %96 = bitcast %struct.base_pyobj* %94 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %95, i8* %96, i64 24, i32 8, i1 false)
  %97 = call i32 @equal_pyobj(%struct.base_pyobj* byval align 8 %k_a, %struct.base_pyobj* byval align 8 %k_b)
  %98 = icmp ne i32 %97, 0
  br i1 %98, label %99, label %102

; <label>:99                                      ; preds = %76
  %100 = call i32 @equal_pyobj(%struct.base_pyobj* byval align 8 %v_a, %struct.base_pyobj* byval align 8 %v_b)
  %101 = icmp ne i32 %100, 0
  br i1 %101, label %103, label %102

; <label>:102                                     ; preds = %99, %76
  store i8 0, i8* %same, align 1
  br label %103

; <label>:103                                     ; preds = %102, %99
  br label %104

; <label>:104                                     ; preds = %103
  %105 = load %struct.hashtable_itr** %itr_a, align 8
  %106 = call i32 @hashtable_iterator_advance(%struct.hashtable_itr* %105)
  %107 = icmp ne i32 %106, 0
  br i1 %107, label %108, label %112

; <label>:108                                     ; preds = %104
  %109 = load %struct.hashtable_itr** %itr_b, align 8
  %110 = call i32 @hashtable_iterator_advance(%struct.hashtable_itr* %109)
  %111 = icmp ne i32 %110, 0
  br label %112

; <label>:112                                     ; preds = %108, %104
  %113 = phi i1 [ false, %104 ], [ %111, %108 ]
  br i1 %113, label %76, label %114

; <label>:114                                     ; preds = %112
  br label %115

; <label>:115                                     ; preds = %114, %66
  %116 = load i8* %will_reset, align 1
  %117 = icmp ne i8 %116, 0
  br i1 %117, label %118, label %119

; <label>:118                                     ; preds = %115
  store %struct.hashtable* null, %struct.hashtable** @current_cmp_a, align 8
  store %struct.hashtable* null, %struct.hashtable** @current_cmp_b, align 8
  br label %119

; <label>:119                                     ; preds = %118, %115
  %120 = load i8* %same, align 1
  store i8 %120, i8* %1
  br label %121

; <label>:121                                     ; preds = %119, %52, %42, %27, %17, %9
  %122 = load i8* %1
  ret i8 %122
}

; Function Attrs: nounwind ssp uwtable
define i32 @not_equal(%struct.pyobj_struct* %x, %struct.pyobj_struct* %y) #0 {
  %1 = alloca %struct.pyobj_struct*, align 8
  %2 = alloca %struct.pyobj_struct*, align 8
  store %struct.pyobj_struct* %x, %struct.pyobj_struct** %1, align 8
  store %struct.pyobj_struct* %y, %struct.pyobj_struct** %2, align 8
  %3 = load %struct.pyobj_struct** %1, align 8
  %4 = load %struct.pyobj_struct** %2, align 8
  %5 = call i32 @equal(%struct.pyobj_struct* %3, %struct.pyobj_struct* %4)
  %6 = icmp ne i32 %5, 0
  %7 = xor i1 %6, true
  %8 = zext i1 %7 to i32
  ret i32 %8
}

; Function Attrs: nounwind ssp uwtable
define void @set_subscript(%struct.base_pyobj* noalias sret %agg.result, %struct.base_pyobj* byval align 8 %c, %struct.base_pyobj* byval align 8 %key, %struct.base_pyobj* byval align 8 %val) #0 {
  %b = alloca %struct.pyobj_struct*, align 8
  %1 = call i32 @tag(%struct.base_pyobj* byval align 8 %c)
  switch i32 %1, label %5 [
    i32 3, label %2
  ]

; <label>:2                                       ; preds = %0
  %3 = call %struct.pyobj_struct* @project_big(%struct.base_pyobj* byval align 8 %c)
  store %struct.pyobj_struct* %3, %struct.pyobj_struct** %b, align 8
  %4 = load %struct.pyobj_struct** %b, align 8
  call void @subscript_assign(%struct.base_pyobj* sret %agg.result, %struct.pyobj_struct* %4, %struct.base_pyobj* byval align 8 %key, %struct.base_pyobj* byval align 8 %val)
  ret void

; <label>:5                                       ; preds = %0
  %6 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([50 x i8]* @.str10, i32 0, i32 0))
  call void @__assert_rtn(i8* getelementptr inbounds ([14 x i8]* @__func__.set_subscript, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8]* @.str, i32 0, i32 0), i32 721, i8* getelementptr inbounds ([2 x i8]* @.str11, i32 0, i32 0)) #6
  unreachable
}

; Function Attrs: nounwind ssp uwtable
define internal void @subscript_assign(%struct.base_pyobj* noalias sret %agg.result, %struct.pyobj_struct* %c, %struct.base_pyobj* byval align 8 %key, %struct.base_pyobj* byval align 8 %val) #0 {
  %1 = alloca %struct.pyobj_struct*, align 8
  store %struct.pyobj_struct* %c, %struct.pyobj_struct** %1, align 8
  %2 = load %struct.pyobj_struct** %1, align 8
  %3 = getelementptr inbounds %struct.pyobj_struct* %2, i32 0, i32 0
  %4 = load i32* %3, align 4
  switch i32 %4, label %29 [
    i32 0, label %5
    i32 1, label %19
  ]

; <label>:5                                       ; preds = %0
  %6 = load %struct.pyobj_struct** %1, align 8
  %7 = getelementptr inbounds %struct.pyobj_struct* %6, i32 0, i32 1
  %8 = bitcast %union.anon* %7 to %struct.list_struct*
  %9 = bitcast %struct.list_struct* %8 to { %struct.base_pyobj*, i32 }*
  %10 = getelementptr { %struct.base_pyobj*, i32 }* %9, i32 0, i32 0
  %11 = load %struct.base_pyobj** %10, align 1
  %12 = getelementptr { %struct.base_pyobj*, i32 }* %9, i32 0, i32 1
  %13 = load i32* %12, align 1
  %14 = call %struct.base_pyobj* @list_subscript(%struct.base_pyobj* %11, i32 %13, %struct.base_pyobj* byval align 8 %key)
  %15 = bitcast %struct.base_pyobj* %14 to i8*
  %16 = bitcast %struct.base_pyobj* %val to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %15, i8* %16, i64 24, i32 8, i1 false)
  %17 = bitcast %struct.base_pyobj* %agg.result to i8*
  %18 = bitcast %struct.base_pyobj* %14 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %17, i8* %18, i64 24, i32 8, i1 false)
  br label %31

; <label>:19                                      ; preds = %0
  %20 = load %struct.pyobj_struct** %1, align 8
  %21 = getelementptr inbounds %struct.pyobj_struct* %20, i32 0, i32 1
  %22 = bitcast %union.anon* %21 to %struct.hashtable**
  %23 = load %struct.hashtable** %22, align 8
  %24 = call %struct.base_pyobj* @dict_subscript(%struct.hashtable* %23, %struct.base_pyobj* byval align 8 %key)
  %25 = bitcast %struct.base_pyobj* %24 to i8*
  %26 = bitcast %struct.base_pyobj* %val to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %25, i8* %26, i64 24, i32 8, i1 false)
  %27 = bitcast %struct.base_pyobj* %agg.result to i8*
  %28 = bitcast %struct.base_pyobj* %24 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %27, i8* %28, i64 24, i32 8, i1 false)
  br label %31

; <label>:29                                      ; preds = %0
  %30 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([50 x i8]* @.str10, i32 0, i32 0))
  call void @__assert_rtn(i8* getelementptr inbounds ([17 x i8]* @__func__.subscript_assign, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8]* @.str, i32 0, i32 0), i32 708, i8* getelementptr inbounds ([2 x i8]* @.str11, i32 0, i32 0)) #6
  unreachable

; <label>:31                                      ; preds = %19, %5
  ret void
}

; Function Attrs: nounwind ssp uwtable
define void @get_subscript(%struct.base_pyobj* noalias sret %agg.result, %struct.base_pyobj* byval align 8 %c, %struct.base_pyobj* byval align 8 %key) #0 {
  %b = alloca %struct.pyobj_struct*, align 8
  %1 = call i32 @tag(%struct.base_pyobj* byval align 8 %c)
  switch i32 %1, label %5 [
    i32 3, label %2
  ]

; <label>:2                                       ; preds = %0
  %3 = call %struct.pyobj_struct* @project_big(%struct.base_pyobj* byval align 8 %c)
  store %struct.pyobj_struct* %3, %struct.pyobj_struct** %b, align 8
  %4 = load %struct.pyobj_struct** %b, align 8
  call void @subscript(%struct.base_pyobj* sret %agg.result, %struct.pyobj_struct* %4, %struct.base_pyobj* byval align 8 %key)
  ret void

; <label>:5                                       ; preds = %0
  %6 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([50 x i8]* @.str12, i32 0, i32 0))
  call void @__assert_rtn(i8* getelementptr inbounds ([14 x i8]* @__func__.get_subscript, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8]* @.str, i32 0, i32 0), i32 748, i8* getelementptr inbounds ([2 x i8]* @.str11, i32 0, i32 0)) #6
  unreachable
}

; Function Attrs: nounwind ssp uwtable
define internal void @subscript(%struct.base_pyobj* noalias sret %agg.result, %struct.pyobj_struct* %c, %struct.base_pyobj* byval align 8 %key) #0 {
  %1 = alloca %struct.pyobj_struct*, align 8
  store %struct.pyobj_struct* %c, %struct.pyobj_struct** %1, align 8
  %2 = load %struct.pyobj_struct** %1, align 8
  %3 = getelementptr inbounds %struct.pyobj_struct* %2, i32 0, i32 0
  %4 = load i32* %3, align 4
  switch i32 %4, label %25 [
    i32 0, label %5
    i32 1, label %17
  ]

; <label>:5                                       ; preds = %0
  %6 = load %struct.pyobj_struct** %1, align 8
  %7 = getelementptr inbounds %struct.pyobj_struct* %6, i32 0, i32 1
  %8 = bitcast %union.anon* %7 to %struct.list_struct*
  %9 = bitcast %struct.list_struct* %8 to { %struct.base_pyobj*, i32 }*
  %10 = getelementptr { %struct.base_pyobj*, i32 }* %9, i32 0, i32 0
  %11 = load %struct.base_pyobj** %10, align 1
  %12 = getelementptr { %struct.base_pyobj*, i32 }* %9, i32 0, i32 1
  %13 = load i32* %12, align 1
  %14 = call %struct.base_pyobj* @list_subscript(%struct.base_pyobj* %11, i32 %13, %struct.base_pyobj* byval align 8 %key)
  %15 = bitcast %struct.base_pyobj* %agg.result to i8*
  %16 = bitcast %struct.base_pyobj* %14 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %15, i8* %16, i64 24, i32 8, i1 false)
  br label %27

; <label>:17                                      ; preds = %0
  %18 = load %struct.pyobj_struct** %1, align 8
  %19 = getelementptr inbounds %struct.pyobj_struct* %18, i32 0, i32 1
  %20 = bitcast %union.anon* %19 to %struct.hashtable**
  %21 = load %struct.hashtable** %20, align 8
  %22 = call %struct.base_pyobj* @dict_subscript(%struct.hashtable* %21, %struct.base_pyobj* byval align 8 %key)
  %23 = bitcast %struct.base_pyobj* %agg.result to i8*
  %24 = bitcast %struct.base_pyobj* %22 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %23, i8* %24, i64 24, i32 8, i1 false)
  br label %27

; <label>:25                                      ; preds = %0
  %26 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([50 x i8]* @.str10, i32 0, i32 0))
  call void @__assert_rtn(i8* getelementptr inbounds ([10 x i8]* @__func__.subscript, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8]* @.str, i32 0, i32 0), i32 735, i8* getelementptr inbounds ([2 x i8]* @.str11, i32 0, i32 0)) #6
  unreachable

; <label>:27                                      ; preds = %17, %5
  ret void
}

; Function Attrs: nounwind ssp uwtable
define void @print_any(%struct.base_pyobj* byval align 8 %p) #0 {
  call void @print_pyobj(%struct.base_pyobj* byval align 8 %p)
  %1 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([2 x i8]* @.str13, i32 0, i32 0))
  ret void
}

; Function Attrs: nounwind ssp uwtable
define internal void @print_pyobj(%struct.base_pyobj* byval align 8 %x) #0 {
  %b = alloca %struct.pyobj_struct*, align 8
  %1 = call i32 @tag(%struct.base_pyobj* byval align 8 %x)
  switch i32 %1, label %18 [
    i32 0, label %2
    i32 1, label %4
    i32 2, label %6
    i32 3, label %9
  ]

; <label>:2                                       ; preds = %0
  %3 = call i32 @project_int(%struct.base_pyobj* byval align 8 %x)
  call void @print_int(i32 %3)
  br label %19

; <label>:4                                       ; preds = %0
  %5 = call i32 @project_bool(%struct.base_pyobj* byval align 8 %x)
  call void @print_bool(i32 %5)
  br label %19

; <label>:6                                       ; preds = %0
  %7 = call float @project_float(%struct.base_pyobj* byval align 8 %x)
  %8 = fpext float %7 to double
  call void @print_float(double %8)
  br label %19

; <label>:9                                       ; preds = %0
  %10 = call %struct.pyobj_struct* @project_big(%struct.base_pyobj* byval align 8 %x)
  store %struct.pyobj_struct* %10, %struct.pyobj_struct** %b, align 8
  %11 = load %struct.pyobj_struct** %b, align 8
  %12 = getelementptr inbounds %struct.pyobj_struct* %11, i32 0, i32 0
  %13 = load i32* %12, align 4
  switch i32 %13, label %16 [
    i32 1, label %14
    i32 0, label %15
  ]

; <label>:14                                      ; preds = %9
  call void @print_dict(%struct.base_pyobj* byval align 8 %x)
  br label %17

; <label>:15                                      ; preds = %9
  call void @print_list(%struct.base_pyobj* byval align 8 %x)
  br label %17

; <label>:16                                      ; preds = %9
  call void @__assert_rtn(i8* getelementptr inbounds ([12 x i8]* @__func__.print_pyobj, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8]* @.str, i32 0, i32 0), i32 178, i8* getelementptr inbounds ([2 x i8]* @.str11, i32 0, i32 0)) #6
  unreachable

; <label>:17                                      ; preds = %15, %14
  br label %19

; <label>:18                                      ; preds = %0
  call void @__assert_rtn(i8* getelementptr inbounds ([12 x i8]* @__func__.print_pyobj, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8]* @.str, i32 0, i32 0), i32 183, i8* getelementptr inbounds ([2 x i8]* @.str11, i32 0, i32 0)) #6
  unreachable

; <label>:19                                      ; preds = %17, %6, %4, %2
  ret void
}

; Function Attrs: nounwind ssp uwtable
define i32 @is_true(%struct.base_pyobj* byval align 8 %v) #0 {
  %1 = alloca i32, align 4
  %b = alloca %struct.pyobj_struct*, align 8
  %2 = call i32 @tag(%struct.base_pyobj* byval align 8 %v)
  switch i32 %2, label %41 [
    i32 0, label %3
    i32 2, label %7
    i32 1, label %11
    i32 3, label %15
  ]

; <label>:3                                       ; preds = %0
  %4 = call i32 @project_int(%struct.base_pyobj* byval align 8 %v)
  %5 = icmp ne i32 %4, 0
  %6 = zext i1 %5 to i32
  store i32 %6, i32* %1
  br label %42

; <label>:7                                       ; preds = %0
  %8 = call float @project_float(%struct.base_pyobj* byval align 8 %v)
  %9 = fcmp une float %8, 0.000000e+00
  %10 = zext i1 %9 to i32
  store i32 %10, i32* %1
  br label %42

; <label>:11                                      ; preds = %0
  %12 = call i32 @project_bool(%struct.base_pyobj* byval align 8 %v)
  %13 = icmp ne i32 %12, 0
  %14 = zext i1 %13 to i32
  store i32 %14, i32* %1
  br label %42

; <label>:15                                      ; preds = %0
  %16 = call %struct.pyobj_struct* @project_big(%struct.base_pyobj* byval align 8 %v)
  store %struct.pyobj_struct* %16, %struct.pyobj_struct** %b, align 8
  %17 = load %struct.pyobj_struct** %b, align 8
  %18 = getelementptr inbounds %struct.pyobj_struct* %17, i32 0, i32 0
  %19 = load i32* %18, align 4
  switch i32 %19, label %39 [
    i32 0, label %20
    i32 1, label %28
    i32 2, label %36
    i32 3, label %37
    i32 4, label %38
  ]

; <label>:20                                      ; preds = %15
  %21 = load %struct.pyobj_struct** %b, align 8
  %22 = getelementptr inbounds %struct.pyobj_struct* %21, i32 0, i32 1
  %23 = bitcast %union.anon* %22 to %struct.list_struct*
  %24 = getelementptr inbounds %struct.list_struct* %23, i32 0, i32 1
  %25 = load i32* %24, align 4
  %26 = icmp ne i32 %25, 0
  %27 = zext i1 %26 to i32
  store i32 %27, i32* %1
  br label %42

; <label>:28                                      ; preds = %15
  %29 = load %struct.pyobj_struct** %b, align 8
  %30 = getelementptr inbounds %struct.pyobj_struct* %29, i32 0, i32 1
  %31 = bitcast %union.anon* %30 to %struct.hashtable**
  %32 = load %struct.hashtable** %31, align 8
  %33 = call i32 @hashtable_count(%struct.hashtable* %32)
  %34 = icmp ugt i32 %33, 0
  %35 = zext i1 %34 to i32
  store i32 %35, i32* %1
  br label %42

; <label>:36                                      ; preds = %15
  store i32 1, i32* %1
  br label %42

; <label>:37                                      ; preds = %15
  store i32 1, i32* %1
  br label %42

; <label>:38                                      ; preds = %15
  store i32 1, i32* %1
  br label %42

; <label>:39                                      ; preds = %15
  %40 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([34 x i8]* @.str14, i32 0, i32 0))
  call void @__assert_rtn(i8* getelementptr inbounds ([8 x i8]* @__func__.is_true, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8]* @.str, i32 0, i32 0), i32 781, i8* getelementptr inbounds ([2 x i8]* @.str11, i32 0, i32 0)) #6
  unreachable

; <label>:41                                      ; preds = %0
  call void @__assert_rtn(i8* getelementptr inbounds ([8 x i8]* @__func__.is_true, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8]* @.str, i32 0, i32 0), i32 785, i8* getelementptr inbounds ([2 x i8]* @.str11, i32 0, i32 0)) #6
  unreachable

; <label>:42                                      ; preds = %38, %37, %36, %28, %20, %11, %7, %3
  %43 = load i32* %1
  ret i32 %43
}

declare i32 @hashtable_count(%struct.hashtable*) #4

; Function Attrs: nounwind ssp uwtable
define %struct.pyobj_struct* @create_closure(i8* %fun_ptr, %struct.base_pyobj* byval align 8 %free_vars) #0 {
  %1 = alloca i8*, align 8
  %f = alloca %struct.fun_struct, align 8
  store i8* %fun_ptr, i8** %1, align 8
  %2 = load i8** %1, align 8
  %3 = getelementptr inbounds %struct.fun_struct* %f, i32 0, i32 0
  store i8* %2, i8** %3, align 8
  %4 = getelementptr inbounds %struct.fun_struct* %f, i32 0, i32 1
  %5 = bitcast %struct.base_pyobj* %4 to i8*
  %6 = bitcast %struct.base_pyobj* %free_vars to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %5, i8* %6, i64 24, i32 8, i1 false)
  %7 = call %struct.pyobj_struct* @closure_to_big(%struct.fun_struct* byval align 8 %f)
  ret %struct.pyobj_struct* %7
}

; Function Attrs: nounwind ssp uwtable
define internal %struct.pyobj_struct* @closure_to_big(%struct.fun_struct* byval align 8 %f) #0 {
  %v = alloca %struct.pyobj_struct*, align 8
  %1 = call i8* @malloc(i64 72)
  %2 = bitcast i8* %1 to %struct.pyobj_struct*
  store %struct.pyobj_struct* %2, %struct.pyobj_struct** %v, align 8
  %3 = load %struct.pyobj_struct** %v, align 8
  %4 = getelementptr inbounds %struct.pyobj_struct* %3, i32 0, i32 0
  store i32 2, i32* %4, align 4
  %5 = load %struct.pyobj_struct** %v, align 8
  %6 = getelementptr inbounds %struct.pyobj_struct* %5, i32 0, i32 1
  %7 = bitcast %union.anon* %6 to %struct.fun_struct*
  %8 = bitcast %struct.fun_struct* %7 to i8*
  %9 = bitcast %struct.fun_struct* %f to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %8, i8* %9, i64 32, i32 8, i1 false)
  %10 = load %struct.pyobj_struct** %v, align 8
  ret %struct.pyobj_struct* %10
}

; Function Attrs: nounwind ssp uwtable
define i8* @get_fun_ptr(%struct.base_pyobj* byval align 8 %p) #0 {
  %b = alloca %struct.pyobj_struct*, align 8
  %1 = call %struct.pyobj_struct* @project_big(%struct.base_pyobj* byval align 8 %p)
  store %struct.pyobj_struct* %1, %struct.pyobj_struct** %b, align 8
  %2 = load %struct.pyobj_struct** %b, align 8
  %3 = getelementptr inbounds %struct.pyobj_struct* %2, i32 0, i32 0
  %4 = load i32* %3, align 4
  %5 = icmp eq i32 %4, 2
  %6 = xor i1 %5, true
  %7 = zext i1 %6 to i32
  %8 = sext i32 %7 to i64
  %9 = call i64 @llvm.expect.i64(i64 %8, i64 0)
  %10 = icmp ne i64 %9, 0
  br i1 %10, label %11, label %13

; <label>:11                                      ; preds = %0
  call void @__assert_rtn(i8* getelementptr inbounds ([12 x i8]* @__func__.get_fun_ptr, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8]* @.str, i32 0, i32 0), i32 808, i8* getelementptr inbounds ([14 x i8]* @.str15, i32 0, i32 0)) #6
  unreachable
                                                  ; No predecessors!
  br label %14

; <label>:13                                      ; preds = %0
  br label %14

; <label>:14                                      ; preds = %13, %12
  %15 = load %struct.pyobj_struct** %b, align 8
  %16 = getelementptr inbounds %struct.pyobj_struct* %15, i32 0, i32 1
  %17 = bitcast %union.anon* %16 to %struct.fun_struct*
  %18 = getelementptr inbounds %struct.fun_struct* %17, i32 0, i32 0
  %19 = load i8** %18, align 8
  ret i8* %19
}

; Function Attrs: nounwind ssp uwtable
define void @get_free_vars(%struct.base_pyobj* noalias sret %agg.result, %struct.base_pyobj* byval align 8 %p) #0 {
  %b = alloca %struct.pyobj_struct*, align 8
  %1 = call %struct.pyobj_struct* @project_big(%struct.base_pyobj* byval align 8 %p)
  store %struct.pyobj_struct* %1, %struct.pyobj_struct** %b, align 8
  %2 = load %struct.pyobj_struct** %b, align 8
  %3 = getelementptr inbounds %struct.pyobj_struct* %2, i32 0, i32 0
  %4 = load i32* %3, align 4
  %5 = icmp eq i32 %4, 2
  %6 = xor i1 %5, true
  %7 = zext i1 %6 to i32
  %8 = sext i32 %7 to i64
  %9 = call i64 @llvm.expect.i64(i64 %8, i64 0)
  %10 = icmp ne i64 %9, 0
  br i1 %10, label %11, label %13

; <label>:11                                      ; preds = %0
  call void @__assert_rtn(i8* getelementptr inbounds ([14 x i8]* @__func__.get_free_vars, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8]* @.str, i32 0, i32 0), i32 814, i8* getelementptr inbounds ([14 x i8]* @.str15, i32 0, i32 0)) #6
  unreachable
                                                  ; No predecessors!
  br label %14

; <label>:13                                      ; preds = %0
  br label %14

; <label>:14                                      ; preds = %13, %12
  %15 = load %struct.pyobj_struct** %b, align 8
  %16 = getelementptr inbounds %struct.pyobj_struct* %15, i32 0, i32 1
  %17 = bitcast %union.anon* %16 to %struct.fun_struct*
  %18 = getelementptr inbounds %struct.fun_struct* %17, i32 0, i32 1
  %19 = bitcast %struct.base_pyobj* %agg.result to i8*
  %20 = bitcast %struct.base_pyobj* %18 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %19, i8* %20, i64 24, i32 8, i1 false)
  ret void
}

; Function Attrs: nounwind ssp uwtable
define %struct.pyobj_struct* @set_free_vars(%struct.pyobj_struct* %b, %struct.base_pyobj* byval align 8 %free_vars) #0 {
  %1 = alloca %struct.pyobj_struct*, align 8
  store %struct.pyobj_struct* %b, %struct.pyobj_struct** %1, align 8
  %2 = load %struct.pyobj_struct** %1, align 8
  %3 = getelementptr inbounds %struct.pyobj_struct* %2, i32 0, i32 0
  %4 = load i32* %3, align 4
  %5 = icmp eq i32 %4, 2
  %6 = xor i1 %5, true
  %7 = zext i1 %6 to i32
  %8 = sext i32 %7 to i64
  %9 = call i64 @llvm.expect.i64(i64 %8, i64 0)
  %10 = icmp ne i64 %9, 0
  br i1 %10, label %11, label %13

; <label>:11                                      ; preds = %0
  call void @__assert_rtn(i8* getelementptr inbounds ([14 x i8]* @__func__.set_free_vars, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8]* @.str, i32 0, i32 0), i32 819, i8* getelementptr inbounds ([14 x i8]* @.str15, i32 0, i32 0)) #6
  unreachable
                                                  ; No predecessors!
  br label %14

; <label>:13                                      ; preds = %0
  br label %14

; <label>:14                                      ; preds = %13, %12
  %15 = load %struct.pyobj_struct** %1, align 8
  %16 = getelementptr inbounds %struct.pyobj_struct* %15, i32 0, i32 1
  %17 = bitcast %union.anon* %16 to %struct.fun_struct*
  %18 = getelementptr inbounds %struct.fun_struct* %17, i32 0, i32 1
  %19 = bitcast %struct.base_pyobj* %18 to i8*
  %20 = bitcast %struct.base_pyobj* %free_vars to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %19, i8* %20, i64 24, i32 8, i1 false)
  %21 = load %struct.pyobj_struct** %1, align 8
  ret %struct.pyobj_struct* %21
}

; Function Attrs: nounwind ssp uwtable
define %struct.pyobj_struct* @create_class(%struct.base_pyobj* byval align 8 %bases) #0 {
  %ret = alloca %struct.pyobj_struct*, align 8
  %basesp = alloca %struct.pyobj_struct*, align 8
  %i = alloca i32, align 4
  %parent = alloca %struct.base_pyobj*, align 8
  %1 = call i8* @malloc(i64 72)
  %2 = bitcast i8* %1 to %struct.pyobj_struct*
  store %struct.pyobj_struct* %2, %struct.pyobj_struct** %ret, align 8
  %3 = load %struct.pyobj_struct** %ret, align 8
  %4 = getelementptr inbounds %struct.pyobj_struct* %3, i32 0, i32 0
  store i32 3, i32* %4, align 4
  %5 = call %struct.hashtable* @create_hashtable(i32 2, i32 (i8*)* @attrname_hash, i32 (i8*, i8*)* @attrname_equal)
  %6 = load %struct.pyobj_struct** %ret, align 8
  %7 = getelementptr inbounds %struct.pyobj_struct* %6, i32 0, i32 1
  %8 = bitcast %union.anon* %7 to %struct.class_struct*
  %9 = getelementptr inbounds %struct.class_struct* %8, i32 0, i32 0
  store %struct.hashtable* %5, %struct.hashtable** %9, align 8
  %10 = call %struct.pyobj_struct* @project_big(%struct.base_pyobj* byval align 8 %bases)
  store %struct.pyobj_struct* %10, %struct.pyobj_struct** %basesp, align 8
  %11 = load %struct.pyobj_struct** %basesp, align 8
  %12 = getelementptr inbounds %struct.pyobj_struct* %11, i32 0, i32 0
  %13 = load i32* %12, align 4
  switch i32 %13, label %84 [
    i32 0, label %14
  ]

; <label>:14                                      ; preds = %0
  %15 = load %struct.pyobj_struct** %basesp, align 8
  %16 = getelementptr inbounds %struct.pyobj_struct* %15, i32 0, i32 1
  %17 = bitcast %union.anon* %16 to %struct.list_struct*
  %18 = getelementptr inbounds %struct.list_struct* %17, i32 0, i32 1
  %19 = load i32* %18, align 4
  %20 = load %struct.pyobj_struct** %ret, align 8
  %21 = getelementptr inbounds %struct.pyobj_struct* %20, i32 0, i32 1
  %22 = bitcast %union.anon* %21 to %struct.class_struct*
  %23 = getelementptr inbounds %struct.class_struct* %22, i32 0, i32 1
  store i32 %19, i32* %23, align 4
  %24 = load %struct.pyobj_struct** %ret, align 8
  %25 = getelementptr inbounds %struct.pyobj_struct* %24, i32 0, i32 1
  %26 = bitcast %union.anon* %25 to %struct.class_struct*
  %27 = getelementptr inbounds %struct.class_struct* %26, i32 0, i32 1
  %28 = load i32* %27, align 4
  %29 = sext i32 %28 to i64
  %30 = mul i64 24, %29
  %31 = call i8* @malloc(i64 %30)
  %32 = bitcast i8* %31 to %struct.class_struct*
  %33 = load %struct.pyobj_struct** %ret, align 8
  %34 = getelementptr inbounds %struct.pyobj_struct* %33, i32 0, i32 1
  %35 = bitcast %union.anon* %34 to %struct.class_struct*
  %36 = getelementptr inbounds %struct.class_struct* %35, i32 0, i32 2
  store %struct.class_struct* %32, %struct.class_struct** %36, align 8
  store i32 0, i32* %i, align 4
  br label %37

; <label>:37                                      ; preds = %80, %14
  %38 = load i32* %i, align 4
  %39 = load %struct.pyobj_struct** %ret, align 8
  %40 = getelementptr inbounds %struct.pyobj_struct* %39, i32 0, i32 1
  %41 = bitcast %union.anon* %40 to %struct.class_struct*
  %42 = getelementptr inbounds %struct.class_struct* %41, i32 0, i32 1
  %43 = load i32* %42, align 4
  %44 = icmp ne i32 %38, %43
  br i1 %44, label %45, label %83

; <label>:45                                      ; preds = %37
  %46 = load i32* %i, align 4
  %47 = sext i32 %46 to i64
  %48 = load %struct.pyobj_struct** %basesp, align 8
  %49 = getelementptr inbounds %struct.pyobj_struct* %48, i32 0, i32 1
  %50 = bitcast %union.anon* %49 to %struct.list_struct*
  %51 = getelementptr inbounds %struct.list_struct* %50, i32 0, i32 0
  %52 = load %struct.base_pyobj** %51, align 8
  %53 = getelementptr inbounds %struct.base_pyobj* %52, i64 %47
  store %struct.base_pyobj* %53, %struct.base_pyobj** %parent, align 8
  %54 = load %struct.base_pyobj** %parent, align 8
  %55 = call i32 @tag(%struct.base_pyobj* byval align 8 %54)
  %56 = icmp eq i32 %55, 3
  br i1 %56, label %57, label %78

; <label>:57                                      ; preds = %45
  %58 = load %struct.base_pyobj** %parent, align 8
  %59 = call %struct.pyobj_struct* @project_big(%struct.base_pyobj* byval align 8 %58)
  %60 = getelementptr inbounds %struct.pyobj_struct* %59, i32 0, i32 0
  %61 = load i32* %60, align 4
  %62 = icmp eq i32 %61, 3
  br i1 %62, label %63, label %78

; <label>:63                                      ; preds = %57
  %64 = load i32* %i, align 4
  %65 = sext i32 %64 to i64
  %66 = load %struct.pyobj_struct** %ret, align 8
  %67 = getelementptr inbounds %struct.pyobj_struct* %66, i32 0, i32 1
  %68 = bitcast %union.anon* %67 to %struct.class_struct*
  %69 = getelementptr inbounds %struct.class_struct* %68, i32 0, i32 2
  %70 = load %struct.class_struct** %69, align 8
  %71 = getelementptr inbounds %struct.class_struct* %70, i64 %65
  %72 = load %struct.base_pyobj** %parent, align 8
  %73 = call %struct.pyobj_struct* @project_big(%struct.base_pyobj* byval align 8 %72)
  %74 = getelementptr inbounds %struct.pyobj_struct* %73, i32 0, i32 1
  %75 = bitcast %union.anon* %74 to %struct.class_struct*
  %76 = bitcast %struct.class_struct* %71 to i8*
  %77 = bitcast %struct.class_struct* %75 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %76, i8* %77, i64 24, i32 8, i1 false)
  br label %79

; <label>:78                                      ; preds = %57, %45
  call void @exit(i32 -1) #6
  unreachable

; <label>:79                                      ; preds = %63
  br label %80

; <label>:80                                      ; preds = %79
  %81 = load i32* %i, align 4
  %82 = add nsw i32 %81, 1
  store i32 %82, i32* %i, align 4
  br label %37

; <label>:83                                      ; preds = %37
  br label %85

; <label>:84                                      ; preds = %0
  call void @exit(i32 -1) #6
  unreachable

; <label>:85                                      ; preds = %83
  %86 = load %struct.pyobj_struct** %ret, align 8
  ret %struct.pyobj_struct* %86
}

; Function Attrs: nounwind ssp uwtable
define internal i32 @attrname_hash(i8* %ptr) #0 {
  %1 = alloca i8*, align 8
  %str = alloca i8*, align 8
  %hash = alloca i64, align 8
  %c = alloca i32, align 4
  store i8* %ptr, i8** %1, align 8
  %2 = load i8** %1, align 8
  store i8* %2, i8** %str, align 8
  store i64 5381, i64* %hash, align 8
  br label %3

; <label>:3                                       ; preds = %9, %0
  %4 = load i8** %str, align 8
  %5 = getelementptr inbounds i8* %4, i32 1
  store i8* %5, i8** %str, align 8
  %6 = load i8* %4, align 1
  %7 = zext i8 %6 to i32
  store i32 %7, i32* %c, align 4
  %8 = icmp ne i32 %7, 0
  br i1 %8, label %9, label %17

; <label>:9                                       ; preds = %3
  %10 = load i64* %hash, align 8
  %11 = shl i64 %10, 5
  %12 = load i64* %hash, align 8
  %13 = add i64 %11, %12
  %14 = load i32* %c, align 4
  %15 = sext i32 %14 to i64
  %16 = xor i64 %13, %15
  store i64 %16, i64* %hash, align 8
  br label %3

; <label>:17                                      ; preds = %3
  %18 = load i64* %hash, align 8
  %19 = trunc i64 %18 to i32
  ret i32 %19
}

; Function Attrs: nounwind ssp uwtable
define internal i32 @attrname_equal(i8* %a, i8* %b) #0 {
  %1 = alloca i8*, align 8
  %2 = alloca i8*, align 8
  store i8* %a, i8** %1, align 8
  store i8* %b, i8** %2, align 8
  %3 = load i8** %1, align 8
  %4 = load i8** %2, align 8
  %5 = call i32 @strcmp(i8* %3, i8* %4)
  %6 = icmp ne i32 %5, 0
  %7 = xor i1 %6, true
  %8 = zext i1 %7 to i32
  ret i32 %8
}

; Function Attrs: nounwind ssp uwtable
define %struct.pyobj_struct* @create_object(%struct.base_pyobj* byval align 8 %cl) #0 {
  %ret = alloca %struct.pyobj_struct*, align 8
  %clp = alloca %struct.pyobj_struct*, align 8
  %1 = call i8* @malloc(i64 72)
  %2 = bitcast i8* %1 to %struct.pyobj_struct*
  store %struct.pyobj_struct* %2, %struct.pyobj_struct** %ret, align 8
  %3 = load %struct.pyobj_struct** %ret, align 8
  %4 = getelementptr inbounds %struct.pyobj_struct* %3, i32 0, i32 0
  store i32 4, i32* %4, align 4
  %5 = call %struct.pyobj_struct* @project_big(%struct.base_pyobj* byval align 8 %cl)
  store %struct.pyobj_struct* %5, %struct.pyobj_struct** %clp, align 8
  %6 = load %struct.pyobj_struct** %clp, align 8
  %7 = getelementptr inbounds %struct.pyobj_struct* %6, i32 0, i32 0
  %8 = load i32* %7, align 4
  %9 = icmp eq i32 %8, 3
  br i1 %9, label %10, label %20

; <label>:10                                      ; preds = %0
  %11 = load %struct.pyobj_struct** %ret, align 8
  %12 = getelementptr inbounds %struct.pyobj_struct* %11, i32 0, i32 1
  %13 = bitcast %union.anon* %12 to %struct.object_struct*
  %14 = getelementptr inbounds %struct.object_struct* %13, i32 0, i32 1
  %15 = load %struct.pyobj_struct** %clp, align 8
  %16 = getelementptr inbounds %struct.pyobj_struct* %15, i32 0, i32 1
  %17 = bitcast %union.anon* %16 to %struct.class_struct*
  %18 = bitcast %struct.class_struct* %14 to i8*
  %19 = bitcast %struct.class_struct* %17 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %18, i8* %19, i64 24, i32 8, i1 false)
  br label %22

; <label>:20                                      ; preds = %0
  %21 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([34 x i8]* @.str16, i32 0, i32 0))
  call void @exit(i32 -1) #6
  unreachable

; <label>:22                                      ; preds = %10
  %23 = call %struct.hashtable* @create_hashtable(i32 2, i32 (i8*)* @attrname_hash, i32 (i8*, i8*)* @attrname_equal)
  %24 = load %struct.pyobj_struct** %ret, align 8
  %25 = getelementptr inbounds %struct.pyobj_struct* %24, i32 0, i32 1
  %26 = bitcast %union.anon* %25 to %struct.object_struct*
  %27 = getelementptr inbounds %struct.object_struct* %26, i32 0, i32 0
  store %struct.hashtable* %23, %struct.hashtable** %27, align 8
  %28 = load %struct.pyobj_struct** %ret, align 8
  ret %struct.pyobj_struct* %28
}

; Function Attrs: nounwind ssp uwtable
define i32 @has_attr(%struct.base_pyobj* byval align 8 %o, i8* %attr) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i8*, align 8
  %b = alloca %struct.pyobj_struct*, align 8
  %attribute = alloca %struct.base_pyobj*, align 8
  %attribute1 = alloca %struct.base_pyobj*, align 8
  store i8* %attr, i8** %2, align 8
  %3 = call i32 @tag(%struct.base_pyobj* byval align 8 %o)
  %4 = icmp eq i32 %3, 3
  br i1 %4, label %5, label %41

; <label>:5                                       ; preds = %0
  %6 = call %struct.pyobj_struct* @project_big(%struct.base_pyobj* byval align 8 %o)
  store %struct.pyobj_struct* %6, %struct.pyobj_struct** %b, align 8
  %7 = load %struct.pyobj_struct** %b, align 8
  %8 = getelementptr inbounds %struct.pyobj_struct* %7, i32 0, i32 0
  %9 = load i32* %8, align 4
  switch i32 %9, label %40 [
    i32 3, label %10
    i32 4, label %19
  ]

; <label>:10                                      ; preds = %5
  %11 = load %struct.pyobj_struct** %b, align 8
  %12 = getelementptr inbounds %struct.pyobj_struct* %11, i32 0, i32 1
  %13 = bitcast %union.anon* %12 to %struct.class_struct*
  %14 = load i8** %2, align 8
  %15 = call %struct.base_pyobj* @attrsearch_rec(%struct.class_struct* byval align 8 %13, i8* %14)
  store %struct.base_pyobj* %15, %struct.base_pyobj** %attribute, align 8
  %16 = load %struct.base_pyobj** %attribute, align 8
  %17 = icmp ne %struct.base_pyobj* %16, null
  %18 = zext i1 %17 to i32
  store i32 %18, i32* %1
  br label %42

; <label>:19                                      ; preds = %5
  %20 = load %struct.pyobj_struct** %b, align 8
  %21 = getelementptr inbounds %struct.pyobj_struct* %20, i32 0, i32 1
  %22 = bitcast %union.anon* %21 to %struct.object_struct*
  %23 = getelementptr inbounds %struct.object_struct* %22, i32 0, i32 0
  %24 = load %struct.hashtable** %23, align 8
  %25 = load i8** %2, align 8
  %26 = call i8* @hashtable_search(%struct.hashtable* %24, i8* %25)
  %27 = bitcast i8* %26 to %struct.base_pyobj*
  store %struct.base_pyobj* %27, %struct.base_pyobj** %attribute1, align 8
  %28 = load %struct.base_pyobj** %attribute1, align 8
  %29 = icmp eq %struct.base_pyobj* %28, null
  br i1 %29, label %30, label %39

; <label>:30                                      ; preds = %19
  %31 = load %struct.pyobj_struct** %b, align 8
  %32 = getelementptr inbounds %struct.pyobj_struct* %31, i32 0, i32 1
  %33 = bitcast %union.anon* %32 to %struct.class_struct*
  %34 = load i8** %2, align 8
  %35 = call %struct.base_pyobj* @attrsearch_rec(%struct.class_struct* byval align 8 %33, i8* %34)
  store %struct.base_pyobj* %35, %struct.base_pyobj** %attribute1, align 8
  %36 = load %struct.base_pyobj** %attribute1, align 8
  %37 = icmp ne %struct.base_pyobj* %36, null
  %38 = zext i1 %37 to i32
  store i32 %38, i32* %1
  br label %42

; <label>:39                                      ; preds = %19
  store i32 1, i32* %1
  br label %42

; <label>:40                                      ; preds = %5
  store i32 0, i32* %1
  br label %42

; <label>:41                                      ; preds = %0
  store i32 0, i32* %1
  br label %42

; <label>:42                                      ; preds = %41, %40, %39, %30, %10
  %43 = load i32* %1
  ret i32 %43
}

; Function Attrs: nounwind ssp uwtable
define internal %struct.base_pyobj* @attrsearch_rec(%struct.class_struct* byval align 8 %cl, i8* %attr) #0 {
  %1 = alloca %struct.base_pyobj*, align 8
  %2 = alloca i8*, align 8
  %ptr = alloca %struct.base_pyobj*, align 8
  %i = alloca i32, align 4
  store i8* %attr, i8** %2, align 8
  %3 = getelementptr inbounds %struct.class_struct* %cl, i32 0, i32 0
  %4 = load %struct.hashtable** %3, align 8
  %5 = load i8** %2, align 8
  %6 = call i8* @hashtable_search(%struct.hashtable* %4, i8* %5)
  %7 = bitcast i8* %6 to %struct.base_pyobj*
  store %struct.base_pyobj* %7, %struct.base_pyobj** %ptr, align 8
  %8 = load %struct.base_pyobj** %ptr, align 8
  %9 = icmp eq %struct.base_pyobj* %8, null
  br i1 %9, label %10, label %33

; <label>:10                                      ; preds = %0
  store i32 0, i32* %i, align 4
  br label %11

; <label>:11                                      ; preds = %29, %10
  %12 = load i32* %i, align 4
  %13 = getelementptr inbounds %struct.class_struct* %cl, i32 0, i32 1
  %14 = load i32* %13, align 4
  %15 = icmp ne i32 %12, %14
  br i1 %15, label %16, label %32

; <label>:16                                      ; preds = %11
  %17 = load i32* %i, align 4
  %18 = sext i32 %17 to i64
  %19 = getelementptr inbounds %struct.class_struct* %cl, i32 0, i32 2
  %20 = load %struct.class_struct** %19, align 8
  %21 = getelementptr inbounds %struct.class_struct* %20, i64 %18
  %22 = load i8** %2, align 8
  %23 = call %struct.base_pyobj* @attrsearch_rec(%struct.class_struct* byval align 8 %21, i8* %22)
  store %struct.base_pyobj* %23, %struct.base_pyobj** %ptr, align 8
  %24 = load %struct.base_pyobj** %ptr, align 8
  %25 = icmp ne %struct.base_pyobj* %24, null
  br i1 %25, label %26, label %28

; <label>:26                                      ; preds = %16
  %27 = load %struct.base_pyobj** %ptr, align 8
  store %struct.base_pyobj* %27, %struct.base_pyobj** %1
  br label %35

; <label>:28                                      ; preds = %16
  br label %29

; <label>:29                                      ; preds = %28
  %30 = load i32* %i, align 4
  %31 = add nsw i32 %30, 1
  store i32 %31, i32* %i, align 4
  br label %11

; <label>:32                                      ; preds = %11
  store %struct.base_pyobj* null, %struct.base_pyobj** %1
  br label %35

; <label>:33                                      ; preds = %0
  %34 = load %struct.base_pyobj** %ptr, align 8
  store %struct.base_pyobj* %34, %struct.base_pyobj** %1
  br label %35

; <label>:35                                      ; preds = %33, %32, %26
  %36 = load %struct.base_pyobj** %1
  ret %struct.base_pyobj* %36
}

declare i8* @hashtable_search(%struct.hashtable*, i8*) #4

; Function Attrs: nounwind ssp uwtable
define i32 @inherits(%struct.base_pyobj* byval align 8 %c1, %struct.base_pyobj* byval align 8 %c2) #0 {
  %1 = alloca %struct.class_struct, align 8
  %2 = alloca %struct.class_struct, align 8
  call void @project_class(%struct.class_struct* sret %1, %struct.base_pyobj* byval align 8 %c1)
  call void @project_class(%struct.class_struct* sret %2, %struct.base_pyobj* byval align 8 %c2)
  %3 = call i32 @inherits_rec(%struct.class_struct* byval align 8 %1, %struct.class_struct* byval align 8 %2)
  ret i32 %3
}

; Function Attrs: nounwind ssp uwtable
define internal i32 @inherits_rec(%struct.class_struct* byval align 8 %c1, %struct.class_struct* byval align 8 %c2) #0 {
  %ret = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 0, i32* %ret, align 4
  %1 = getelementptr inbounds %struct.class_struct* %c1, i32 0, i32 0
  %2 = load %struct.hashtable** %1, align 8
  %3 = getelementptr inbounds %struct.class_struct* %c2, i32 0, i32 0
  %4 = load %struct.hashtable** %3, align 8
  %5 = icmp eq %struct.hashtable* %2, %4
  br i1 %5, label %6, label %7

; <label>:6                                       ; preds = %0
  store i32 1, i32* %ret, align 4
  br label %28

; <label>:7                                       ; preds = %0
  store i32 0, i32* %i, align 4
  br label %8

; <label>:8                                       ; preds = %24, %7
  %9 = load i32* %i, align 4
  %10 = getelementptr inbounds %struct.class_struct* %c1, i32 0, i32 1
  %11 = load i32* %10, align 4
  %12 = icmp ne i32 %9, %11
  br i1 %12, label %13, label %27

; <label>:13                                      ; preds = %8
  %14 = load i32* %i, align 4
  %15 = sext i32 %14 to i64
  %16 = getelementptr inbounds %struct.class_struct* %c1, i32 0, i32 2
  %17 = load %struct.class_struct** %16, align 8
  %18 = getelementptr inbounds %struct.class_struct* %17, i64 %15
  %19 = call i32 @inherits_rec(%struct.class_struct* byval align 8 %18, %struct.class_struct* byval align 8 %c2)
  store i32 %19, i32* %ret, align 4
  %20 = load i32* %ret, align 4
  %21 = icmp ne i32 %20, 0
  br i1 %21, label %22, label %23

; <label>:22                                      ; preds = %13
  br label %27

; <label>:23                                      ; preds = %13
  br label %24

; <label>:24                                      ; preds = %23
  %25 = load i32* %i, align 4
  %26 = add nsw i32 %25, 1
  store i32 %26, i32* %i, align 4
  br label %8

; <label>:27                                      ; preds = %22, %8
  br label %28

; <label>:28                                      ; preds = %27, %6
  %29 = load i32* %ret, align 4
  ret i32 %29
}

; Function Attrs: nounwind ssp uwtable
define %struct.pyobj_struct* @get_class(%struct.base_pyobj* byval align 8 %o) #0 {
  %ret = alloca %struct.pyobj_struct*, align 8
  %b = alloca %struct.pyobj_struct*, align 8
  %1 = call i8* @malloc(i64 72)
  %2 = bitcast i8* %1 to %struct.pyobj_struct*
  store %struct.pyobj_struct* %2, %struct.pyobj_struct** %ret, align 8
  %3 = load %struct.pyobj_struct** %ret, align 8
  %4 = getelementptr inbounds %struct.pyobj_struct* %3, i32 0, i32 0
  store i32 3, i32* %4, align 4
  %5 = call %struct.pyobj_struct* @project_big(%struct.base_pyobj* byval align 8 %o)
  store %struct.pyobj_struct* %5, %struct.pyobj_struct** %b, align 8
  %6 = load %struct.pyobj_struct** %b, align 8
  %7 = getelementptr inbounds %struct.pyobj_struct* %6, i32 0, i32 0
  %8 = load i32* %7, align 4
  switch i32 %8, label %29 [
    i32 4, label %9
    i32 5, label %19
  ]

; <label>:9                                       ; preds = %0
  %10 = load %struct.pyobj_struct** %ret, align 8
  %11 = getelementptr inbounds %struct.pyobj_struct* %10, i32 0, i32 1
  %12 = bitcast %union.anon* %11 to %struct.class_struct*
  %13 = load %struct.pyobj_struct** %b, align 8
  %14 = getelementptr inbounds %struct.pyobj_struct* %13, i32 0, i32 1
  %15 = bitcast %union.anon* %14 to %struct.object_struct*
  %16 = getelementptr inbounds %struct.object_struct* %15, i32 0, i32 1
  %17 = bitcast %struct.class_struct* %12 to i8*
  %18 = bitcast %struct.class_struct* %16 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %17, i8* %18, i64 24, i32 8, i1 false)
  br label %31

; <label>:19                                      ; preds = %0
  %20 = load %struct.pyobj_struct** %ret, align 8
  %21 = getelementptr inbounds %struct.pyobj_struct* %20, i32 0, i32 1
  %22 = bitcast %union.anon* %21 to %struct.class_struct*
  %23 = load %struct.pyobj_struct** %b, align 8
  %24 = getelementptr inbounds %struct.pyobj_struct* %23, i32 0, i32 1
  %25 = bitcast %union.anon* %24 to %struct.unbound_method_struct*
  %26 = getelementptr inbounds %struct.unbound_method_struct* %25, i32 0, i32 1
  %27 = bitcast %struct.class_struct* %22 to i8*
  %28 = bitcast %struct.class_struct* %26 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %27, i8* %28, i64 24, i32 8, i1 false)
  br label %31

; <label>:29                                      ; preds = %0
  %30 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([45 x i8]* @.str17, i32 0, i32 0))
  call void @exit(i32 -1) #6
  unreachable

; <label>:31                                      ; preds = %19, %9
  %32 = load %struct.pyobj_struct** %ret, align 8
  ret %struct.pyobj_struct* %32
}

; Function Attrs: nounwind ssp uwtable
define %struct.pyobj_struct* @get_receiver(%struct.base_pyobj* byval align 8 %o) #0 {
  %ret = alloca %struct.pyobj_struct*, align 8
  %b = alloca %struct.pyobj_struct*, align 8
  %1 = call i8* @malloc(i64 72)
  %2 = bitcast i8* %1 to %struct.pyobj_struct*
  store %struct.pyobj_struct* %2, %struct.pyobj_struct** %ret, align 8
  %3 = load %struct.pyobj_struct** %ret, align 8
  %4 = getelementptr inbounds %struct.pyobj_struct* %3, i32 0, i32 0
  store i32 4, i32* %4, align 4
  %5 = call %struct.pyobj_struct* @project_big(%struct.base_pyobj* byval align 8 %o)
  store %struct.pyobj_struct* %5, %struct.pyobj_struct** %b, align 8
  %6 = load %struct.pyobj_struct** %b, align 8
  %7 = getelementptr inbounds %struct.pyobj_struct* %6, i32 0, i32 0
  %8 = load i32* %7, align 4
  switch i32 %8, label %19 [
    i32 6, label %9
  ]

; <label>:9                                       ; preds = %0
  %10 = load %struct.pyobj_struct** %ret, align 8
  %11 = getelementptr inbounds %struct.pyobj_struct* %10, i32 0, i32 1
  %12 = bitcast %union.anon* %11 to %struct.object_struct*
  %13 = load %struct.pyobj_struct** %b, align 8
  %14 = getelementptr inbounds %struct.pyobj_struct* %13, i32 0, i32 1
  %15 = bitcast %union.anon* %14 to %struct.bound_method_struct*
  %16 = getelementptr inbounds %struct.bound_method_struct* %15, i32 0, i32 1
  %17 = bitcast %struct.object_struct* %12 to i8*
  %18 = bitcast %struct.object_struct* %16 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %17, i8* %18, i64 32, i32 8, i1 false)
  br label %21

; <label>:19                                      ; preds = %0
  %20 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([36 x i8]* @.str18, i32 0, i32 0))
  call void @exit(i32 -1) #6
  unreachable

; <label>:21                                      ; preds = %9
  %22 = load %struct.pyobj_struct** %ret, align 8
  ret %struct.pyobj_struct* %22
}

; Function Attrs: nounwind ssp uwtable
define %struct.pyobj_struct* @get_function(%struct.base_pyobj* byval align 8 %o) #0 {
  %ret = alloca %struct.pyobj_struct*, align 8
  %b = alloca %struct.pyobj_struct*, align 8
  %1 = call i8* @malloc(i64 72)
  %2 = bitcast i8* %1 to %struct.pyobj_struct*
  store %struct.pyobj_struct* %2, %struct.pyobj_struct** %ret, align 8
  %3 = load %struct.pyobj_struct** %ret, align 8
  %4 = getelementptr inbounds %struct.pyobj_struct* %3, i32 0, i32 0
  store i32 2, i32* %4, align 4
  %5 = call %struct.pyobj_struct* @project_big(%struct.base_pyobj* byval align 8 %o)
  store %struct.pyobj_struct* %5, %struct.pyobj_struct** %b, align 8
  %6 = load %struct.pyobj_struct** %b, align 8
  %7 = getelementptr inbounds %struct.pyobj_struct* %6, i32 0, i32 0
  %8 = load i32* %7, align 4
  switch i32 %8, label %29 [
    i32 6, label %9
    i32 5, label %19
  ]

; <label>:9                                       ; preds = %0
  %10 = load %struct.pyobj_struct** %ret, align 8
  %11 = getelementptr inbounds %struct.pyobj_struct* %10, i32 0, i32 1
  %12 = bitcast %union.anon* %11 to %struct.fun_struct*
  %13 = load %struct.pyobj_struct** %b, align 8
  %14 = getelementptr inbounds %struct.pyobj_struct* %13, i32 0, i32 1
  %15 = bitcast %union.anon* %14 to %struct.bound_method_struct*
  %16 = getelementptr inbounds %struct.bound_method_struct* %15, i32 0, i32 0
  %17 = bitcast %struct.fun_struct* %12 to i8*
  %18 = bitcast %struct.fun_struct* %16 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %17, i8* %18, i64 32, i32 8, i1 false)
  br label %31

; <label>:19                                      ; preds = %0
  %20 = load %struct.pyobj_struct** %ret, align 8
  %21 = getelementptr inbounds %struct.pyobj_struct* %20, i32 0, i32 1
  %22 = bitcast %union.anon* %21 to %struct.fun_struct*
  %23 = load %struct.pyobj_struct** %b, align 8
  %24 = getelementptr inbounds %struct.pyobj_struct* %23, i32 0, i32 1
  %25 = bitcast %union.anon* %24 to %struct.unbound_method_struct*
  %26 = getelementptr inbounds %struct.unbound_method_struct* %25, i32 0, i32 0
  %27 = bitcast %struct.fun_struct* %22 to i8*
  %28 = bitcast %struct.fun_struct* %26 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %27, i8* %28, i64 32, i32 8, i1 false)
  br label %31

; <label>:29                                      ; preds = %0
  %30 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([32 x i8]* @.str19, i32 0, i32 0))
  call void @exit(i32 -1) #6
  unreachable

; <label>:31                                      ; preds = %19, %9
  %32 = load %struct.pyobj_struct** %ret, align 8
  ret %struct.pyobj_struct* %32
}

; Function Attrs: nounwind ssp uwtable
define void @get_attr(%struct.base_pyobj* noalias sret %agg.result, %struct.base_pyobj* byval align 8 %c, i8* %attr) #0 {
  %1 = alloca i8*, align 8
  %b = alloca %struct.pyobj_struct*, align 8
  %attribute = alloca %struct.base_pyobj*, align 8
  %2 = alloca %struct.fun_struct, align 8
  %attribute1 = alloca %struct.base_pyobj*, align 8
  %3 = alloca %struct.fun_struct, align 8
  store i8* %attr, i8** %1, align 8
  %4 = call %struct.pyobj_struct* @project_big(%struct.base_pyobj* byval align 8 %c)
  store %struct.pyobj_struct* %4, %struct.pyobj_struct** %b, align 8
  %5 = load %struct.pyobj_struct** %b, align 8
  %6 = getelementptr inbounds %struct.pyobj_struct* %5, i32 0, i32 0
  %7 = load i32* %6, align 4
  switch i32 %7, label %62 [
    i32 3, label %8
    i32 4, label %27
  ]

; <label>:8                                       ; preds = %0
  %9 = load %struct.pyobj_struct** %b, align 8
  %10 = getelementptr inbounds %struct.pyobj_struct* %9, i32 0, i32 1
  %11 = bitcast %union.anon* %10 to %struct.class_struct*
  %12 = load i8** %1, align 8
  %13 = call %struct.base_pyobj* @attrsearch(%struct.class_struct* byval align 8 %11, i8* %12)
  store %struct.base_pyobj* %13, %struct.base_pyobj** %attribute, align 8
  %14 = load %struct.base_pyobj** %attribute, align 8
  %15 = call i32 @is_function(%struct.base_pyobj* byval align 8 %14)
  %16 = icmp ne i32 %15, 0
  br i1 %16, label %17, label %23

; <label>:17                                      ; preds = %8
  %18 = load %struct.pyobj_struct** %b, align 8
  %19 = getelementptr inbounds %struct.pyobj_struct* %18, i32 0, i32 1
  %20 = bitcast %union.anon* %19 to %struct.class_struct*
  %21 = load %struct.base_pyobj** %attribute, align 8
  call void @project_function(%struct.fun_struct* sret %2, %struct.base_pyobj* byval align 8 %21)
  %22 = call %struct.pyobj_struct* @create_unbound_method(%struct.class_struct* byval align 8 %20, %struct.fun_struct* byval align 8 %2)
  call void @inject_big(%struct.base_pyobj* sret %agg.result, %struct.pyobj_struct* %22)
  br label %64

; <label>:23                                      ; preds = %8
  %24 = load %struct.base_pyobj** %attribute, align 8
  %25 = bitcast %struct.base_pyobj* %agg.result to i8*
  %26 = bitcast %struct.base_pyobj* %24 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %25, i8* %26, i64 24, i32 8, i1 false)
  br label %64

; <label>:27                                      ; preds = %0
  %28 = load %struct.pyobj_struct** %b, align 8
  %29 = getelementptr inbounds %struct.pyobj_struct* %28, i32 0, i32 1
  %30 = bitcast %union.anon* %29 to %struct.object_struct*
  %31 = getelementptr inbounds %struct.object_struct* %30, i32 0, i32 0
  %32 = load %struct.hashtable** %31, align 8
  %33 = load i8** %1, align 8
  %34 = call i8* @hashtable_search(%struct.hashtable* %32, i8* %33)
  %35 = bitcast i8* %34 to %struct.base_pyobj*
  store %struct.base_pyobj* %35, %struct.base_pyobj** %attribute1, align 8
  %36 = load %struct.base_pyobj** %attribute1, align 8
  %37 = icmp eq %struct.base_pyobj* %36, null
  br i1 %37, label %38, label %58

; <label>:38                                      ; preds = %27
  %39 = load %struct.pyobj_struct** %b, align 8
  %40 = getelementptr inbounds %struct.pyobj_struct* %39, i32 0, i32 1
  %41 = bitcast %union.anon* %40 to %struct.object_struct*
  %42 = getelementptr inbounds %struct.object_struct* %41, i32 0, i32 1
  %43 = load i8** %1, align 8
  %44 = call %struct.base_pyobj* @attrsearch(%struct.class_struct* byval align 8 %42, i8* %43)
  store %struct.base_pyobj* %44, %struct.base_pyobj** %attribute1, align 8
  %45 = load %struct.base_pyobj** %attribute1, align 8
  %46 = call i32 @is_function(%struct.base_pyobj* byval align 8 %45)
  %47 = icmp ne i32 %46, 0
  br i1 %47, label %48, label %54

; <label>:48                                      ; preds = %38
  %49 = load %struct.pyobj_struct** %b, align 8
  %50 = getelementptr inbounds %struct.pyobj_struct* %49, i32 0, i32 1
  %51 = bitcast %union.anon* %50 to %struct.object_struct*
  %52 = load %struct.base_pyobj** %attribute1, align 8
  call void @project_function(%struct.fun_struct* sret %3, %struct.base_pyobj* byval align 8 %52)
  %53 = call %struct.pyobj_struct* @create_bound_method(%struct.object_struct* byval align 8 %51, %struct.fun_struct* byval align 8 %3)
  call void @inject_big(%struct.base_pyobj* sret %agg.result, %struct.pyobj_struct* %53)
  br label %64

; <label>:54                                      ; preds = %38
  %55 = load %struct.base_pyobj** %attribute1, align 8
  %56 = bitcast %struct.base_pyobj* %agg.result to i8*
  %57 = bitcast %struct.base_pyobj* %55 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %56, i8* %57, i64 24, i32 8, i1 false)
  br label %64

; <label>:58                                      ; preds = %27
  %59 = load %struct.base_pyobj** %attribute1, align 8
  %60 = bitcast %struct.base_pyobj* %agg.result to i8*
  %61 = bitcast %struct.base_pyobj* %59 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %60, i8* %61, i64 24, i32 8, i1 false)
  br label %64

; <label>:62                                      ; preds = %0
  %63 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([47 x i8]* @.str20, i32 0, i32 0))
  call void @exit(i32 -1) #6
  unreachable

; <label>:64                                      ; preds = %58, %54, %48, %23, %17
  ret void
}

; Function Attrs: nounwind ssp uwtable
define internal %struct.base_pyobj* @attrsearch(%struct.class_struct* byval align 8 %cl, i8* %attr) #0 {
  %1 = alloca i8*, align 8
  %ret = alloca %struct.base_pyobj*, align 8
  store i8* %attr, i8** %1, align 8
  %2 = load i8** %1, align 8
  %3 = call %struct.base_pyobj* @attrsearch_rec(%struct.class_struct* byval align 8 %cl, i8* %2)
  store %struct.base_pyobj* %3, %struct.base_pyobj** %ret, align 8
  %4 = load %struct.base_pyobj** %ret, align 8
  %5 = icmp eq %struct.base_pyobj* %4, null
  br i1 %5, label %6, label %9

; <label>:6                                       ; preds = %0
  %7 = load i8** %1, align 8
  %8 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([24 x i8]* @.str24, i32 0, i32 0), i8* %7)
  call void @exit(i32 -1) #6
  unreachable

; <label>:9                                       ; preds = %0
  %10 = load %struct.base_pyobj** %ret, align 8
  ret %struct.base_pyobj* %10
}

; Function Attrs: nounwind ssp uwtable
define internal %struct.pyobj_struct* @create_unbound_method(%struct.class_struct* byval align 8 %cl, %struct.fun_struct* byval align 8 %f) #0 {
  %ret = alloca %struct.pyobj_struct*, align 8
  %1 = call i8* @malloc(i64 72)
  %2 = bitcast i8* %1 to %struct.pyobj_struct*
  store %struct.pyobj_struct* %2, %struct.pyobj_struct** %ret, align 8
  %3 = load %struct.pyobj_struct** %ret, align 8
  %4 = getelementptr inbounds %struct.pyobj_struct* %3, i32 0, i32 0
  store i32 5, i32* %4, align 4
  %5 = load %struct.pyobj_struct** %ret, align 8
  %6 = getelementptr inbounds %struct.pyobj_struct* %5, i32 0, i32 1
  %7 = bitcast %union.anon* %6 to %struct.unbound_method_struct*
  %8 = getelementptr inbounds %struct.unbound_method_struct* %7, i32 0, i32 0
  %9 = bitcast %struct.fun_struct* %8 to i8*
  %10 = bitcast %struct.fun_struct* %f to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %9, i8* %10, i64 32, i32 8, i1 false)
  %11 = load %struct.pyobj_struct** %ret, align 8
  %12 = getelementptr inbounds %struct.pyobj_struct* %11, i32 0, i32 1
  %13 = bitcast %union.anon* %12 to %struct.unbound_method_struct*
  %14 = getelementptr inbounds %struct.unbound_method_struct* %13, i32 0, i32 1
  %15 = bitcast %struct.class_struct* %14 to i8*
  %16 = bitcast %struct.class_struct* %cl to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %15, i8* %16, i64 24, i32 8, i1 false)
  %17 = load %struct.pyobj_struct** %ret, align 8
  ret %struct.pyobj_struct* %17
}

; Function Attrs: nounwind ssp uwtable
define internal %struct.pyobj_struct* @create_bound_method(%struct.object_struct* byval align 8 %receiver, %struct.fun_struct* byval align 8 %f) #0 {
  %ret = alloca %struct.pyobj_struct*, align 8
  %1 = call i8* @malloc(i64 72)
  %2 = bitcast i8* %1 to %struct.pyobj_struct*
  store %struct.pyobj_struct* %2, %struct.pyobj_struct** %ret, align 8
  %3 = load %struct.pyobj_struct** %ret, align 8
  %4 = getelementptr inbounds %struct.pyobj_struct* %3, i32 0, i32 0
  store i32 6, i32* %4, align 4
  %5 = load %struct.pyobj_struct** %ret, align 8
  %6 = getelementptr inbounds %struct.pyobj_struct* %5, i32 0, i32 1
  %7 = bitcast %union.anon* %6 to %struct.bound_method_struct*
  %8 = getelementptr inbounds %struct.bound_method_struct* %7, i32 0, i32 0
  %9 = bitcast %struct.fun_struct* %8 to i8*
  %10 = bitcast %struct.fun_struct* %f to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %9, i8* %10, i64 32, i32 8, i1 false)
  %11 = load %struct.pyobj_struct** %ret, align 8
  %12 = getelementptr inbounds %struct.pyobj_struct* %11, i32 0, i32 1
  %13 = bitcast %union.anon* %12 to %struct.bound_method_struct*
  %14 = getelementptr inbounds %struct.bound_method_struct* %13, i32 0, i32 1
  %15 = bitcast %struct.object_struct* %14 to i8*
  %16 = bitcast %struct.object_struct* %receiver to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %15, i8* %16, i64 32, i32 8, i1 false)
  %17 = load %struct.pyobj_struct** %ret, align 8
  ret %struct.pyobj_struct* %17
}

; Function Attrs: nounwind ssp uwtable
define void @set_attr(%struct.base_pyobj* noalias sret %agg.result, %struct.base_pyobj* byval align 8 %obj, i8* %attr, %struct.base_pyobj* byval align 8 %val) #0 {
  %1 = alloca i8*, align 8
  %k = alloca i8*, align 8
  %v = alloca %struct.base_pyobj*, align 8
  %attrs = alloca %struct.hashtable*, align 8
  %b = alloca %struct.pyobj_struct*, align 8
  store i8* %attr, i8** %1, align 8
  %2 = load i8** %1, align 8
  %3 = call i64 @strlen(i8* %2)
  %4 = add i64 %3, 1
  %5 = call i8* @malloc(i64 %4)
  store i8* %5, i8** %k, align 8
  %6 = call i8* @malloc(i64 24)
  %7 = bitcast i8* %6 to %struct.base_pyobj*
  store %struct.base_pyobj* %7, %struct.base_pyobj** %v, align 8
  %8 = load i8** %k, align 8
  %9 = load i8** %1, align 8
  %10 = load i8** %k, align 8
  %11 = call i64 @llvm.objectsize.i64.p0i8(i8* %10, i1 false)
  %12 = call i8* @__strcpy_chk(i8* %8, i8* %9, i64 %11) #1
  %13 = load %struct.base_pyobj** %v, align 8
  %14 = bitcast %struct.base_pyobj* %13 to i8*
  %15 = bitcast %struct.base_pyobj* %val to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %14, i8* %15, i64 24, i32 8, i1 false)
  %16 = call %struct.pyobj_struct* @project_big(%struct.base_pyobj* byval align 8 %obj)
  store %struct.pyobj_struct* %16, %struct.pyobj_struct** %b, align 8
  %17 = load %struct.pyobj_struct** %b, align 8
  %18 = getelementptr inbounds %struct.pyobj_struct* %17, i32 0, i32 0
  %19 = load i32* %18, align 4
  switch i32 %19, label %32 [
    i32 3, label %20
    i32 4, label %26
  ]

; <label>:20                                      ; preds = %0
  %21 = load %struct.pyobj_struct** %b, align 8
  %22 = getelementptr inbounds %struct.pyobj_struct* %21, i32 0, i32 1
  %23 = bitcast %union.anon* %22 to %struct.class_struct*
  %24 = getelementptr inbounds %struct.class_struct* %23, i32 0, i32 0
  %25 = load %struct.hashtable** %24, align 8
  store %struct.hashtable* %25, %struct.hashtable** %attrs, align 8
  br label %34

; <label>:26                                      ; preds = %0
  %27 = load %struct.pyobj_struct** %b, align 8
  %28 = getelementptr inbounds %struct.pyobj_struct* %27, i32 0, i32 1
  %29 = bitcast %union.anon* %28 to %struct.object_struct*
  %30 = getelementptr inbounds %struct.object_struct* %29, i32 0, i32 0
  %31 = load %struct.hashtable** %30, align 8
  store %struct.hashtable* %31, %struct.hashtable** %attrs, align 8
  br label %34

; <label>:32                                      ; preds = %0
  %33 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([50 x i8]* @.str21, i32 0, i32 0))
  call void @exit(i32 -1) #6
  unreachable

; <label>:34                                      ; preds = %26, %20
  %35 = load %struct.hashtable** %attrs, align 8
  %36 = load i8** %k, align 8
  %37 = load %struct.base_pyobj** %v, align 8
  %38 = bitcast %struct.base_pyobj* %37 to i8*
  %39 = call i32 @hashtable_change(%struct.hashtable* %35, i8* %36, i8* %38)
  %40 = icmp ne i32 %39, 0
  br i1 %40, label %51, label %41

; <label>:41                                      ; preds = %34
  %42 = load %struct.hashtable** %attrs, align 8
  %43 = load i8** %k, align 8
  %44 = load %struct.base_pyobj** %v, align 8
  %45 = bitcast %struct.base_pyobj* %44 to i8*
  %46 = call i32 @hashtable_insert(%struct.hashtable* %42, i8* %43, i8* %45)
  %47 = icmp ne i32 %46, 0
  br i1 %47, label %50, label %48

; <label>:48                                      ; preds = %41
  %49 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @.str22, i32 0, i32 0))
  call void @exit(i32 -1) #6
  unreachable

; <label>:50                                      ; preds = %41
  br label %51

; <label>:51                                      ; preds = %50, %34
  %52 = bitcast %struct.base_pyobj* %agg.result to i8*
  %53 = bitcast %struct.base_pyobj* %val to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %52, i8* %53, i64 24, i32 8, i1 false)
  ret void
}

declare i64 @strlen(i8*) #4

; Function Attrs: nounwind
declare i8* @__strcpy_chk(i8*, i8*, i64) #5

; Function Attrs: nounwind readnone
declare i64 @llvm.objectsize.i64.p0i8(i8*, i1) #2

declare i32 @hashtable_change(%struct.hashtable*, i8*, i8*) #4

declare i32 @hashtable_insert(%struct.hashtable*, i8*, i8*) #4

; Function Attrs: nounwind ssp uwtable
define void @error_pyobj(%struct.base_pyobj* noalias sret %agg.result, i8* %string) #0 {
  %1 = alloca i8*, align 8
  store i8* %string, i8** %1, align 8
  %2 = load i8** %1, align 8
  %3 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @.str23, i32 0, i32 0), i8* %2)
  call void @exit(i32 -1) #6
  unreachable
                                                  ; No predecessors!
  ret void
}

declare i32 @strcmp(i8*, i8*) #4

; Function Attrs: nounwind ssp uwtable
define internal void @print_int(i32 %x) #0 {
  %1 = alloca i32, align 4
  store i32 %x, i32* %1, align 4
  %2 = load i32* %1, align 4
  %3 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @.str8, i32 0, i32 0), i32 %2)
  ret void
}

; Function Attrs: nounwind ssp uwtable
define internal void @print_bool(i32 %b) #0 {
  %1 = alloca i32, align 4
  store i32 %b, i32* %1, align 4
  %2 = load i32* %1, align 4
  %3 = icmp ne i32 %2, 0
  br i1 %3, label %4, label %6

; <label>:4                                       ; preds = %0
  %5 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str37, i32 0, i32 0))
  br label %8

; <label>:6                                       ; preds = %0
  %7 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str38, i32 0, i32 0))
  br label %8

; <label>:8                                       ; preds = %6, %4
  ret void
}

; Function Attrs: nounwind ssp uwtable
define internal void @print_float(double %in) #0 {
  %1 = alloca double, align 8
  %outstr = alloca [128 x i8], align 16
  %p = alloca i8*, align 8
  store double %in, double* %1, align 8
  %2 = getelementptr inbounds [128 x i8]* %outstr, i32 0, i32 0
  %3 = load double* %1, align 8
  %4 = call i32 (i8*, i64, i32, i64, i8*, ...)* @__snprintf_chk(i8* %2, i64 128, i32 0, i64 128, i8* getelementptr inbounds ([6 x i8]* @.str33, i32 0, i32 0), double %3)
  %5 = getelementptr inbounds [128 x i8]* %outstr, i32 0, i32 0
  store i8* %5, i8** %p, align 8
  %6 = load double* %1, align 8
  %7 = fcmp oeq double %6, 0.000000e+00
  br i1 %7, label %8, label %26

; <label>:8                                       ; preds = %0
  %9 = load i8* @printed_0, align 1
  %10 = sext i8 %9 to i32
  %11 = icmp eq i32 %10, 0
  br i1 %11, label %12, label %19

; <label>:12                                      ; preds = %8
  store i8 1, i8* @printed_0, align 1
  %13 = load i8** %p, align 8
  %14 = load i8* %13, align 1
  %15 = sext i8 %14 to i32
  %16 = icmp eq i32 %15, 45
  %17 = zext i1 %16 to i32
  %18 = trunc i32 %17 to i8
  store i8 %18, i8* @printed_0_neg, align 1
  br label %25

; <label>:19                                      ; preds = %8
  %20 = load i8* @printed_0_neg, align 1
  %21 = sext i8 %20 to i32
  %22 = icmp ne i32 %21, 0
  %23 = select i1 %22, i8* getelementptr inbounds ([5 x i8]* @.str34, i32 0, i32 0), i8* getelementptr inbounds ([4 x i8]* @.str35, i32 0, i32 0)
  %24 = call i32 (i8*, ...)* @printf(i8* %23)
  br label %59

; <label>:25                                      ; preds = %12
  br label %26

; <label>:26                                      ; preds = %25, %0
  %27 = load i8** %p, align 8
  %28 = load i8* %27, align 1
  %29 = sext i8 %28 to i32
  %30 = icmp eq i32 %29, 45
  br i1 %30, label %31, label %34

; <label>:31                                      ; preds = %26
  %32 = load i8** %p, align 8
  %33 = getelementptr inbounds i8* %32, i32 1
  store i8* %33, i8** %p, align 8
  br label %34

; <label>:34                                      ; preds = %31, %26
  br label %35

; <label>:35                                      ; preds = %48, %34
  %36 = load i8** %p, align 8
  %37 = load i8* %36, align 1
  %38 = sext i8 %37 to i32
  %39 = icmp ne i32 %38, 0
  br i1 %39, label %40, label %46

; <label>:40                                      ; preds = %35
  %41 = load i8** %p, align 8
  %42 = load i8* %41, align 1
  %43 = sext i8 %42 to i32
  %44 = call i32 @isdigit(i32 %43)
  %45 = icmp ne i32 %44, 0
  br label %46

; <label>:46                                      ; preds = %40, %35
  %47 = phi i1 [ false, %35 ], [ %45, %40 ]
  br i1 %47, label %48, label %51

; <label>:48                                      ; preds = %46
  %49 = load i8** %p, align 8
  %50 = getelementptr inbounds i8* %49, i32 1
  store i8* %50, i8** %p, align 8
  br label %35

; <label>:51                                      ; preds = %46
  %52 = load i8** %p, align 8
  %53 = load i8* %52, align 1
  %54 = sext i8 %53 to i32
  %55 = icmp ne i32 %54, 0
  %56 = select i1 %55, i8* getelementptr inbounds ([3 x i8]* @.str23, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8]* @.str36, i32 0, i32 0)
  %57 = getelementptr inbounds [128 x i8]* %outstr, i32 0, i32 0
  %58 = call i32 (i8*, ...)* @printf(i8* %56, i8* %57)
  br label %59

; <label>:59                                      ; preds = %51, %19
  ret void
}

; Function Attrs: nounwind ssp uwtable
define internal void @print_dict(%struct.base_pyobj* byval align 8 %dict) #0 {
  %d = alloca %struct.pyobj_struct*, align 8
  %inside_reset = alloca i8, align 1
  %i = alloca i32, align 4
  %max = alloca i32, align 4
  %itr = alloca %struct.hashtable_itr*, align 8
  %k = alloca %struct.base_pyobj, align 8
  %v = alloca %struct.base_pyobj, align 8
  %a = alloca %struct.list_struct, align 8
  %1 = alloca %struct.list_struct, align 8
  store i8 0, i8* %inside_reset, align 1
  %2 = load i8* @inside, align 1
  %3 = icmp ne i8 %2, 0
  br i1 %3, label %5, label %4

; <label>:4                                       ; preds = %0
  store i8 1, i8* @inside, align 1
  store i8 1, i8* %inside_reset, align 1
  store i32 0, i32* getelementptr inbounds (%struct.list_struct* @printing_list, i32 0, i32 1), align 4
  store %struct.base_pyobj* null, %struct.base_pyobj** getelementptr inbounds (%struct.list_struct* @printing_list, i32 0, i32 0), align 8
  br label %5

; <label>:5                                       ; preds = %4, %0
  %6 = call %struct.pyobj_struct* @project_big(%struct.base_pyobj* byval align 8 %dict)
  store %struct.pyobj_struct* %6, %struct.pyobj_struct** %d, align 8
  %7 = load %struct.base_pyobj** getelementptr ({ %struct.base_pyobj*, i32 }* bitcast (%struct.list_struct* @printing_list to { %struct.base_pyobj*, i32 }*), i32 0, i32 0), align 1
  %8 = load i32* getelementptr ({ %struct.base_pyobj*, i32 }* bitcast (%struct.list_struct* @printing_list to { %struct.base_pyobj*, i32 }*), i32 0, i32 1), align 1
  %9 = call signext i8 @is_in_list(%struct.base_pyobj* %7, i32 %8, %struct.base_pyobj* byval align 8 %dict)
  %10 = icmp ne i8 %9, 0
  br i1 %10, label %11, label %13

; <label>:11                                      ; preds = %5
  %12 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str29, i32 0, i32 0))
  br label %98

; <label>:13                                      ; preds = %5
  %14 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([2 x i8]* @.str30, i32 0, i32 0))
  store i32 0, i32* %i, align 4
  %15 = load %struct.pyobj_struct** %d, align 8
  %16 = getelementptr inbounds %struct.pyobj_struct* %15, i32 0, i32 1
  %17 = bitcast %union.anon* %16 to %struct.hashtable**
  %18 = load %struct.hashtable** %17, align 8
  %19 = call i32 @hashtable_count(%struct.hashtable* %18)
  store i32 %19, i32* %max, align 4
  %20 = load %struct.pyobj_struct** %d, align 8
  %21 = getelementptr inbounds %struct.pyobj_struct* %20, i32 0, i32 1
  %22 = bitcast %union.anon* %21 to %struct.hashtable**
  %23 = load %struct.hashtable** %22, align 8
  %24 = call %struct.hashtable_itr* @hashtable_iterator(%struct.hashtable* %23)
  store %struct.hashtable_itr* %24, %struct.hashtable_itr** %itr, align 8
  %25 = load i32* %max, align 4
  %26 = icmp ne i32 %25, 0
  br i1 %26, label %27, label %93

; <label>:27                                      ; preds = %13
  br label %28

; <label>:28                                      ; preds = %88, %27
  %29 = load %struct.hashtable_itr** %itr, align 8
  %30 = call i8* @hashtable_iterator_key(%struct.hashtable_itr* %29)
  %31 = bitcast i8* %30 to %struct.base_pyobj*
  %32 = bitcast %struct.base_pyobj* %k to i8*
  %33 = bitcast %struct.base_pyobj* %31 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %32, i8* %33, i64 24, i32 8, i1 false)
  %34 = load %struct.hashtable_itr** %itr, align 8
  %35 = call i8* @hashtable_iterator_value(%struct.hashtable_itr* %34)
  %36 = bitcast i8* %35 to %struct.base_pyobj*
  %37 = bitcast %struct.base_pyobj* %v to i8*
  %38 = bitcast %struct.base_pyobj* %36 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %37, i8* %38, i64 24, i32 8, i1 false)
  call void @print_pyobj(%struct.base_pyobj* byval align 8 %k)
  %39 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @.str31, i32 0, i32 0))
  %40 = load %struct.base_pyobj** getelementptr ({ %struct.base_pyobj*, i32 }* bitcast (%struct.list_struct* @printing_list to { %struct.base_pyobj*, i32 }*), i32 0, i32 0), align 1
  %41 = load i32* getelementptr ({ %struct.base_pyobj*, i32 }* bitcast (%struct.list_struct* @printing_list to { %struct.base_pyobj*, i32 }*), i32 0, i32 1), align 1
  %42 = call signext i8 @is_in_list(%struct.base_pyobj* %40, i32 %41, %struct.base_pyobj* byval align 8 %v)
  %43 = sext i8 %42 to i32
  %44 = icmp ne i32 %43, 0
  br i1 %44, label %48, label %45

; <label>:45                                      ; preds = %28
  %46 = call i32 @equal_pyobj(%struct.base_pyobj* byval align 8 %v, %struct.base_pyobj* byval align 8 %dict)
  %47 = icmp ne i32 %46, 0
  br i1 %47, label %48, label %50

; <label>:48                                      ; preds = %45, %28
  %49 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str29, i32 0, i32 0))
  br label %78

; <label>:50                                      ; preds = %45
  %51 = getelementptr inbounds %struct.list_struct* %a, i32 0, i32 1
  store i32 1, i32* %51, align 4
  %52 = getelementptr inbounds %struct.list_struct* %a, i32 0, i32 1
  %53 = load i32* %52, align 4
  %54 = zext i32 %53 to i64
  %55 = mul i64 24, %54
  %56 = call i8* @malloc(i64 %55)
  %57 = bitcast i8* %56 to %struct.base_pyobj*
  %58 = getelementptr inbounds %struct.list_struct* %a, i32 0, i32 0
  store %struct.base_pyobj* %57, %struct.base_pyobj** %58, align 8
  %59 = getelementptr inbounds %struct.list_struct* %a, i32 0, i32 0
  %60 = load %struct.base_pyobj** %59, align 8
  %61 = getelementptr inbounds %struct.base_pyobj* %60, i64 0
  %62 = bitcast %struct.base_pyobj* %61 to i8*
  %63 = bitcast %struct.base_pyobj* %dict to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %62, i8* %63, i64 24, i32 8, i1 false)
  %64 = load %struct.base_pyobj** getelementptr ({ %struct.base_pyobj*, i32 }* bitcast (%struct.list_struct* @printing_list to { %struct.base_pyobj*, i32 }*), i32 0, i32 0), align 1
  %65 = load i32* getelementptr ({ %struct.base_pyobj*, i32 }* bitcast (%struct.list_struct* @printing_list to { %struct.base_pyobj*, i32 }*), i32 0, i32 1), align 1
  %66 = bitcast %struct.list_struct* %a to { %struct.base_pyobj*, i32 }*
  %67 = getelementptr { %struct.base_pyobj*, i32 }* %66, i32 0, i32 0
  %68 = load %struct.base_pyobj** %67, align 1
  %69 = getelementptr { %struct.base_pyobj*, i32 }* %66, i32 0, i32 1
  %70 = load i32* %69, align 1
  %71 = call { %struct.base_pyobj*, i32 } @list_add(%struct.base_pyobj* %64, i32 %65, %struct.base_pyobj* %68, i32 %70)
  %72 = bitcast %struct.list_struct* %1 to { %struct.base_pyobj*, i32 }*
  %73 = getelementptr { %struct.base_pyobj*, i32 }* %72, i32 0, i32 0
  %74 = extractvalue { %struct.base_pyobj*, i32 } %71, 0
  store %struct.base_pyobj* %74, %struct.base_pyobj** %73, align 1
  %75 = getelementptr { %struct.base_pyobj*, i32 }* %72, i32 0, i32 1
  %76 = extractvalue { %struct.base_pyobj*, i32 } %71, 1
  store i32 %76, i32* %75, align 1
  %77 = bitcast %struct.list_struct* %1 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* bitcast (%struct.list_struct* @printing_list to i8*), i8* %77, i64 16, i32 8, i1 false)
  call void @print_pyobj(%struct.base_pyobj* byval align 8 %v)
  br label %78

; <label>:78                                      ; preds = %50, %48
  %79 = load i32* %i, align 4
  %80 = load i32* %max, align 4
  %81 = sub nsw i32 %80, 1
  %82 = icmp ne i32 %79, %81
  br i1 %82, label %83, label %85

; <label>:83                                      ; preds = %78
  %84 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @.str27, i32 0, i32 0))
  br label %85

; <label>:85                                      ; preds = %83, %78
  %86 = load i32* %i, align 4
  %87 = add nsw i32 %86, 1
  store i32 %87, i32* %i, align 4
  br label %88

; <label>:88                                      ; preds = %85
  %89 = load %struct.hashtable_itr** %itr, align 8
  %90 = call i32 @hashtable_iterator_advance(%struct.hashtable_itr* %89)
  %91 = icmp ne i32 %90, 0
  br i1 %91, label %28, label %92

; <label>:92                                      ; preds = %88
  br label %93

; <label>:93                                      ; preds = %92, %13
  %94 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([2 x i8]* @.str32, i32 0, i32 0))
  %95 = load i8* %inside_reset, align 1
  %96 = icmp ne i8 %95, 0
  br i1 %96, label %97, label %98

; <label>:97                                      ; preds = %93
  store i8 0, i8* @inside, align 1
  store i32 0, i32* getelementptr inbounds (%struct.list_struct* @printing_list, i32 0, i32 1), align 4
  store %struct.base_pyobj* null, %struct.base_pyobj** getelementptr inbounds (%struct.list_struct* @printing_list, i32 0, i32 0), align 8
  br label %98

; <label>:98                                      ; preds = %11, %97, %93
  ret void
}

; Function Attrs: nounwind ssp uwtable
define internal void @print_list(%struct.base_pyobj* byval align 8 %ls) #0 {
  %pyobj_list = alloca %struct.pyobj_struct*, align 8
  %will_reset = alloca i32, align 4
  %l = alloca %struct.list_struct, align 8
  %i = alloca i64, align 8
  %1 = call %struct.pyobj_struct* @project_big(%struct.base_pyobj* byval align 8 %ls)
  store %struct.pyobj_struct* %1, %struct.pyobj_struct** %pyobj_list, align 8
  %2 = load %struct.base_pyobj** @current_list, align 8
  %3 = icmp ne %struct.base_pyobj* %2, null
  br i1 %3, label %4, label %14

; <label>:4                                       ; preds = %0
  %5 = load %struct.base_pyobj** @current_list, align 8
  %6 = load %struct.pyobj_struct** %pyobj_list, align 8
  %7 = getelementptr inbounds %struct.pyobj_struct* %6, i32 0, i32 1
  %8 = bitcast %union.anon* %7 to %struct.list_struct*
  %9 = getelementptr inbounds %struct.list_struct* %8, i32 0, i32 0
  %10 = load %struct.base_pyobj** %9, align 8
  %11 = icmp eq %struct.base_pyobj* %5, %10
  br i1 %11, label %12, label %14

; <label>:12                                      ; preds = %4
  %13 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str25, i32 0, i32 0))
  br label %90

; <label>:14                                      ; preds = %4, %0
  store i32 0, i32* %will_reset, align 4
  %15 = load %struct.base_pyobj** @current_list, align 8
  %16 = icmp ne %struct.base_pyobj* %15, null
  br i1 %16, label %23, label %17

; <label>:17                                      ; preds = %14
  %18 = load %struct.pyobj_struct** %pyobj_list, align 8
  %19 = getelementptr inbounds %struct.pyobj_struct* %18, i32 0, i32 1
  %20 = bitcast %union.anon* %19 to %struct.list_struct*
  %21 = getelementptr inbounds %struct.list_struct* %20, i32 0, i32 0
  %22 = load %struct.base_pyobj** %21, align 8
  store %struct.base_pyobj* %22, %struct.base_pyobj** @current_list, align 8
  store i32 1, i32* %will_reset, align 4
  br label %23

; <label>:23                                      ; preds = %17, %14
  %24 = load %struct.pyobj_struct** %pyobj_list, align 8
  %25 = getelementptr inbounds %struct.pyobj_struct* %24, i32 0, i32 1
  %26 = bitcast %union.anon* %25 to %struct.list_struct*
  %27 = bitcast %struct.list_struct* %l to i8*
  %28 = bitcast %struct.list_struct* %26 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %27, i8* %28, i64 16, i32 8, i1 false)
  %29 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([2 x i8]* @.str26, i32 0, i32 0))
  store i64 0, i64* %i, align 8
  br label %30

; <label>:30                                      ; preds = %82, %23
  %31 = load i64* %i, align 8
  %32 = getelementptr inbounds %struct.list_struct* %l, i32 0, i32 1
  %33 = load i32* %32, align 4
  %34 = zext i32 %33 to i64
  %35 = icmp ult i64 %31, %34
  br i1 %35, label %36, label %85

; <label>:36                                      ; preds = %30
  %37 = load i64* %i, align 8
  %38 = getelementptr inbounds %struct.list_struct* %l, i32 0, i32 0
  %39 = load %struct.base_pyobj** %38, align 8
  %40 = getelementptr inbounds %struct.base_pyobj* %39, i64 %37
  %41 = call i32 @tag(%struct.base_pyobj* byval align 8 %40)
  %42 = icmp eq i32 %41, 3
  br i1 %42, label %43, label %67

; <label>:43                                      ; preds = %36
  %44 = load i64* %i, align 8
  %45 = getelementptr inbounds %struct.list_struct* %l, i32 0, i32 0
  %46 = load %struct.base_pyobj** %45, align 8
  %47 = getelementptr inbounds %struct.base_pyobj* %46, i64 %44
  %48 = call %struct.pyobj_struct* @project_big(%struct.base_pyobj* byval align 8 %47)
  %49 = getelementptr inbounds %struct.pyobj_struct* %48, i32 0, i32 0
  %50 = load i32* %49, align 4
  %51 = icmp eq i32 %50, 0
  br i1 %51, label %52, label %67

; <label>:52                                      ; preds = %43
  %53 = load i64* %i, align 8
  %54 = getelementptr inbounds %struct.list_struct* %l, i32 0, i32 0
  %55 = load %struct.base_pyobj** %54, align 8
  %56 = getelementptr inbounds %struct.base_pyobj* %55, i64 %53
  %57 = call %struct.pyobj_struct* @project_big(%struct.base_pyobj* byval align 8 %56)
  %58 = getelementptr inbounds %struct.pyobj_struct* %57, i32 0, i32 1
  %59 = bitcast %union.anon* %58 to %struct.list_struct*
  %60 = getelementptr inbounds %struct.list_struct* %59, i32 0, i32 0
  %61 = load %struct.base_pyobj** %60, align 8
  %62 = getelementptr inbounds %struct.list_struct* %l, i32 0, i32 0
  %63 = load %struct.base_pyobj** %62, align 8
  %64 = icmp eq %struct.base_pyobj* %61, %63
  br i1 %64, label %65, label %67

; <label>:65                                      ; preds = %52
  %66 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str25, i32 0, i32 0))
  br label %72

; <label>:67                                      ; preds = %52, %43, %36
  %68 = load i64* %i, align 8
  %69 = getelementptr inbounds %struct.list_struct* %l, i32 0, i32 0
  %70 = load %struct.base_pyobj** %69, align 8
  %71 = getelementptr inbounds %struct.base_pyobj* %70, i64 %68
  call void @print_pyobj(%struct.base_pyobj* byval align 8 %71)
  br label %72

; <label>:72                                      ; preds = %67, %65
  %73 = load i64* %i, align 8
  %74 = getelementptr inbounds %struct.list_struct* %l, i32 0, i32 1
  %75 = load i32* %74, align 4
  %76 = sub i32 %75, 1
  %77 = zext i32 %76 to i64
  %78 = icmp ne i64 %73, %77
  br i1 %78, label %79, label %81

; <label>:79                                      ; preds = %72
  %80 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @.str27, i32 0, i32 0))
  br label %81

; <label>:81                                      ; preds = %79, %72
  br label %82

; <label>:82                                      ; preds = %81
  %83 = load i64* %i, align 8
  %84 = add i64 %83, 1
  store i64 %84, i64* %i, align 8
  br label %30

; <label>:85                                      ; preds = %30
  %86 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([2 x i8]* @.str28, i32 0, i32 0))
  %87 = load i32* %will_reset, align 4
  %88 = icmp ne i32 %87, 0
  br i1 %88, label %89, label %90

; <label>:89                                      ; preds = %85
  store %struct.base_pyobj* null, %struct.base_pyobj** @current_list, align 8
  br label %90

; <label>:90                                      ; preds = %12, %89, %85
  ret void
}

; Function Attrs: nounwind ssp uwtable
define internal signext i8 @is_in_list(%struct.base_pyobj* %ls.coerce0, i32 %ls.coerce1, %struct.base_pyobj* byval align 8 %b) #0 {
  %1 = alloca i8, align 1
  %ls = alloca %struct.list_struct, align 8
  %i = alloca i64, align 8
  %2 = bitcast %struct.list_struct* %ls to { %struct.base_pyobj*, i32 }*
  %3 = getelementptr { %struct.base_pyobj*, i32 }* %2, i32 0, i32 0
  store %struct.base_pyobj* %ls.coerce0, %struct.base_pyobj** %3
  %4 = getelementptr { %struct.base_pyobj*, i32 }* %2, i32 0, i32 1
  store i32 %ls.coerce1, i32* %4
  store i64 0, i64* %i, align 8
  br label %5

; <label>:5                                       ; preds = %20, %0
  %6 = load i64* %i, align 8
  %7 = getelementptr inbounds %struct.list_struct* %ls, i32 0, i32 1
  %8 = load i32* %7, align 4
  %9 = zext i32 %8 to i64
  %10 = icmp ult i64 %6, %9
  br i1 %10, label %11, label %23

; <label>:11                                      ; preds = %5
  %12 = load i64* %i, align 8
  %13 = getelementptr inbounds %struct.list_struct* %ls, i32 0, i32 0
  %14 = load %struct.base_pyobj** %13, align 8
  %15 = getelementptr inbounds %struct.base_pyobj* %14, i64 %12
  %16 = call i32 @is_pyobj_equal(%struct.base_pyobj* byval align 8 %15, %struct.base_pyobj* byval align 8 %b)
  %17 = icmp ne i32 %16, 0
  br i1 %17, label %18, label %19

; <label>:18                                      ; preds = %11
  store i8 1, i8* %1
  br label %24

; <label>:19                                      ; preds = %11
  br label %20

; <label>:20                                      ; preds = %19
  %21 = load i64* %i, align 8
  %22 = add i64 %21, 1
  store i64 %22, i64* %i, align 8
  br label %5

; <label>:23                                      ; preds = %5
  store i8 0, i8* %1
  br label %24

; <label>:24                                      ; preds = %23, %18
  %25 = load i8* %1
  ret i8 %25
}

declare %struct.hashtable_itr* @hashtable_iterator(%struct.hashtable*) #4

declare i8* @hashtable_iterator_key(%struct.hashtable_itr*) #4

declare i8* @hashtable_iterator_value(%struct.hashtable_itr*) #4

; Function Attrs: nounwind ssp uwtable
define internal i32 @equal_pyobj(%struct.base_pyobj* byval align 8 %a, %struct.base_pyobj* byval align 8 %b) #0 {
  %1 = alloca i32, align 4
  %x = alloca %struct.pyobj_struct*, align 8
  %y = alloca %struct.pyobj_struct*, align 8
  %2 = call i32 @tag(%struct.base_pyobj* byval align 8 %a)
  switch i32 %2, label %114 [
    i32 0, label %3
    i32 2, label %21
    i32 1, label %42
    i32 3, label %60
  ]

; <label>:3                                       ; preds = %0
  %4 = call i32 @tag(%struct.base_pyobj* byval align 8 %b)
  switch i32 %4, label %20 [
    i32 0, label %5
    i32 1, label %10
    i32 2, label %15
  ]

; <label>:5                                       ; preds = %3
  %6 = call i32 @project_int(%struct.base_pyobj* byval align 8 %a)
  %7 = call i32 @project_int(%struct.base_pyobj* byval align 8 %b)
  %8 = icmp eq i32 %6, %7
  %9 = zext i1 %8 to i32
  store i32 %9, i32* %1
  br label %115

; <label>:10                                      ; preds = %3
  %11 = call i32 @project_int(%struct.base_pyobj* byval align 8 %a)
  %12 = call i32 @project_bool(%struct.base_pyobj* byval align 8 %b)
  %13 = icmp eq i32 %11, %12
  %14 = zext i1 %13 to i32
  store i32 %14, i32* %1
  br label %115

; <label>:15                                      ; preds = %3
  %16 = call i32 @project_int(%struct.base_pyobj* byval align 8 %a)
  %17 = call i32 @project_bool(%struct.base_pyobj* byval align 8 %b)
  %18 = icmp eq i32 %16, %17
  %19 = zext i1 %18 to i32
  store i32 %19, i32* %1
  br label %115

; <label>:20                                      ; preds = %3
  store i32 0, i32* %1
  br label %115

; <label>:21                                      ; preds = %0
  %22 = call i32 @tag(%struct.base_pyobj* byval align 8 %b)
  switch i32 %22, label %41 [
    i32 0, label %23
    i32 1, label %29
    i32 2, label %35
  ]

; <label>:23                                      ; preds = %21
  %24 = call float @project_float(%struct.base_pyobj* byval align 8 %a)
  %25 = call i32 @project_int(%struct.base_pyobj* byval align 8 %b)
  %26 = sitofp i32 %25 to float
  %27 = fcmp oeq float %24, %26
  %28 = zext i1 %27 to i32
  store i32 %28, i32* %1
  br label %115

; <label>:29                                      ; preds = %21
  %30 = call float @project_float(%struct.base_pyobj* byval align 8 %a)
  %31 = call i32 @project_bool(%struct.base_pyobj* byval align 8 %b)
  %32 = sitofp i32 %31 to float
  %33 = fcmp oeq float %30, %32
  %34 = zext i1 %33 to i32
  store i32 %34, i32* %1
  br label %115

; <label>:35                                      ; preds = %21
  %36 = call float @project_float(%struct.base_pyobj* byval align 8 %a)
  %37 = call i32 @project_bool(%struct.base_pyobj* byval align 8 %b)
  %38 = sitofp i32 %37 to float
  %39 = fcmp oeq float %36, %38
  %40 = zext i1 %39 to i32
  store i32 %40, i32* %1
  br label %115

; <label>:41                                      ; preds = %21
  store i32 0, i32* %1
  br label %115

; <label>:42                                      ; preds = %0
  %43 = call i32 @tag(%struct.base_pyobj* byval align 8 %b)
  switch i32 %43, label %59 [
    i32 0, label %44
    i32 1, label %49
    i32 2, label %54
  ]

; <label>:44                                      ; preds = %42
  %45 = call i32 @project_bool(%struct.base_pyobj* byval align 8 %a)
  %46 = call i32 @project_int(%struct.base_pyobj* byval align 8 %b)
  %47 = icmp eq i32 %45, %46
  %48 = zext i1 %47 to i32
  store i32 %48, i32* %1
  br label %115

; <label>:49                                      ; preds = %42
  %50 = call i32 @project_bool(%struct.base_pyobj* byval align 8 %a)
  %51 = call i32 @project_bool(%struct.base_pyobj* byval align 8 %b)
  %52 = icmp eq i32 %50, %51
  %53 = zext i1 %52 to i32
  store i32 %53, i32* %1
  br label %115

; <label>:54                                      ; preds = %42
  %55 = call i32 @project_bool(%struct.base_pyobj* byval align 8 %a)
  %56 = call i32 @project_bool(%struct.base_pyobj* byval align 8 %b)
  %57 = icmp eq i32 %55, %56
  %58 = zext i1 %57 to i32
  store i32 %58, i32* %1
  br label %115

; <label>:59                                      ; preds = %42
  store i32 0, i32* %1
  br label %115

; <label>:60                                      ; preds = %0
  %61 = call i32 @tag(%struct.base_pyobj* byval align 8 %b)
  %62 = icmp ne i32 %61, 3
  br i1 %62, label %63, label %64

; <label>:63                                      ; preds = %60
  store i32 0, i32* %1
  br label %115

; <label>:64                                      ; preds = %60
  %65 = call %struct.pyobj_struct* @project_big(%struct.base_pyobj* byval align 8 %a)
  store %struct.pyobj_struct* %65, %struct.pyobj_struct** %x, align 8
  %66 = call %struct.pyobj_struct* @project_big(%struct.base_pyobj* byval align 8 %b)
  store %struct.pyobj_struct* %66, %struct.pyobj_struct** %y, align 8
  %67 = load %struct.pyobj_struct** %x, align 8
  %68 = getelementptr inbounds %struct.pyobj_struct* %67, i32 0, i32 0
  %69 = load i32* %68, align 4
  %70 = load %struct.pyobj_struct** %y, align 8
  %71 = getelementptr inbounds %struct.pyobj_struct* %70, i32 0, i32 0
  %72 = load i32* %71, align 4
  %73 = icmp ne i32 %69, %72
  br i1 %73, label %74, label %75

; <label>:74                                      ; preds = %64
  store i32 0, i32* %1
  br label %115

; <label>:75                                      ; preds = %64
  %76 = load %struct.pyobj_struct** %x, align 8
  %77 = getelementptr inbounds %struct.pyobj_struct* %76, i32 0, i32 0
  %78 = load i32* %77, align 4
  switch i32 %78, label %113 [
    i32 0, label %79
    i32 1, label %97
    i32 3, label %108
  ]

; <label>:79                                      ; preds = %75
  %80 = load %struct.pyobj_struct** %x, align 8
  %81 = getelementptr inbounds %struct.pyobj_struct* %80, i32 0, i32 1
  %82 = bitcast %union.anon* %81 to %struct.list_struct*
  %83 = load %struct.pyobj_struct** %y, align 8
  %84 = getelementptr inbounds %struct.pyobj_struct* %83, i32 0, i32 1
  %85 = bitcast %union.anon* %84 to %struct.list_struct*
  %86 = bitcast %struct.list_struct* %82 to { %struct.base_pyobj*, i32 }*
  %87 = getelementptr { %struct.base_pyobj*, i32 }* %86, i32 0, i32 0
  %88 = load %struct.base_pyobj** %87, align 1
  %89 = getelementptr { %struct.base_pyobj*, i32 }* %86, i32 0, i32 1
  %90 = load i32* %89, align 1
  %91 = bitcast %struct.list_struct* %85 to { %struct.base_pyobj*, i32 }*
  %92 = getelementptr { %struct.base_pyobj*, i32 }* %91, i32 0, i32 0
  %93 = load %struct.base_pyobj** %92, align 1
  %94 = getelementptr { %struct.base_pyobj*, i32 }* %91, i32 0, i32 1
  %95 = load i32* %94, align 1
  %96 = call i32 @list_equal(%struct.base_pyobj* %88, i32 %90, %struct.base_pyobj* %93, i32 %95)
  store i32 %96, i32* %1
  br label %115

; <label>:97                                      ; preds = %75
  %98 = load %struct.pyobj_struct** %x, align 8
  %99 = getelementptr inbounds %struct.pyobj_struct* %98, i32 0, i32 1
  %100 = bitcast %union.anon* %99 to %struct.hashtable**
  %101 = load %struct.hashtable** %100, align 8
  %102 = load %struct.pyobj_struct** %y, align 8
  %103 = getelementptr inbounds %struct.pyobj_struct* %102, i32 0, i32 1
  %104 = bitcast %union.anon* %103 to %struct.hashtable**
  %105 = load %struct.hashtable** %104, align 8
  %106 = call signext i8 @dict_equal(%struct.hashtable* %101, %struct.hashtable* %105)
  %107 = sext i8 %106 to i32
  store i32 %107, i32* %1
  br label %115

; <label>:108                                     ; preds = %75
  %109 = load %struct.pyobj_struct** %x, align 8
  %110 = load %struct.pyobj_struct** %y, align 8
  %111 = icmp eq %struct.pyobj_struct* %109, %110
  %112 = zext i1 %111 to i32
  store i32 %112, i32* %1
  br label %115

; <label>:113                                     ; preds = %75
  store i32 0, i32* %1
  br label %115

; <label>:114                                     ; preds = %0
  store i32 0, i32* %1
  br label %115

; <label>:115                                     ; preds = %114, %113, %108, %97, %79, %74, %63, %59, %54, %49, %44, %41, %35, %29, %23, %20, %15, %10, %5
  %116 = load i32* %1
  ret i32 %116
}

declare i32 @hashtable_iterator_advance(%struct.hashtable_itr*) #4

; Function Attrs: nounwind ssp uwtable
define internal i32 @is_pyobj_equal(%struct.base_pyobj* byval align 8 %a, %struct.base_pyobj* byval align 8 %b) #0 {
  %1 = alloca i32, align 4
  %2 = getelementptr inbounds %struct.base_pyobj* %a, i32 0, i32 2
  %3 = load i8* %2, align 1
  %4 = sext i8 %3 to i32
  %5 = getelementptr inbounds %struct.base_pyobj* %b, i32 0, i32 2
  %6 = load i8* %5, align 1
  %7 = sext i8 %6 to i32
  %8 = icmp eq i32 %4, %7
  br i1 %8, label %9, label %28

; <label>:9                                       ; preds = %0
  %10 = getelementptr inbounds %struct.base_pyobj* %a, i32 0, i32 2
  %11 = load i8* %10, align 1
  %12 = sext i8 %11 to i32
  %13 = icmp eq i32 %12, 3
  br i1 %13, label %14, label %21

; <label>:14                                      ; preds = %9
  %15 = getelementptr inbounds %struct.base_pyobj* %a, i32 0, i32 1
  %16 = load i8** %15, align 8
  %17 = getelementptr inbounds %struct.base_pyobj* %b, i32 0, i32 1
  %18 = load i8** %17, align 8
  %19 = icmp eq i8* %16, %18
  %20 = zext i1 %19 to i32
  store i32 %20, i32* %1
  br label %29

; <label>:21                                      ; preds = %9
  %22 = getelementptr inbounds %struct.base_pyobj* %a, i32 0, i32 0
  %23 = load i64* %22, align 8
  %24 = getelementptr inbounds %struct.base_pyobj* %b, i32 0, i32 0
  %25 = load i64* %24, align 8
  %26 = icmp eq i64 %23, %25
  %27 = zext i1 %26 to i32
  store i32 %27, i32* %1
  br label %29

; <label>:28                                      ; preds = %0
  store i32 0, i32* %1
  br label %29

; <label>:29                                      ; preds = %28, %21, %14
  %30 = load i32* %1
  ret i32 %30
}

declare i32 @__snprintf_chk(i8*, i64, i32, i64, i8*, ...) #4

declare i32 @isdigit(i32) #4

; Function Attrs: nounwind ssp uwtable
define internal %struct.base_pyobj* @list_subscript(%struct.base_pyobj* %ls.coerce0, i32 %ls.coerce1, %struct.base_pyobj* byval align 8 %n) #0 {
  %1 = alloca %struct.base_pyobj*, align 8
  %ls = alloca %struct.list_struct, align 8
  %list_len = alloca i32, align 4
  %i = alloca i32, align 4
  %b = alloca i32, align 4
  %2 = bitcast %struct.list_struct* %ls to { %struct.base_pyobj*, i32 }*
  %3 = getelementptr { %struct.base_pyobj*, i32 }* %2, i32 0, i32 0
  store %struct.base_pyobj* %ls.coerce0, %struct.base_pyobj** %3
  %4 = getelementptr { %struct.base_pyobj*, i32 }* %2, i32 0, i32 1
  store i32 %ls.coerce1, i32* %4
  %5 = load i32* %list_len, align 4
  store i32 %5, i32* %list_len, align 4
  %6 = call i32 @tag(%struct.base_pyobj* byval align 8 %n)
  switch i32 %6, label %55 [
    i32 0, label %7
    i32 1, label %42
  ]

; <label>:7                                       ; preds = %0
  %8 = call i32 @project_int(%struct.base_pyobj* byval align 8 %n)
  store i32 %8, i32* %i, align 4
  %9 = load i32* %i, align 4
  %10 = icmp sle i32 0, %9
  br i1 %10, label %11, label %21

; <label>:11                                      ; preds = %7
  %12 = load i32* %i, align 4
  %13 = load i32* %list_len, align 4
  %14 = icmp slt i32 %12, %13
  br i1 %14, label %15, label %21

; <label>:15                                      ; preds = %11
  %16 = load i32* %i, align 4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds %struct.list_struct* %ls, i32 0, i32 0
  %19 = load %struct.base_pyobj** %18, align 8
  %20 = getelementptr inbounds %struct.base_pyobj* %19, i64 %17
  store %struct.base_pyobj* %20, %struct.base_pyobj** %1
  br label %57

; <label>:21                                      ; preds = %11, %7
  %22 = load i32* %list_len, align 4
  %23 = load i32* %i, align 4
  %24 = add nsw i32 %22, %23
  %25 = icmp sle i32 0, %24
  br i1 %25, label %26, label %40

; <label>:26                                      ; preds = %21
  %27 = load i32* %list_len, align 4
  %28 = load i32* %i, align 4
  %29 = add nsw i32 %27, %28
  %30 = load i32* %list_len, align 4
  %31 = icmp slt i32 %29, %30
  br i1 %31, label %32, label %40

; <label>:32                                      ; preds = %26
  %33 = load i32* %list_len, align 4
  %34 = load i32* %i, align 4
  %35 = add nsw i32 %33, %34
  %36 = sext i32 %35 to i64
  %37 = getelementptr inbounds %struct.list_struct* %ls, i32 0, i32 0
  %38 = load %struct.base_pyobj** %37, align 8
  %39 = getelementptr inbounds %struct.base_pyobj* %38, i64 %36
  store %struct.base_pyobj* %39, %struct.base_pyobj** %1
  br label %57

; <label>:40                                      ; preds = %26, %21
  %41 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([39 x i8]* @.str39, i32 0, i32 0))
  call void @exit(i32 1) #6
  unreachable

; <label>:42                                      ; preds = %0
  %43 = call i32 @project_bool(%struct.base_pyobj* byval align 8 %n)
  store i32 %43, i32* %b, align 4
  %44 = load i32* %b, align 4
  %45 = load i32* %list_len, align 4
  %46 = icmp slt i32 %44, %45
  br i1 %46, label %47, label %53

; <label>:47                                      ; preds = %42
  %48 = load i32* %b, align 4
  %49 = sext i32 %48 to i64
  %50 = getelementptr inbounds %struct.list_struct* %ls, i32 0, i32 0
  %51 = load %struct.base_pyobj** %50, align 8
  %52 = getelementptr inbounds %struct.base_pyobj* %51, i64 %49
  store %struct.base_pyobj* %52, %struct.base_pyobj** %1
  br label %57

; <label>:53                                      ; preds = %42
  %54 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([39 x i8]* @.str39, i32 0, i32 0))
  call void @exit(i32 1) #6
  unreachable

; <label>:55                                      ; preds = %0
  %56 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([39 x i8]* @.str40, i32 0, i32 0))
  call void @exit(i32 1) #6
  unreachable

; <label>:57                                      ; preds = %47, %32, %15
  %58 = load %struct.base_pyobj** %1
  ret %struct.base_pyobj* %58
}

; Function Attrs: nounwind ssp uwtable
define internal %struct.base_pyobj* @dict_subscript(%struct.hashtable* %d, %struct.base_pyobj* byval align 8 %key) #0 {
  %1 = alloca %struct.base_pyobj*, align 8
  %2 = alloca %struct.hashtable*, align 8
  %p = alloca i8*, align 8
  %k = alloca %struct.base_pyobj*, align 8
  %v = alloca %struct.base_pyobj*, align 8
  %3 = alloca %struct.base_pyobj, align 8
  store %struct.hashtable* %d, %struct.hashtable** %2, align 8
  %4 = load %struct.hashtable** %2, align 8
  %5 = bitcast %struct.base_pyobj* %key to i8*
  %6 = call i8* @hashtable_search(%struct.hashtable* %4, i8* %5)
  store i8* %6, i8** %p, align 8
  %7 = load i8** %p, align 8
  %8 = icmp ne i8* %7, null
  br i1 %8, label %9, label %12

; <label>:9                                       ; preds = %0
  %10 = load i8** %p, align 8
  %11 = bitcast i8* %10 to %struct.base_pyobj*
  store %struct.base_pyobj* %11, %struct.base_pyobj** %1
  br label %30

; <label>:12                                      ; preds = %0
  %13 = call i8* @malloc(i64 24)
  %14 = bitcast i8* %13 to %struct.base_pyobj*
  store %struct.base_pyobj* %14, %struct.base_pyobj** %k, align 8
  %15 = load %struct.base_pyobj** %k, align 8
  %16 = bitcast %struct.base_pyobj* %15 to i8*
  %17 = bitcast %struct.base_pyobj* %key to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %16, i8* %17, i64 24, i32 8, i1 false)
  %18 = call i8* @malloc(i64 24)
  %19 = bitcast i8* %18 to %struct.base_pyobj*
  store %struct.base_pyobj* %19, %struct.base_pyobj** %v, align 8
  %20 = load %struct.base_pyobj** %v, align 8
  call void @inject_int(%struct.base_pyobj* sret %3, i32 444)
  %21 = bitcast %struct.base_pyobj* %20 to i8*
  %22 = bitcast %struct.base_pyobj* %3 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %21, i8* %22, i64 24, i32 8, i1 false)
  %23 = load %struct.hashtable** %2, align 8
  %24 = load %struct.base_pyobj** %k, align 8
  %25 = bitcast %struct.base_pyobj* %24 to i8*
  %26 = load %struct.base_pyobj** %v, align 8
  %27 = bitcast %struct.base_pyobj* %26 to i8*
  %28 = call i32 @hashtable_insert(%struct.hashtable* %23, i8* %25, i8* %27)
  %29 = load %struct.base_pyobj** %v, align 8
  store %struct.base_pyobj* %29, %struct.base_pyobj** %1
  br label %30

; <label>:30                                      ; preds = %12, %9
  %31 = load %struct.base_pyobj** %1
  ret %struct.base_pyobj* %31
}

; Function Attrs: nounwind ssp uwtable
define internal i32 @hash32shift(i32 %key) #0 {
  %1 = alloca i32, align 4
  store i32 %key, i32* %1, align 4
  %2 = load i32* %1, align 4
  %3 = xor i32 %2, -1
  %4 = load i32* %1, align 4
  %5 = shl i32 %4, 15
  %6 = add nsw i32 %3, %5
  store i32 %6, i32* %1, align 4
  %7 = load i32* %1, align 4
  %8 = load i32* %1, align 4
  %9 = ashr i32 %8, 12
  %10 = xor i32 %7, %9
  store i32 %10, i32* %1, align 4
  %11 = load i32* %1, align 4
  %12 = load i32* %1, align 4
  %13 = shl i32 %12, 2
  %14 = add nsw i32 %11, %13
  store i32 %14, i32* %1, align 4
  %15 = load i32* %1, align 4
  %16 = load i32* %1, align 4
  %17 = ashr i32 %16, 4
  %18 = xor i32 %15, %17
  store i32 %18, i32* %1, align 4
  %19 = load i32* %1, align 4
  %20 = mul nsw i32 %19, 2057
  store i32 %20, i32* %1, align 4
  %21 = load i32* %1, align 4
  %22 = load i32* %1, align 4
  %23 = ashr i32 %22, 16
  %24 = xor i32 %21, %23
  store i32 %24, i32* %1, align 4
  %25 = load i32* %1, align 4
  ret i32 %25
}

attributes #0 = { nounwind ssp uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nounwind readnone }
attributes #3 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { noreturn }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Apple LLVM version 6.0 (clang-600.0.56) (based on LLVM 3.5svn)"}
