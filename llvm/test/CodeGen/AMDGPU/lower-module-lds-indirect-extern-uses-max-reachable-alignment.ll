; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 3
; RUN: opt -S -mtriple=amdgcn-- -passes=amdgpu-lower-module-lds < %s | FileCheck %s

; Not reached by a non-kernel function and therefore not changed by this pass
@dynamic_kernel_only = external addrspace(3) global [0 x double]

; shared8 is used directly by a kernel so remains in the outbout
; the other three are only used by functions and will be replaced with
; table lookups and dropped from the IR
@dynamic_shared1 = external addrspace(3) global [0 x i8], align 1
@dynamic_shared2 = external addrspace(3) global [0 x i16], align 2
@dynamic_shared4 = external addrspace(3) global [0 x i32], align 4
@dynamic_shared8 = external addrspace(3) global [0 x i64], align 8

; CHECK: %llvm.amdgcn.module.lds.t = type { i32 }
; CHECK: @dynamic_kernel_only = external addrspace(3) global [0 x double]
; CHECK: @dynamic_shared8 = external addrspace(3) global [0 x i64], align 8
; CHECK: @llvm.amdgcn.module.lds = internal addrspace(3) global %llvm.amdgcn.module.lds.t poison, align 4, !absolute_symbol !0
; CHECK: @llvm.compiler.used = appending addrspace(1) global [1 x ptr] [ptr addrspacecast (ptr addrspace(3) @llvm.amdgcn.module.lds to ptr)], section "llvm.metadata"

; Alignment of these must be the maximum of the alignment of the reachable symbols
; CHECK: @llvm.amdgcn.expect_align1.dynlds = external addrspace(3) global [0 x i8], align 1, !absolute_symbol !0
; CHECK: @llvm.amdgcn.expect_align2.dynlds = external addrspace(3) global [0 x i8], align 2, !absolute_symbol !0
; CHECK: @llvm.amdgcn.expect_align4.dynlds = external addrspace(3) global [0 x i8], align 4, !absolute_symbol !1
; CHECK: @llvm.amdgcn.expect_align8.dynlds = external addrspace(3) global [0 x i8], align 8, !absolute_symbol !0

; Align 4 and symbol at address [4 5) as module.lds is reachable
; CHECK: @llvm.amdgcn.expect_max_of_2_and_4.dynlds = external addrspace(3) global [0 x i8], align 4, !absolute_symbol !1

; Builds a lookup table out of the newly created (suffixed .dynlds) variables in kernel.id order
; CHECK: @llvm.amdgcn.dynlds.offset.table = internal addrspace(4) constant [5 x i32] [i32 ptrtoint (ptr addrspace(3) @llvm.amdgcn.expect_align1.dynlds to i32), i32 ptrtoint (ptr addrspace(3) @llvm.amdgcn.expect_align2.dynlds to i32), i32 ptrtoint (ptr addrspace(3) @llvm.amdgcn.expect_align4.dynlds to i32), i32 ptrtoint (ptr addrspace(3) @llvm.amdgcn.expect_align8.dynlds to i32), i32 ptrtoint (ptr addrspace(3) @llvm.amdgcn.expect_max_of_2_and_4.dynlds to i32)]



define amdgpu_kernel void @kernel_only() {
; CHECK-LABEL: define amdgpu_kernel void @kernel_only() {
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds [0 x double], ptr addrspace(3) @dynamic_kernel_only, i32 0, i32 0
; CHECK-NEXT:    store double 3.140000e+00, ptr addrspace(3) [[ARRAYIDX]], align 8
; CHECK-NEXT:    ret void
;
  %arrayidx = getelementptr inbounds [0 x double], ptr addrspace(3) @dynamic_kernel_only, i32 0, i32 0
  store double 3.140000e+00, ptr addrspace(3) %arrayidx
  ret void
}

; The accesses from functions are rewritten to go through the llvm.amdgcn.dynlds.offset.table
define void @use_shared1() {
; CHECK-LABEL: define void @use_shared1() {
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.amdgcn.lds.kernel.id()
; CHECK-NEXT:    [[DYNAMIC_SHARED1:%.*]] = getelementptr inbounds [5 x i32], ptr addrspace(4) @llvm.amdgcn.dynlds.offset.table, i32 0, i32 [[TMP1]]
; CHECK-NEXT:    [[TMP2:%.*]] = load i32, ptr addrspace(4) [[DYNAMIC_SHARED1]], align 4
; CHECK-NEXT:    [[DYNAMIC_SHARED11:%.*]] = inttoptr i32 [[TMP2]] to ptr addrspace(3)
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds [0 x i8], ptr addrspace(3) [[DYNAMIC_SHARED11]], i32 0, i32 1
; CHECK-NEXT:    store i8 0, ptr addrspace(3) [[ARRAYIDX]], align 1
; CHECK-NEXT:    ret void
;
  %arrayidx = getelementptr inbounds [0 x i8], ptr addrspace(3) @dynamic_shared1, i32 0, i32 1
  store i8 0, ptr addrspace(3) %arrayidx
  ret void
}

define void @use_shared2() #0 {
; CHECK-LABEL: define void @use_shared2(
; CHECK-SAME: ) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.amdgcn.lds.kernel.id()
; CHECK-NEXT:    [[DYNAMIC_SHARED2:%.*]] = getelementptr inbounds [5 x i32], ptr addrspace(4) @llvm.amdgcn.dynlds.offset.table, i32 0, i32 [[TMP1]]
; CHECK-NEXT:    [[TMP2:%.*]] = load i32, ptr addrspace(4) [[DYNAMIC_SHARED2]], align 4
; CHECK-NEXT:    [[DYNAMIC_SHARED21:%.*]] = inttoptr i32 [[TMP2]] to ptr addrspace(3)
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds [0 x i16], ptr addrspace(3) [[DYNAMIC_SHARED21]], i32 0, i32 3
; CHECK-NEXT:    store i16 1, ptr addrspace(3) [[ARRAYIDX]], align 2
; CHECK-NEXT:    ret void
;
  %arrayidx = getelementptr inbounds [0 x i16], ptr addrspace(3) @dynamic_shared2, i32 0, i32 3
  store i16 1, ptr addrspace(3) %arrayidx
  ret void
}

; Include a normal variable so that the new variables aren't all at the same absolute_symbol
@static_shared = addrspace(3) global i32 poison
define void @use_shared4() #0 {
; CHECK-LABEL: define void @use_shared4(
; CHECK-SAME: ) #[[ATTR0]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.amdgcn.lds.kernel.id()
; CHECK-NEXT:    store i32 4, ptr addrspace(3) @llvm.amdgcn.module.lds, align 4
; CHECK-NEXT:    [[DYNAMIC_SHARED4:%.*]] = getelementptr inbounds [5 x i32], ptr addrspace(4) @llvm.amdgcn.dynlds.offset.table, i32 0, i32 [[TMP1]]
; CHECK-NEXT:    [[TMP2:%.*]] = load i32, ptr addrspace(4) [[DYNAMIC_SHARED4]], align 4
; CHECK-NEXT:    [[DYNAMIC_SHARED41:%.*]] = inttoptr i32 [[TMP2]] to ptr addrspace(3)
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds [0 x i32], ptr addrspace(3) [[DYNAMIC_SHARED41]], i32 0, i32 5
; CHECK-NEXT:    store i32 2, ptr addrspace(3) [[ARRAYIDX]], align 4
; CHECK-NEXT:    ret void
;
  store i32 4, ptr addrspace(3) @static_shared
  %arrayidx = getelementptr inbounds [0 x i32], ptr addrspace(3) @dynamic_shared4, i32 0, i32 5
  store i32 2, ptr addrspace(3) %arrayidx
  ret void
}

define void @use_shared8() #0 {
; CHECK-LABEL: define void @use_shared8(
; CHECK-SAME: ) #[[ATTR0]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.amdgcn.lds.kernel.id()
; CHECK-NEXT:    [[DYNAMIC_SHARED8:%.*]] = getelementptr inbounds [5 x i32], ptr addrspace(4) @llvm.amdgcn.dynlds.offset.table, i32 0, i32 [[TMP1]]
; CHECK-NEXT:    [[TMP2:%.*]] = load i32, ptr addrspace(4) [[DYNAMIC_SHARED8]], align 4
; CHECK-NEXT:    [[DYNAMIC_SHARED81:%.*]] = inttoptr i32 [[TMP2]] to ptr addrspace(3)
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds [0 x i64], ptr addrspace(3) [[DYNAMIC_SHARED81]], i32 0, i32 7
; CHECK-NEXT:    store i64 3, ptr addrspace(3) [[ARRAYIDX]], align 8
; CHECK-NEXT:    ret void
;
  %arrayidx = getelementptr inbounds [0 x i64], ptr addrspace(3) @dynamic_shared8, i32 0, i32 7
  store i64 3, ptr addrspace(3) %arrayidx
  ret void
}

; The kernels are annotated with kernel.id and llvm.donothing use of the corresponding variable
define amdgpu_kernel void @expect_align1() {
; CHECK-LABEL: define amdgpu_kernel void @expect_align1() !llvm.amdgcn.lds.kernel.id !2 {
; CHECK-NEXT:    call void @llvm.donothing() [ "ExplicitUse"(ptr addrspace(3) @llvm.amdgcn.expect_align1.dynlds) ]
; CHECK-NEXT:    call void @use_shared1()
; CHECK-NEXT:    ret void
;
  call void @use_shared1()
  ret void
}

define amdgpu_kernel void @expect_align2() {
; CHECK-LABEL: define amdgpu_kernel void @expect_align2() !llvm.amdgcn.lds.kernel.id !3 {
; CHECK-NEXT:    call void @llvm.donothing() [ "ExplicitUse"(ptr addrspace(3) @llvm.amdgcn.expect_align2.dynlds) ]
; CHECK-NEXT:    call void @use_shared2()
; CHECK-NEXT:    ret void
;
  call void @use_shared2()
  ret void
}

define amdgpu_kernel void @expect_align4() {
; CHECK-LABEL: define amdgpu_kernel void @expect_align4(
; CHECK-SAME: ) #[[ATTR1:[0-9]+]] !llvm.amdgcn.lds.kernel.id !4 {
; CHECK-NEXT:    call void @llvm.donothing() [ "ExplicitUse"(ptr addrspace(3) @llvm.amdgcn.expect_align4.dynlds) ]
; CHECK-NEXT:    call void @llvm.donothing() [ "ExplicitUse"(ptr addrspace(3) @llvm.amdgcn.module.lds) ]
; CHECK-NEXT:    call void @use_shared4()
; CHECK-NEXT:    ret void
;
  call void @use_shared4()
  ret void
}

; Use dynamic_shared directly too.
define amdgpu_kernel void @expect_align8() {
; CHECK-LABEL: define amdgpu_kernel void @expect_align8() !llvm.amdgcn.lds.kernel.id !5 {
; CHECK-NEXT:    call void @llvm.donothing() [ "ExplicitUse"(ptr addrspace(3) @llvm.amdgcn.expect_align8.dynlds) ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds [0 x i64], ptr addrspace(3) @dynamic_shared8, i32 0, i32 9
; CHECK-NEXT:    store i64 3, ptr addrspace(3) [[ARRAYIDX]], align 8
; CHECK-NEXT:    call void @use_shared8()
; CHECK-NEXT:    ret void
;
  %arrayidx = getelementptr inbounds [0 x i64], ptr addrspace(3) @dynamic_shared8, i32 0, i32 9
  store i64 3, ptr addrspace(3) %arrayidx
  call void @use_shared8()
  ret void
}

; Note: use_shared4 uses module.lds so this will allocate at offset 4
define amdgpu_kernel void @expect_max_of_2_and_4() {
; CHECK-LABEL: define amdgpu_kernel void @expect_max_of_2_and_4(
; CHECK-SAME: ) #[[ATTR1]] !llvm.amdgcn.lds.kernel.id !6 {
; CHECK-NEXT:    call void @llvm.donothing() [ "ExplicitUse"(ptr addrspace(3) @llvm.amdgcn.expect_max_of_2_and_4.dynlds) ]
; CHECK-NEXT:    call void @llvm.donothing() [ "ExplicitUse"(ptr addrspace(3) @llvm.amdgcn.module.lds) ]
; CHECK-NEXT:    call void @use_shared2()
; CHECK-NEXT:    call void @use_shared4()
; CHECK-NEXT:    ret void
;
  call void @use_shared2()
  call void @use_shared4()
  ret void
}


attributes #0 = { noinline }

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
; CHECK: declare void @llvm.donothing() #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
; CHECK: declare noundef i32 @llvm.amdgcn.lds.kernel.id() #3

; CHECK: attributes #0 = { noinline }
; CHECK: attributes #1 = { "amdgpu-lds-size"="4,4" }
; CHECK: attributes #2 = { nocallback nofree nosync nounwind willreturn memory(none) }
; CHECK: attributes #3 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

; CHECK: !0 = !{i32 0, i32 1}
; CHECK: !1 = !{i32 4, i32 5}
; CHECK: !2 = !{i32 0}
; CHECK: !3 = !{i32 1}
; CHECK: !4 = !{i32 2}
; CHECK: !5 = !{i32 3}
; CHECK: !6 = !{i32 4}