; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt -S --passes=slp-vectorizer < %s | FileCheck %s

define i32 @test(i8 %0) {
; CHECK-LABEL: define i32 @test(
; CHECK-SAME: i8 [[TMP0:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[CMP13_NOT_5:%.*]] = icmp eq i64 0, 0
; CHECK-NEXT:    [[TMP1:%.*]] = load i8, ptr addrspace(21) getelementptr inbounds (i8, ptr addrspace(21) null, i64 7), align 1
; CHECK-NEXT:    [[TMP2:%.*]] = insertelement <2 x i8> <i8 0, i8 poison>, i8 [[TMP1]], i32 1
; CHECK-NEXT:    [[TMP3:%.*]] = icmp eq <2 x i8> zeroinitializer, [[TMP2]]
; CHECK-NEXT:    [[TMP4:%.*]] = load volatile i8, ptr null, align 8
; CHECK-NEXT:    [[TMP5:%.*]] = load <2 x i8>, ptr addrspace(21) getelementptr inbounds (i8, ptr addrspace(21) null, i64 8), align 8
; CHECK-NEXT:    [[TMP6:%.*]] = shufflevector <2 x i8> [[TMP5]], <2 x i8> poison, <8 x i32> <i32 0, i32 1, i32 0, i32 poison, i32 poison, i32 1, i32 poison, i32 poison>
; CHECK-NEXT:    [[TMP7:%.*]] = shufflevector <8 x i8> [[TMP6]], <8 x i8> <i8 0, i8 0, i8 poison, i8 0, i8 0, i8 poison, i8 0, i8 0>, <8 x i32> <i32 8, i32 9, i32 0, i32 11, i32 12, i32 1, i32 14, i32 15>
; CHECK-NEXT:    [[TMP8:%.*]] = icmp eq <8 x i8> zeroinitializer, [[TMP7]]
; CHECK-NEXT:    [[TEST_STRUCTCOPY_14_S14_CM_COERCE_SROA_2_0_COPYLOAD:%.*]] = load i48, ptr addrspace(21) getelementptr inbounds (i8, ptr addrspace(21) null, i64 8), align 8
; CHECK-NEXT:    [[TMP9:%.*]] = insertelement <4 x i48> <i48 poison, i48 0, i48 0, i48 0>, i48 [[TEST_STRUCTCOPY_14_S14_CM_COERCE_SROA_2_0_COPYLOAD]], i32 0
; CHECK-NEXT:    [[TMP10:%.*]] = trunc <4 x i48> [[TMP9]] to <4 x i8>
; CHECK-NEXT:    [[TMP11:%.*]] = icmp eq <4 x i8> zeroinitializer, [[TMP10]]
; CHECK-NEXT:    [[TMP12:%.*]] = load i8, ptr addrspace(21) null, align 2
; CHECK-NEXT:    [[TMP13:%.*]] = load volatile i8, ptr null, align 2
; CHECK-NEXT:    [[TMP14:%.*]] = load <2 x i8>, ptr addrspace(21) getelementptr inbounds (i8, ptr addrspace(21) null, i64 8), align 8
; CHECK-NEXT:    [[TMP15:%.*]] = shufflevector <2 x i8> [[TMP14]], <2 x i8> poison, <8 x i32> <i32 poison, i32 poison, i32 poison, i32 0, i32 1, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    [[TMP16:%.*]] = shufflevector <8 x i8> [[TMP15]], <8 x i8> <i8 0, i8 poison, i8 0, i8 poison, i8 poison, i8 0, i8 0, i8 0>, <8 x i32> <i32 8, i32 poison, i32 10, i32 3, i32 4, i32 13, i32 14, i32 15>
; CHECK-NEXT:    [[TMP17:%.*]] = insertelement <8 x i8> [[TMP16]], i8 [[TMP12]], i32 1
; CHECK-NEXT:    [[TMP18:%.*]] = insertelement <8 x i8> <i8 0, i8 poison, i8 0, i8 poison, i8 0, i8 0, i8 0, i8 0>, i8 [[TMP0]], i32 3
; CHECK-NEXT:    [[TMP19:%.*]] = insertelement <8 x i8> [[TMP18]], i8 [[TMP13]], i32 1
; CHECK-NEXT:    [[TMP20:%.*]] = icmp eq <8 x i8> [[TMP17]], [[TMP19]]
; CHECK-NEXT:    [[TMP21:%.*]] = insertelement <64 x i1> <i1 poison, i1 false, i1 false, i1 false, i1 false, i1 false, i1 poison, i1 poison, i1 poison, i1 poison, i1 poison, i1 poison, i1 poison, i1 poison, i1 poison, i1 poison, i1 false, i1 false, i1 false, i1 false, i1 false, i1 false, i1 false, i1 false, i1 false, i1 false, i1 false, i1 false, i1 false, i1 false, i1 false, i1 false, i1 poison, i1 poison, i1 poison, i1 poison, i1 false, i1 false, i1 false, i1 false, i1 false, i1 false, i1 false, i1 false, i1 false, i1 false, i1 false, i1 false, i1 false, i1 false, i1 false, i1 false, i1 false, i1 false, i1 false, i1 false, i1 poison, i1 poison, i1 poison, i1 poison, i1 poison, i1 poison, i1 poison, i1 poison>, i1 [[CMP13_NOT_5]], i32 0
; CHECK-NEXT:    [[TMP22:%.*]] = call <64 x i1> @llvm.vector.insert.v64i1.v8i1(<64 x i1> [[TMP21]], <8 x i1> [[TMP8]], i64 8)
; CHECK-NEXT:    [[TMP23:%.*]] = call <64 x i1> @llvm.vector.insert.v64i1.v8i1(<64 x i1> [[TMP22]], <8 x i1> [[TMP20]], i64 56)
; CHECK-NEXT:    [[TMP24:%.*]] = call <64 x i1> @llvm.vector.insert.v64i1.v4i1(<64 x i1> [[TMP23]], <4 x i1> [[TMP11]], i64 32)
; CHECK-NEXT:    [[TMP25:%.*]] = call <64 x i1> @llvm.vector.insert.v64i1.v2i1(<64 x i1> [[TMP24]], <2 x i1> [[TMP3]], i64 6)
; CHECK-NEXT:    [[TMP26:%.*]] = select <64 x i1> [[TMP25]], <64 x i32> zeroinitializer, <64 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP27:%.*]] = call i32 @llvm.vector.reduce.or.v64i32(<64 x i32> [[TMP26]])
; CHECK-NEXT:    ret i32 [[TMP27]]
;
entry:
  %cmp13.not.5 = icmp eq i64 0, 0
  %add15.5 = select i1 %cmp13.not.5, i32 0, i32 0
  %add26.5 = select i1 false, i32 0, i32 0
  %add27.5 = or i32 %add15.5, %add26.5
  %add37.5 = select i1 false, i32 0, i32 0
  %add38.5 = or i32 %add27.5, %add37.5
  %add15.6 = select i1 false, i32 0, i32 0
  %add16.6 = or i32 %add15.6, %add38.5
  %add37.6 = select i1 false, i32 0, i32 0
  %add38.6 = or i32 %add16.6, %add37.6
  %add15.7 = select i1 false, i32 0, i32 0
  %add16.7 = or i32 %add15.7, %add38.6
  %cmp23.not.7 = icmp eq i8 0, 0
  %add26.7 = select i1 %cmp23.not.7, i32 0, i32 0
  %add27.7 = or i32 %add16.7, %add26.7
  %1 = load i8, ptr addrspace(21) getelementptr inbounds (i8, ptr addrspace(21) null, i64 7), align 1
  %cmp34.not.7 = icmp eq i8 %1, 0
  %add37.7 = select i1 %cmp34.not.7, i32 0, i32 0
  %add38.7 = or i32 %add27.7, %add37.7
  %cmp13.not.8 = icmp eq i8 0, 0
  %add15.8 = select i1 %cmp13.not.8, i32 0, i32 0
  %add16.8 = or i32 %add15.8, %add38.7
  %2 = load volatile i8, ptr null, align 8
  %cmp23.not.8 = icmp eq i8 0, 0
  %add26.8 = select i1 %cmp23.not.8, i32 0, i32 0
  %add27.8 = or i32 %add16.8, %add26.8
  %3 = load i8, ptr addrspace(21) getelementptr inbounds (i8, ptr addrspace(21) null, i64 8), align 8
  %cmp34.not.8 = icmp eq i8 %3, 0
  %add37.8 = select i1 %cmp34.not.8, i32 0, i32 0
  %add38.8 = or i32 %add27.8, %add37.8
  %cmp13.not.9 = icmp eq i8 0, 0
  %add15.9 = select i1 %cmp13.not.9, i32 0, i32 0
  %add16.9 = or i32 %add15.9, %add38.8
  %cmp23.not.9 = icmp eq i8 0, 0
  %add26.9 = select i1 %cmp23.not.9, i32 0, i32 0
  %add27.9 = or i32 %add16.9, %add26.9
  %4 = load i8, ptr addrspace(21) getelementptr inbounds (i8, ptr addrspace(21) null, i64 9), align 1
  %cmp34.not.9 = icmp eq i8 %4, 0
  %add37.9 = select i1 %cmp34.not.9, i32 0, i32 0
  %add38.9 = or i32 %add27.9, %add37.9
  %cmp13.not.10 = icmp eq i8 0, 0
  %add15.10 = select i1 %cmp13.not.10, i32 0, i32 0
  %add16.10 = or i32 %add15.10, %add38.9
  %cmp23.not.10 = icmp eq i8 0, 0
  %add26.10 = select i1 %cmp23.not.10, i32 0, i32 0
  %add27.10 = or i32 %add16.10, %add26.10
  %add37.10 = select i1 false, i32 0, i32 0
  %add38.10 = or i32 %add27.10, %add37.10
  %add15.11 = select i1 false, i32 0, i32 0
  %add16.11 = or i32 %add15.11, %add38.10
  %add26.11 = select i1 false, i32 0, i32 0
  %add27.11 = or i32 %add16.11, %add26.11
  %add37.11 = select i1 false, i32 0, i32 0
  %add38.11 = or i32 %add27.11, %add37.11
  %add15.12 = select i1 false, i32 0, i32 0
  %add16.12 = or i32 %add15.12, %add38.11
  %add26.12 = select i1 false, i32 0, i32 0
  %add27.12 = or i32 %add16.12, %add26.12
  %add37.12 = select i1 false, i32 0, i32 0
  %add38.12 = or i32 %add27.12, %add37.12
  %add15.13 = select i1 false, i32 0, i32 0
  %add16.13 = or i32 %add15.13, %add38.12
  %add26.13 = select i1 false, i32 0, i32 0
  %add27.13 = or i32 %add16.13, %add26.13
  %add37.13 = select i1 false, i32 0, i32 0
  %add38.13 = or i32 %add27.13, %add37.13
  %test_structcopy_14.s14_cm.coerce.sroa.2.0.copyload = load i48, ptr addrspace(21) getelementptr inbounds (i8, ptr addrspace(21) null, i64 8), align 8
  %s.sroa.9.8.extract.trunc.i198 = trunc i48 %test_structcopy_14.s14_cm.coerce.sroa.2.0.copyload to i8
  %s.sroa.11.8.extract.trunc.i200 = trunc i48 0 to i8
  %s.sroa.12.8.extract.trunc.i202 = trunc i48 0 to i8
  %s.sroa.13.8.extract.trunc.i204 = trunc i48 0 to i8
  %add.i210 = select i1 false, i32 0, i32 0
  %add6.i211 = or i32 %add.i210, %add38.13
  %add.1.i213 = select i1 false, i32 0, i32 0
  %add6.1.i214 = or i32 %add6.i211, %add.1.i213
  %add.2.i216 = select i1 false, i32 0, i32 0
  %add6.2.i217 = or i32 %add6.1.i214, %add.2.i216
  %add.4.i222 = select i1 false, i32 0, i32 0
  %add6.4.i223 = or i32 %add6.2.i217, %add.4.i222
  %add.5.i225 = select i1 false, i32 0, i32 0
  %add6.5.i226 = or i32 %add6.4.i223, %add.5.i225
  %add.7.i231 = select i1 false, i32 0, i32 0
  %add6.7.i232 = or i32 %add6.5.i226, %add.7.i231
  %cmp4.not.8.i233 = icmp eq i8 0, %s.sroa.9.8.extract.trunc.i198
  %add.8.i234 = select i1 %cmp4.not.8.i233, i32 0, i32 0
  %add6.8.i235 = or i32 %add6.7.i232, %add.8.i234
  %cmp4.not.9.i236 = icmp eq i8 0, %s.sroa.11.8.extract.trunc.i200
  %add.9.i237 = select i1 %cmp4.not.9.i236, i32 0, i32 0
  %add6.9.i238 = or i32 %add6.8.i235, %add.9.i237
  %cmp4.not.10.i239 = icmp eq i8 0, %s.sroa.12.8.extract.trunc.i202
  %add.10.i240 = select i1 %cmp4.not.10.i239, i32 0, i32 0
  %add6.10.i241 = or i32 %add6.9.i238, %add.10.i240
  %cmp4.not.11.i242 = icmp eq i8 0, %s.sroa.13.8.extract.trunc.i204
  %add.11.i243 = select i1 %cmp4.not.11.i242, i32 0, i32 0
  %add6.11.i244 = or i32 %add6.10.i241, %add.11.i243
  %add.12.i246 = select i1 false, i32 0, i32 0
  %add6.12.i247 = or i32 %add6.11.i244, %add.12.i246
  %add.13.i249 = select i1 false, i32 0, i32 0
  %add6.13.i250 = or i32 %add6.12.i247, %add.13.i249
  %add65 = select i1 false, i32 0, i32 0
  %add66 = or i32 %add65, %add6.13.i250
  %add65.1 = select i1 false, i32 0, i32 0
  %add66.1 = or i32 %add65.1, %add66
  %add65.2 = select i1 false, i32 0, i32 0
  %add66.2 = or i32 %add65.2, %add66.1
  %add65.3 = select i1 false, i32 0, i32 0
  %add66.3 = or i32 %add65.3, %add66.2
  %add65.4 = select i1 false, i32 0, i32 0
  %add66.4 = or i32 %add65.4, %add66.3
  %add65.5 = select i1 false, i32 0, i32 0
  %add66.5 = or i32 %add65.5, %add66.4
  %add65.6 = select i1 false, i32 0, i32 0
  %add66.6 = or i32 %add65.6, %add66.5
  %add65.7 = select i1 false, i32 0, i32 0
  %add66.7 = or i32 %add65.7, %add66.6
  %add65.8 = select i1 false, i32 0, i32 0
  %add66.8 = or i32 %add65.8, %add66.7
  %add65.9 = select i1 false, i32 0, i32 0
  %add66.9 = or i32 %add65.9, %add66.8
  %add65.10 = select i1 false, i32 0, i32 0
  %add66.10 = or i32 %add65.10, %add66.9
  %add65.11 = select i1 false, i32 0, i32 0
  %add66.11 = or i32 %add65.11, %add66.10
  %add65.12 = select i1 false, i32 0, i32 0
  %add66.12 = or i32 %add65.12, %add66.11
  %add65.13 = select i1 false, i32 0, i32 0
  %add66.13 = or i32 %add65.13, %add66.12
  %add.i254 = select i1 false, i32 0, i32 0
  %add6.i255 = or i32 %add.i254, %add66.13
  %add.1.i257 = select i1 false, i32 0, i32 0
  %add6.1.i258 = or i32 %add6.i255, %add.1.i257
  %add.2.i260 = select i1 false, i32 0, i32 0
  %add6.2.i261 = or i32 %add6.1.i258, %add.2.i260
  %add.3.i263 = select i1 false, i32 0, i32 0
  %add6.3.i264 = or i32 %add6.2.i261, %add.3.i263
  %cmp4.not.4.i265 = icmp eq i8 0, 0
  %add.4.i266 = select i1 %cmp4.not.4.i265, i32 0, i32 0
  %add6.4.i267 = or i32 %add6.3.i264, %add.4.i266
  %5 = load i8, ptr addrspace(21) null, align 2
  %6 = load volatile i8, ptr null, align 2
  %cmp4.not.6.i271 = icmp eq i8 %5, %6
  %add.6.i272 = select i1 %cmp4.not.6.i271, i32 0, i32 0
  %add6.6.i273 = or i32 %add6.4.i267, %add.6.i272
  %cmp4.not.7.i274 = icmp eq i8 0, 0
  %add.7.i275 = select i1 %cmp4.not.7.i274, i32 0, i32 0
  %add6.7.i276 = or i32 %add6.6.i273, %add.7.i275
  %7 = load i8, ptr addrspace(21) getelementptr inbounds (i8, ptr addrspace(21) null, i64 8), align 8
  %cmp4.not.8.i277 = icmp eq i8 %7, %0
  %add.8.i278 = select i1 %cmp4.not.8.i277, i32 0, i32 0
  %add6.8.i279 = or i32 %add6.7.i276, %add.8.i278
  %8 = load i8, ptr addrspace(21) getelementptr inbounds (i8, ptr addrspace(21) null, i64 9), align 1
  %cmp4.not.9.i280 = icmp eq i8 %8, 0
  %add.9.i281 = select i1 %cmp4.not.9.i280, i32 0, i32 0
  %add6.9.i282 = or i32 %add6.8.i279, %add.9.i281
  %cmp4.not.10.i283 = icmp eq i8 0, 0
  %add.10.i284 = select i1 %cmp4.not.10.i283, i32 0, i32 0
  %add6.10.i285 = or i32 %add6.9.i282, %add.10.i284
  %cmp4.not.12.i289 = icmp eq i8 0, 0
  %add.12.i290 = select i1 %cmp4.not.12.i289, i32 0, i32 0
  %add6.12.i291 = or i32 %add6.10.i285, %add.12.i290
  %cmp4.not.7.i318 = icmp eq i8 0, 0
  %add.7.i319 = select i1 %cmp4.not.7.i318, i32 0, i32 0
  %add6.7.i320 = or i32 %add6.12.i291, %add.7.i319
  ret i32 %add6.7.i320
}
