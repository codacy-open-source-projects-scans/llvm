// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --include-generated-funcs --replace-value-regex "__omp_offloading_[0-9a-z]+_[0-9a-z]+" "reduction_size[.].+[.]" "pl_cond[.].+[.|,]" --prefix-filecheck-ir-name _ --version 3
// REQUIRES: amdgpu-registered-target

// RUN: %clang_cc1 -fopenmp -x c++ -std=c++11 -triple x86_64-unknown-unknown -fopenmp-targets=amdgcn-amd-amdhsa -emit-llvm %s -o - \
// RUN: | FileCheck %s

// Check same results after serialization round-trip
// RUN: %clang_cc1 -fopenmp -x c++ -std=c++11 -triple x86_64-unknown-unknown -fopenmp-targets=amdgcn-amd-amdhsa -emit-pch -o %t %s
// RUN: %clang_cc1 -fopenmp -x c++ -std=c++11 -triple x86_64-unknown-unknown -fopenmp-targets=amdgcn-amd-amdhsa -include-pch %t -emit-llvm %s -o - \
// RUN: | FileCheck %s

// expected-no-diagnostics
#ifndef HEADER
#define HEADER

extern bool foo(bool);

int if_logical() {
  bool a = foo(true);
  bool b = foo(true);
  int pp = 42;
  int *p = &pp;
  #pragma omp target data if(a && b) map(to: p[0])
  {
    p[0]++;
  }
  if (p[0])
    return 1;
  return 0;
}

int main() {
  return if_logical();
}

#endif
// CHECK-LABEL: define dso_local noundef i32 @_Z10if_logicalv(
// CHECK-SAME: ) #[[ATTR0:[0-9]+]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[RETVAL:%.*]] = alloca i32, align 4
// CHECK-NEXT:    [[A:%.*]] = alloca i8, align 1
// CHECK-NEXT:    [[B:%.*]] = alloca i8, align 1
// CHECK-NEXT:    [[PP:%.*]] = alloca i32, align 4
// CHECK-NEXT:    [[P:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[DOTOFFLOAD_BASEPTRS:%.*]] = alloca [1 x ptr], align 8
// CHECK-NEXT:    [[DOTOFFLOAD_PTRS:%.*]] = alloca [1 x ptr], align 8
// CHECK-NEXT:    [[DOTOFFLOAD_MAPPERS:%.*]] = alloca [1 x ptr], align 8
// CHECK-NEXT:    [[CALL:%.*]] = call noundef zeroext i1 @_Z3foob(i1 noundef zeroext true)
// CHECK-NEXT:    [[FROMBOOL:%.*]] = zext i1 [[CALL]] to i8
// CHECK-NEXT:    store i8 [[FROMBOOL]], ptr [[A]], align 1
// CHECK-NEXT:    [[CALL1:%.*]] = call noundef zeroext i1 @_Z3foob(i1 noundef zeroext true)
// CHECK-NEXT:    [[FROMBOOL2:%.*]] = zext i1 [[CALL1]] to i8
// CHECK-NEXT:    store i8 [[FROMBOOL2]], ptr [[B]], align 1
// CHECK-NEXT:    store i32 42, ptr [[PP]], align 4
// CHECK-NEXT:    store ptr [[PP]], ptr [[P]], align 8
// CHECK-NEXT:    [[TMP0:%.*]] = load i8, ptr [[A]], align 1
// CHECK-NEXT:    [[TOBOOL:%.*]] = trunc i8 [[TMP0]] to i1
// CHECK-NEXT:    br i1 [[TOBOOL]], label [[LAND_RHS:%.*]], label [[LAND_END:%.*]]
// CHECK:       land.rhs:
// CHECK-NEXT:    [[TMP1:%.*]] = load i8, ptr [[B]], align 1
// CHECK-NEXT:    [[TOBOOL3:%.*]] = trunc i8 [[TMP1]] to i1
// CHECK-NEXT:    br label [[LAND_END]]
// CHECK:       land.end:
// CHECK-NEXT:    [[TMP2:%.*]] = phi i1 [ false, [[ENTRY:%.*]] ], [ [[TOBOOL3]], [[LAND_RHS]] ]
// CHECK-NEXT:    br i1 [[TMP2]], label [[OMP_IF_THEN:%.*]], label [[OMP_IF_ELSE:%.*]]
// CHECK:       omp_if.then:
// CHECK-NEXT:    [[TMP3:%.*]] = load ptr, ptr [[P]], align 8
// CHECK-NEXT:    [[TMP4:%.*]] = load ptr, ptr [[P]], align 8
// CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i32, ptr [[TMP4]], i64 0
// CHECK-NEXT:    [[TMP5:%.*]] = getelementptr inbounds [1 x ptr], ptr [[DOTOFFLOAD_BASEPTRS]], i32 0, i32 0
// CHECK-NEXT:    store ptr [[TMP3]], ptr [[TMP5]], align 8
// CHECK-NEXT:    [[TMP6:%.*]] = getelementptr inbounds [1 x ptr], ptr [[DOTOFFLOAD_PTRS]], i32 0, i32 0
// CHECK-NEXT:    store ptr [[ARRAYIDX]], ptr [[TMP6]], align 8
// CHECK-NEXT:    [[TMP7:%.*]] = getelementptr inbounds [1 x ptr], ptr [[DOTOFFLOAD_MAPPERS]], i64 0, i64 0
// CHECK-NEXT:    store ptr null, ptr [[TMP7]], align 8
// CHECK-NEXT:    [[TMP8:%.*]] = getelementptr inbounds [1 x ptr], ptr [[DOTOFFLOAD_BASEPTRS]], i32 0, i32 0
// CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds [1 x ptr], ptr [[DOTOFFLOAD_PTRS]], i32 0, i32 0
// CHECK-NEXT:    call void @__tgt_target_data_begin_mapper(ptr @[[GLOB1:[0-9]+]], i64 -1, i32 1, ptr [[TMP8]], ptr [[TMP9]], ptr @.offload_sizes, ptr @.offload_maptypes, ptr null, ptr null)
// CHECK-NEXT:    br label [[OMP_IF_END:%.*]]
// CHECK:       omp_if.else:
// CHECK-NEXT:    br label [[OMP_IF_END]]
// CHECK:       omp_if.end:
// CHECK-NEXT:    [[TMP10:%.*]] = load ptr, ptr [[P]], align 8
// CHECK-NEXT:    [[ARRAYIDX4:%.*]] = getelementptr inbounds i32, ptr [[TMP10]], i64 0
// CHECK-NEXT:    [[TMP11:%.*]] = load i32, ptr [[ARRAYIDX4]], align 4
// CHECK-NEXT:    [[INC:%.*]] = add nsw i32 [[TMP11]], 1
// CHECK-NEXT:    store i32 [[INC]], ptr [[ARRAYIDX4]], align 4
// CHECK-NEXT:    br i1 [[TMP2]], label [[OMP_IF_THEN5:%.*]], label [[OMP_IF_ELSE6:%.*]]
// CHECK:       omp_if.then5:
// CHECK-NEXT:    [[TMP12:%.*]] = getelementptr inbounds [1 x ptr], ptr [[DOTOFFLOAD_BASEPTRS]], i32 0, i32 0
// CHECK-NEXT:    [[TMP13:%.*]] = getelementptr inbounds [1 x ptr], ptr [[DOTOFFLOAD_PTRS]], i32 0, i32 0
// CHECK-NEXT:    call void @__tgt_target_data_end_mapper(ptr @[[GLOB1]], i64 -1, i32 1, ptr [[TMP12]], ptr [[TMP13]], ptr @.offload_sizes, ptr @.offload_maptypes, ptr null, ptr null)
// CHECK-NEXT:    br label [[OMP_IF_END7:%.*]]
// CHECK:       omp_if.else6:
// CHECK-NEXT:    br label [[OMP_IF_END7]]
// CHECK:       omp_if.end7:
// CHECK-NEXT:    [[TMP14:%.*]] = load ptr, ptr [[P]], align 8
// CHECK-NEXT:    [[ARRAYIDX8:%.*]] = getelementptr inbounds i32, ptr [[TMP14]], i64 0
// CHECK-NEXT:    [[TMP15:%.*]] = load i32, ptr [[ARRAYIDX8]], align 4
// CHECK-NEXT:    [[TOBOOL9:%.*]] = icmp ne i32 [[TMP15]], 0
// CHECK-NEXT:    br i1 [[TOBOOL9]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
// CHECK:       if.then:
// CHECK-NEXT:    store i32 1, ptr [[RETVAL]], align 4
// CHECK-NEXT:    br label [[RETURN:%.*]]
// CHECK:       if.end:
// CHECK-NEXT:    store i32 0, ptr [[RETVAL]], align 4
// CHECK-NEXT:    br label [[RETURN]]
// CHECK:       return:
// CHECK-NEXT:    [[TMP16:%.*]] = load i32, ptr [[RETVAL]], align 4
// CHECK-NEXT:    ret i32 [[TMP16]]
//
//
// CHECK-LABEL: define dso_local noundef i32 @main(
// CHECK-SAME: ) #[[ATTR3:[0-9]+]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[RETVAL:%.*]] = alloca i32, align 4
// CHECK-NEXT:    store i32 0, ptr [[RETVAL]], align 4
// CHECK-NEXT:    [[CALL:%.*]] = call noundef i32 @_Z10if_logicalv()
// CHECK-NEXT:    ret i32 [[CALL]]
//