; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --check-globals all --version 4
; RUN: opt < %s -passes=amdgpu-sw-lower-lds -S -mtriple=amdgcn-amd-amdhsa | FileCheck %s

; Test to check indirect dynamic LDS access through a non-kernel from kernel is lowered correctly.
@lds_1 = internal addrspace(3) global [1 x i8] poison, align 1
@lds_2 = internal addrspace(3) global [1 x i32] poison, align 2
@lds_3 = external addrspace(3) global [0 x i8], align 4
@lds_4 = external addrspace(3) global [0 x i8], align 8

;.
; CHECK: @llvm.amdgcn.sw.lds.k0 = internal addrspace(3) global ptr poison, no_sanitize_address, align 8, !absolute_symbol [[META0:![0-9]+]]
; CHECK: @llvm.amdgcn.k0.dynlds = external addrspace(3) global [0 x i8], no_sanitize_address, align 8, !absolute_symbol [[META1:![0-9]+]]
; CHECK: @llvm.amdgcn.sw.lds.k0.md = internal addrspace(1) global %llvm.amdgcn.sw.lds.k0.md.type { %llvm.amdgcn.sw.lds.k0.md.item { i32 0, i32 8, i32 32 }, %llvm.amdgcn.sw.lds.k0.md.item { i32 32, i32 1, i32 32 }, %llvm.amdgcn.sw.lds.k0.md.item { i32 64, i32 4, i32 32 }, %llvm.amdgcn.sw.lds.k0.md.item { i32 96, i32 0, i32 32 }, %llvm.amdgcn.sw.lds.k0.md.item { i32 128, i32 0, i32 32 } }, no_sanitize_address
; @llvm.amdgcn.sw.lds.base.table = internal addrspace(1) constant [1 x ptr addrspace(3)] [ptr addrspace(3) @llvm.amdgcn.sw.lds.k0], no_sanitize_address
; @llvm.amdgcn.sw.lds.offset.table = internal addrspace(1) constant [1 x [2 x ptr addrspace(1)]] [[2 x ptr addrspace(1)] [ptr addrspace(1) getelementptr inbounds (%llvm.amdgcn.sw.lds.k0.md.type, ptr addrspace(1) @llvm.amdgcn.sw.lds.k0.md, i32 0, i32 3, i32 0), ptr addrspace(1) getelementptr inbounds (%llvm.amdgcn.sw.lds.k0.md.type, ptr addrspace(1) @llvm.amdgcn.sw.lds.k0.md, i32 0, i32 4, i32 0)]], no_sanitize_address
;.
define void @use_variables() sanitize_address {
; CHECK-LABEL: define void @use_variables(
; CHECK-SAME: ) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.amdgcn.lds.kernel.id()
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr inbounds [1 x ptr addrspace(3)], ptr addrspace(1) @llvm.amdgcn.sw.lds.base.table, i32 0, i32 [[TMP1]]
; CHECK-NEXT:    [[TMP4:%.*]] = load ptr addrspace(3), ptr addrspace(1) [[TMP2]], align 4
; CHECK-NEXT:    [[TMP7:%.*]] = load ptr addrspace(1), ptr addrspace(3) [[TMP4]], align 8
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr inbounds [1 x [2 x ptr addrspace(1)]], ptr addrspace(1) @llvm.amdgcn.sw.lds.offset.table, i32 0, i32 [[TMP1]], i32 0
; CHECK-NEXT:    [[TMP5:%.*]] = load ptr addrspace(1), ptr addrspace(1) [[TMP6]], align 8
; CHECK-NEXT:    [[TMP8:%.*]] = load i32, ptr addrspace(1) [[TMP5]], align 4
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds i8, ptr addrspace(3) [[TMP4]], i32 [[TMP8]]
; CHECK-NEXT:    [[TMP11:%.*]] = getelementptr inbounds [1 x [2 x ptr addrspace(1)]], ptr addrspace(1) @llvm.amdgcn.sw.lds.offset.table, i32 0, i32 [[TMP1]], i32 1
; CHECK-NEXT:    [[TMP12:%.*]] = load ptr addrspace(1), ptr addrspace(1) [[TMP11]], align 8
; CHECK-NEXT:    [[TMP10:%.*]] = load i32, ptr addrspace(1) [[TMP12]], align 4
; CHECK-NEXT:    [[TMP15:%.*]] = getelementptr inbounds i8, ptr addrspace(3) [[TMP4]], i32 [[TMP10]]
; CHECK-NEXT:    [[TMP13:%.*]] = ptrtoint ptr addrspace(3) [[TMP9]] to i32
; CHECK-NEXT:    [[TMP14:%.*]] = getelementptr inbounds i8, ptr addrspace(1) [[TMP7]], i32 [[TMP13]]
; CHECK-NEXT:    [[TMP47:%.*]] = ptrtoint ptr addrspace(1) [[TMP14]] to i64
; CHECK-NEXT:    [[TMP16:%.*]] = lshr i64 [[TMP47]], 3
; CHECK-NEXT:    [[TMP17:%.*]] = add i64 [[TMP16]], 2147450880
; CHECK-NEXT:    [[TMP18:%.*]] = inttoptr i64 [[TMP17]] to ptr
; CHECK-NEXT:    [[TMP19:%.*]] = load i8, ptr [[TMP18]], align 1
; CHECK-NEXT:    [[TMP20:%.*]] = icmp ne i8 [[TMP19]], 0
; CHECK-NEXT:    [[TMP21:%.*]] = and i64 [[TMP47]], 7
; CHECK-NEXT:    [[TMP22:%.*]] = trunc i64 [[TMP21]] to i8
; CHECK-NEXT:    [[TMP23:%.*]] = icmp sge i8 [[TMP22]], [[TMP19]]
; CHECK-NEXT:    [[TMP24:%.*]] = and i1 [[TMP20]], [[TMP23]]
; CHECK-NEXT:    [[TMP25:%.*]] = call i64 @llvm.amdgcn.ballot.i64(i1 [[TMP24]])
; CHECK-NEXT:    [[TMP26:%.*]] = icmp ne i64 [[TMP25]], 0
; CHECK-NEXT:    br i1 [[TMP26]], label [[ASAN_REPORT:%.*]], label [[TMP29:%.*]], !prof [[PROF3:![0-9]+]]
; CHECK:       asan.report:
; CHECK-NEXT:    br i1 [[TMP24]], label [[TMP27:%.*]], label [[TMP28:%.*]]
; CHECK:       27:
; CHECK-NEXT:    call void @__asan_report_store1(i64 [[TMP47]]) #[[ATTR7:[0-9]+]]
; CHECK-NEXT:    call void @llvm.amdgcn.unreachable()
; CHECK-NEXT:    br label [[TMP28]]
; CHECK:       28:
; CHECK-NEXT:    br label [[TMP29]]
; CHECK:       29:
; CHECK-NEXT:    store i8 3, ptr addrspace(1) [[TMP14]], align 4
; CHECK-NEXT:    [[TMP30:%.*]] = ptrtoint ptr addrspace(3) [[TMP15]] to i32
; CHECK-NEXT:    [[TMP31:%.*]] = getelementptr inbounds i8, ptr addrspace(1) [[TMP7]], i32 [[TMP30]]
; CHECK-NEXT:    [[TMP32:%.*]] = ptrtoint ptr addrspace(1) [[TMP31]] to i64
; CHECK-NEXT:    [[TMP33:%.*]] = lshr i64 [[TMP32]], 3
; CHECK-NEXT:    [[TMP34:%.*]] = add i64 [[TMP33]], 2147450880
; CHECK-NEXT:    [[TMP35:%.*]] = inttoptr i64 [[TMP34]] to ptr
; CHECK-NEXT:    [[TMP36:%.*]] = load i8, ptr [[TMP35]], align 1
; CHECK-NEXT:    [[TMP37:%.*]] = icmp ne i8 [[TMP36]], 0
; CHECK-NEXT:    [[TMP38:%.*]] = and i64 [[TMP32]], 7
; CHECK-NEXT:    [[TMP39:%.*]] = trunc i64 [[TMP38]] to i8
; CHECK-NEXT:    [[TMP40:%.*]] = icmp sge i8 [[TMP39]], [[TMP36]]
; CHECK-NEXT:    [[TMP41:%.*]] = and i1 [[TMP37]], [[TMP40]]
; CHECK-NEXT:    [[TMP42:%.*]] = call i64 @llvm.amdgcn.ballot.i64(i1 [[TMP41]])
; CHECK-NEXT:    [[TMP43:%.*]] = icmp ne i64 [[TMP42]], 0
; CHECK-NEXT:    br i1 [[TMP43]], label [[ASAN_REPORT1:%.*]], label [[TMP46:%.*]], !prof [[PROF3]]
; CHECK:       asan.report1:
; CHECK-NEXT:    br i1 [[TMP41]], label [[TMP44:%.*]], label [[TMP45:%.*]]
; CHECK:       44:
; CHECK-NEXT:    call void @__asan_report_store1(i64 [[TMP32]]) #[[ATTR7]]
; CHECK-NEXT:    call void @llvm.amdgcn.unreachable()
; CHECK-NEXT:    br label [[TMP45]]
; CHECK:       45:
; CHECK-NEXT:    br label [[TMP46]]
; CHECK:       46:
; CHECK-NEXT:    store i8 3, ptr addrspace(1) [[TMP31]], align 8
; CHECK-NEXT:    ret void
;
  store i8 3, ptr addrspace(3) @lds_3, align 4
  store i8 3, ptr addrspace(3) @lds_4, align 8
  ret void
}

define amdgpu_kernel void @k0() sanitize_address {
; CHECK-LABEL: define amdgpu_kernel void @k0(
; CHECK-SAME: ) #[[ATTR1:[0-9]+]] !llvm.amdgcn.lds.kernel.id [[META4:![0-9]+]] {
; CHECK-NEXT:  WId:
; CHECK-NEXT:    [[TMP0:%.*]] = call i32 @llvm.amdgcn.workitem.id.x()
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.amdgcn.workitem.id.y()
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @llvm.amdgcn.workitem.id.z()
; CHECK-NEXT:    [[TMP3:%.*]] = or i32 [[TMP0]], [[TMP1]]
; CHECK-NEXT:    [[TMP4:%.*]] = or i32 [[TMP3]], [[TMP2]]
; CHECK-NEXT:    [[TMP5:%.*]] = icmp eq i32 [[TMP4]], 0
; CHECK-NEXT:    br i1 [[TMP5]], label [[MALLOC:%.*]], label [[TMP21:%.*]]
; CHECK:       Malloc:
; CHECK-NEXT:    [[TMP9:%.*]] = load i32, ptr addrspace(1) getelementptr inbounds ([[LLVM_AMDGCN_SW_LDS_K0_MD_TYPE:%.*]], ptr addrspace(1) @llvm.amdgcn.sw.lds.k0.md, i32 0, i32 2, i32 0), align 4
; CHECK-NEXT:    [[TMP7:%.*]] = load i32, ptr addrspace(1) getelementptr inbounds ([[LLVM_AMDGCN_SW_LDS_K0_MD_TYPE]], ptr addrspace(1) @llvm.amdgcn.sw.lds.k0.md, i32 0, i32 2, i32 2), align 4
; CHECK-NEXT:    [[TMP8:%.*]] = add i32 [[TMP9]], [[TMP7]]
; CHECK-NEXT:    [[TMP6:%.*]] = call ptr addrspace(4) @llvm.amdgcn.implicitarg.ptr()
; CHECK-NEXT:    [[TMP10:%.*]] = getelementptr inbounds ptr addrspace(4), ptr addrspace(4) [[TMP6]], i64 15
; CHECK-NEXT:    store i32 [[TMP8]], ptr addrspace(1) getelementptr inbounds ([[LLVM_AMDGCN_SW_LDS_K0_MD_TYPE]], ptr addrspace(1) @llvm.amdgcn.sw.lds.k0.md, i32 0, i32 3, i32 0), align 4
; CHECK-NEXT:    [[TMP11:%.*]] = load i32, ptr addrspace(4) [[TMP10]], align 4
; CHECK-NEXT:    store i32 [[TMP11]], ptr addrspace(1) getelementptr inbounds ([[LLVM_AMDGCN_SW_LDS_K0_MD_TYPE]], ptr addrspace(1) @llvm.amdgcn.sw.lds.k0.md, i32 0, i32 3, i32 1), align 4
; CHECK-NEXT:    [[TMP12:%.*]] = add i32 [[TMP11]], 7
; CHECK-NEXT:    [[TMP13:%.*]] = udiv i32 [[TMP12]], 8
; CHECK-NEXT:    [[TMP14:%.*]] = mul i32 [[TMP13]], 8
; CHECK-NEXT:    store i32 [[TMP14]], ptr addrspace(1) getelementptr inbounds ([[LLVM_AMDGCN_SW_LDS_K0_MD_TYPE]], ptr addrspace(1) @llvm.amdgcn.sw.lds.k0.md, i32 0, i32 3, i32 2), align 4
; CHECK-NEXT:    [[TMP15:%.*]] = add i32 [[TMP8]], [[TMP14]]
; CHECK-NEXT:    store i32 [[TMP15]], ptr addrspace(1) getelementptr inbounds ([[LLVM_AMDGCN_SW_LDS_K0_MD_TYPE]], ptr addrspace(1) @llvm.amdgcn.sw.lds.k0.md, i32 0, i32 4, i32 0), align 4
; CHECK-NEXT:    [[TMP27:%.*]] = load i32, ptr addrspace(4) [[TMP10]], align 4
; CHECK-NEXT:    store i32 [[TMP27]], ptr addrspace(1) getelementptr inbounds ([[LLVM_AMDGCN_SW_LDS_K0_MD_TYPE]], ptr addrspace(1) @llvm.amdgcn.sw.lds.k0.md, i32 0, i32 4, i32 1), align 4
; CHECK-NEXT:    [[TMP17:%.*]] = add i32 [[TMP27]], 7
; CHECK-NEXT:    [[TMP18:%.*]] = udiv i32 [[TMP17]], 8
; CHECK-NEXT:    [[TMP19:%.*]] = mul i32 [[TMP18]], 8
; CHECK-NEXT:    store i32 [[TMP19]], ptr addrspace(1) getelementptr inbounds ([[LLVM_AMDGCN_SW_LDS_K0_MD_TYPE]], ptr addrspace(1) @llvm.amdgcn.sw.lds.k0.md, i32 0, i32 4, i32 2), align 4
; CHECK-NEXT:    [[TMP28:%.*]] = add i32 [[TMP15]], [[TMP19]]
; CHECK-NEXT:    [[TMP26:%.*]] = zext i32 [[TMP28]] to i64
; CHECK-NEXT:    [[TMP22:%.*]] = call ptr @llvm.returnaddress(i32 0)
; CHECK-NEXT:    [[TMP23:%.*]] = ptrtoint ptr [[TMP22]] to i64
; CHECK-NEXT:    [[TMP35:%.*]] = call i64 @__asan_malloc_impl(i64 [[TMP26]], i64 [[TMP23]])
; CHECK-NEXT:    [[TMP20:%.*]] = inttoptr i64 [[TMP35]] to ptr addrspace(1)
; CHECK-NEXT:    store ptr addrspace(1) [[TMP20]], ptr addrspace(3) @llvm.amdgcn.sw.lds.k0, align 8
; CHECK-NEXT:    [[TMP36:%.*]] = getelementptr inbounds i8, ptr addrspace(1) [[TMP20]], i64 8
; CHECK-NEXT:    [[TMP37:%.*]] = ptrtoint ptr addrspace(1) [[TMP36]] to i64
; CHECK-NEXT:    call void @__asan_poison_region(i64 [[TMP37]], i64 24)
; CHECK-NEXT:    [[TMP53:%.*]] = getelementptr inbounds i8, ptr addrspace(1) [[TMP20]], i64 33
; CHECK-NEXT:    [[TMP73:%.*]] = ptrtoint ptr addrspace(1) [[TMP53]] to i64
; CHECK-NEXT:    call void @__asan_poison_region(i64 [[TMP73]], i64 31)
; CHECK-NEXT:    [[TMP74:%.*]] = getelementptr inbounds i8, ptr addrspace(1) [[TMP20]], i64 68
; CHECK-NEXT:    [[TMP75:%.*]] = ptrtoint ptr addrspace(1) [[TMP74]] to i64
; CHECK-NEXT:    call void @__asan_poison_region(i64 [[TMP75]], i64 28)
; CHECK-NEXT:    br label [[TMP21]]
; CHECK:       32:
; CHECK-NEXT:    [[XYZCOND:%.*]] = phi i1 [ false, [[WID:%.*]] ], [ true, [[MALLOC]] ]
; CHECK-NEXT:    call void @llvm.amdgcn.s.barrier()
; CHECK-NEXT:    [[TMP31:%.*]] = load ptr addrspace(1), ptr addrspace(3) @llvm.amdgcn.sw.lds.k0, align 8
; CHECK-NEXT:    [[TMP24:%.*]] = load i32, ptr addrspace(1) getelementptr inbounds ([[LLVM_AMDGCN_SW_LDS_K0_MD_TYPE]], ptr addrspace(1) @llvm.amdgcn.sw.lds.k0.md, i32 0, i32 1, i32 0), align 4
; CHECK-NEXT:    [[TMP25:%.*]] = getelementptr inbounds i8, ptr addrspace(3) @llvm.amdgcn.sw.lds.k0, i32 [[TMP24]]
; CHECK-NEXT:    [[TMP29:%.*]] = load i32, ptr addrspace(1) getelementptr inbounds ([[LLVM_AMDGCN_SW_LDS_K0_MD_TYPE]], ptr addrspace(1) @llvm.amdgcn.sw.lds.k0.md, i32 0, i32 2, i32 0), align 4
; CHECK-NEXT:    [[TMP30:%.*]] = getelementptr inbounds i8, ptr addrspace(3) @llvm.amdgcn.sw.lds.k0, i32 [[TMP29]]
; CHECK-NEXT:    call void @llvm.donothing() [ "ExplicitUse"(ptr addrspace(3) @llvm.amdgcn.k0.dynlds) ]
; CHECK-NEXT:    call void @use_variables()
; CHECK-NEXT:    [[TMP38:%.*]] = ptrtoint ptr addrspace(3) [[TMP25]] to i32
; CHECK-NEXT:    [[TMP39:%.*]] = getelementptr inbounds i8, ptr addrspace(1) [[TMP31]], i32 [[TMP38]]
; CHECK-NEXT:    [[TMP40:%.*]] = ptrtoint ptr addrspace(1) [[TMP39]] to i64
; CHECK-NEXT:    [[TMP41:%.*]] = lshr i64 [[TMP40]], 3
; CHECK-NEXT:    [[TMP42:%.*]] = add i64 [[TMP41]], 2147450880
; CHECK-NEXT:    [[TMP43:%.*]] = inttoptr i64 [[TMP42]] to ptr
; CHECK-NEXT:    [[TMP44:%.*]] = load i8, ptr [[TMP43]], align 1
; CHECK-NEXT:    [[TMP45:%.*]] = icmp ne i8 [[TMP44]], 0
; CHECK-NEXT:    [[TMP46:%.*]] = and i64 [[TMP40]], 7
; CHECK-NEXT:    [[TMP47:%.*]] = trunc i64 [[TMP46]] to i8
; CHECK-NEXT:    [[TMP48:%.*]] = icmp sge i8 [[TMP47]], [[TMP44]]
; CHECK-NEXT:    [[TMP49:%.*]] = and i1 [[TMP45]], [[TMP48]]
; CHECK-NEXT:    [[TMP50:%.*]] = call i64 @llvm.amdgcn.ballot.i64(i1 [[TMP49]])
; CHECK-NEXT:    [[TMP51:%.*]] = icmp ne i64 [[TMP50]], 0
; CHECK-NEXT:    br i1 [[TMP51]], label [[ASAN_REPORT:%.*]], label [[TMP54:%.*]], !prof [[PROF3]]
; CHECK:       asan.report:
; CHECK-NEXT:    br i1 [[TMP49]], label [[TMP52:%.*]], label [[CONDFREE:%.*]]
; CHECK:       52:
; CHECK-NEXT:    call void @__asan_report_store1(i64 [[TMP40]]) #[[ATTR7]]
; CHECK-NEXT:    call void @llvm.amdgcn.unreachable()
; CHECK-NEXT:    br label [[CONDFREE]]
; CHECK:       53:
; CHECK-NEXT:    br label [[TMP54]]
; CHECK:       54:
; CHECK-NEXT:    store i8 7, ptr addrspace(1) [[TMP39]], align 1
; CHECK-NEXT:    [[TMP55:%.*]] = ptrtoint ptr addrspace(3) [[TMP30]] to i32
; CHECK-NEXT:    [[TMP56:%.*]] = getelementptr inbounds i8, ptr addrspace(1) [[TMP31]], i32 [[TMP55]]
; CHECK-NEXT:    [[TMP57:%.*]] = ptrtoint ptr addrspace(1) [[TMP56]] to i64
; CHECK-NEXT:    [[TMP63:%.*]] = add i64 [[TMP57]], 3
; CHECK-NEXT:    [[TMP90:%.*]] = inttoptr i64 [[TMP63]] to ptr addrspace(1)
; CHECK-NEXT:    [[TMP91:%.*]] = ptrtoint ptr addrspace(1) [[TMP56]] to i64
; CHECK-NEXT:    [[TMP58:%.*]] = lshr i64 [[TMP91]], 3
; CHECK-NEXT:    [[TMP59:%.*]] = add i64 [[TMP58]], 2147450880
; CHECK-NEXT:    [[TMP60:%.*]] = inttoptr i64 [[TMP59]] to ptr
; CHECK-NEXT:    [[TMP61:%.*]] = load i8, ptr [[TMP60]], align 1
; CHECK-NEXT:    [[TMP62:%.*]] = icmp ne i8 [[TMP61]], 0
; CHECK-NEXT:    [[TMP64:%.*]] = and i64 [[TMP91]], 7
; CHECK-NEXT:    [[TMP65:%.*]] = trunc i64 [[TMP64]] to i8
; CHECK-NEXT:    [[TMP66:%.*]] = icmp sge i8 [[TMP65]], [[TMP61]]
; CHECK-NEXT:    [[TMP67:%.*]] = and i1 [[TMP62]], [[TMP66]]
; CHECK-NEXT:    [[TMP68:%.*]] = call i64 @llvm.amdgcn.ballot.i64(i1 [[TMP67]])
; CHECK-NEXT:    [[TMP69:%.*]] = icmp ne i64 [[TMP68]], 0
; CHECK-NEXT:    br i1 [[TMP69]], label [[ASAN_REPORT1:%.*]], label [[TMP72:%.*]], !prof [[PROF3]]
; CHECK:       asan.report1:
; CHECK-NEXT:    br i1 [[TMP67]], label [[TMP70:%.*]], label [[TMP71:%.*]]
; CHECK:       72:
; CHECK-NEXT:    call void @__asan_report_store1(i64 [[TMP91]]) #[[ATTR7]]
; CHECK-NEXT:    call void @llvm.amdgcn.unreachable()
; CHECK-NEXT:    br label [[TMP71]]
; CHECK:       73:
; CHECK-NEXT:    br label [[TMP72]]
; CHECK:       74:
; CHECK-NEXT:    [[TMP92:%.*]] = ptrtoint ptr addrspace(1) [[TMP90]] to i64
; CHECK-NEXT:    [[TMP76:%.*]] = lshr i64 [[TMP92]], 3
; CHECK-NEXT:    [[TMP77:%.*]] = add i64 [[TMP76]], 2147450880
; CHECK-NEXT:    [[TMP78:%.*]] = inttoptr i64 [[TMP77]] to ptr
; CHECK-NEXT:    [[TMP79:%.*]] = load i8, ptr [[TMP78]], align 1
; CHECK-NEXT:    [[TMP80:%.*]] = icmp ne i8 [[TMP79]], 0
; CHECK-NEXT:    [[TMP81:%.*]] = and i64 [[TMP92]], 7
; CHECK-NEXT:    [[TMP82:%.*]] = trunc i64 [[TMP81]] to i8
; CHECK-NEXT:    [[TMP83:%.*]] = icmp sge i8 [[TMP82]], [[TMP79]]
; CHECK-NEXT:    [[TMP84:%.*]] = and i1 [[TMP80]], [[TMP83]]
; CHECK-NEXT:    [[TMP85:%.*]] = call i64 @llvm.amdgcn.ballot.i64(i1 [[TMP84]])
; CHECK-NEXT:    [[TMP86:%.*]] = icmp ne i64 [[TMP85]], 0
; CHECK-NEXT:    br i1 [[TMP86]], label [[ASAN_REPORT2:%.*]], label [[TMP89:%.*]], !prof [[PROF3]]
; CHECK:       asan.report2:
; CHECK-NEXT:    br i1 [[TMP84]], label [[TMP87:%.*]], label [[TMP88:%.*]]
; CHECK:       87:
; CHECK-NEXT:    call void @__asan_report_store1(i64 [[TMP92]]) #[[ATTR7]]
; CHECK-NEXT:    call void @llvm.amdgcn.unreachable()
; CHECK-NEXT:    br label [[TMP88]]
; CHECK:       88:
; CHECK-NEXT:    br label [[TMP89]]
; CHECK:       89:
; CHECK-NEXT:    store i32 8, ptr addrspace(1) [[TMP56]], align 2
; CHECK-NEXT:    br label [[CONDFREE1:%.*]]
; CHECK:       CondFree:
; CHECK-NEXT:    call void @llvm.amdgcn.s.barrier()
; CHECK-NEXT:    br i1 [[XYZCOND]], label [[FREE:%.*]], label [[END:%.*]]
; CHECK:       Free:
; CHECK-NEXT:    [[TMP32:%.*]] = call ptr @llvm.returnaddress(i32 0)
; CHECK-NEXT:    [[TMP33:%.*]] = ptrtoint ptr [[TMP32]] to i64
; CHECK-NEXT:    [[TMP34:%.*]] = ptrtoint ptr addrspace(1) [[TMP31]] to i64
; CHECK-NEXT:    call void @__asan_free_impl(i64 [[TMP34]], i64 [[TMP33]])
; CHECK-NEXT:    br label [[END]]
; CHECK:       End:
; CHECK-NEXT:    ret void
;
  call void @use_variables()
  store i8 7, ptr addrspace(3) @lds_1, align 1
  store i32 8, ptr addrspace(3) @lds_2, align 2
  ret void
}

!llvm.module.flags = !{!0}
!0 = !{i32 4, !"nosanitize_address", i32 1}

;.
; CHECK: attributes #[[ATTR0]] = { sanitize_address }
; CHECK: attributes #[[ATTR1]] = { sanitize_address "amdgpu-lds-size"="8,8" }
; CHECK: attributes #[[ATTR2:[0-9]+]] = { nocallback nofree nosync nounwind willreturn memory(none) }
; CHECK: attributes #[[ATTR3:[0-9]+]] = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
; CHECK: attributes #[[ATTR4:[0-9]+]] = { convergent nocallback nofree nounwind willreturn }
; CHECK: attributes #[[ATTR5:[0-9]+]] = { convergent nocallback nofree nounwind willreturn memory(none) }
; CHECK: attributes #[[ATTR6:[0-9]+]] = { convergent nocallback nofree nounwind }
; CHECK: attributes #[[ATTR7]] = { nomerge }
;.
; CHECK: [[META0]] = !{i32 0, i32 1}
; CHECK: [[META1]] = !{i32 8, i32 9}
; CHECK: [[META2:![0-9]+]] = !{i32 4, !"nosanitize_address", i32 1}
; CHECK: [[PROF3]] = !{!"branch_weights", i32 1, i32 1048575}
; CHECK: [[META4]] = !{i32 0}
;.