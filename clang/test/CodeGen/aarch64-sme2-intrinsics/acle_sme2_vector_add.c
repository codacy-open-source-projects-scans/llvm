// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py

// REQUIRES: aarch64-registered-target

// RUN: %clang_cc1 -fclang-abi-compat=latest -triple aarch64 -target-feature +bf16 -target-feature +sme -target-feature +sme2 -target-feature +sme-i16i64 -target-feature +sme-f64f64 -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -p mem2reg,instcombine,tailcallelim | FileCheck %s
// RUN: %clang_cc1 -fclang-abi-compat=latest -triple aarch64 -target-feature +bf16 -target-feature +sme -target-feature +sme2 -target-feature +sme-i16i64 -target-feature +sme-f64f64 -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -p mem2reg,instcombine,tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -fclang-abi-compat=latest -DSVE_OVERLOADED_FORMS -triple aarch64 -target-feature +bf16 -target-feature +sme -target-feature +sme2 -target-feature +sme-i16i64 -target-feature +sme-f64f64 -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -p mem2reg,instcombine,tailcallelim | FileCheck %s
// RUN: %clang_cc1 -fclang-abi-compat=latest -DSVE_OVERLOADED_FORMS -triple aarch64 -target-feature +bf16 -target-feature +sme -target-feature +sme2 -target-feature +sme-i16i64 -target-feature +sme-f64f64 -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -p mem2reg,instcombine,tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -fclang-abi-compat=latest -triple aarch64 -target-feature +bf16 -target-feature +sme -target-feature +sme2 -target-feature +sme-i16i64 -target-feature +sme-f64f64 -S -disable-O0-optnone -Werror -Wall -o /dev/null %s

#include <arm_sme.h>

#ifdef SVE_OVERLOADED_FORMS
// A simple used,unused... macro, long enough to represent any SVE builtin.
#define SVE_ACLE_FUNC(A1,A2_UNUSED,A3,A4_UNUSED,A5) A1##A3##A5
#else
#define SVE_ACLE_FUNC(A1,A2,A3,A4,A5) A1##A2##A3##A4##A5
#endif

//
// Multi-Single Vector
//

// x2

// CHECK-LABEL: @test_svadd_vector_single2_s8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 16 x i8>, <vscale x 16 x i8> } @llvm.aarch64.sve.add.single.x2.nxv16i8(<vscale x 16 x i8> [[ZN_COERCE0:%.*]], <vscale x 16 x i8> [[ZN_COERCE1:%.*]], <vscale x 16 x i8> [[ZM:%.*]])
// CHECK-NEXT:    ret { <vscale x 16 x i8>, <vscale x 16 x i8> } [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z28test_svadd_vector_single2_s810svint8x2_tu10__SVInt8_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 16 x i8>, <vscale x 16 x i8> } @llvm.aarch64.sve.add.single.x2.nxv16i8(<vscale x 16 x i8> [[ZN_COERCE0:%.*]], <vscale x 16 x i8> [[ZN_COERCE1:%.*]], <vscale x 16 x i8> [[ZM:%.*]])
// CPP-CHECK-NEXT:    ret { <vscale x 16 x i8>, <vscale x 16 x i8> } [[TMP0]]
//
svint8x2_t test_svadd_vector_single2_s8(svint8x2_t zn, svint8_t zm) __arm_streaming {
  return SVE_ACLE_FUNC(svadd,_single_s8_x2,,,)(zn, zm);
}

// CHECK-LABEL: @test_svadd_vector_single2_u8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 16 x i8>, <vscale x 16 x i8> } @llvm.aarch64.sve.add.single.x2.nxv16i8(<vscale x 16 x i8> [[ZN_COERCE0:%.*]], <vscale x 16 x i8> [[ZN_COERCE1:%.*]], <vscale x 16 x i8> [[ZM:%.*]])
// CHECK-NEXT:    ret { <vscale x 16 x i8>, <vscale x 16 x i8> } [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z28test_svadd_vector_single2_u811svuint8x2_tu11__SVUint8_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 16 x i8>, <vscale x 16 x i8> } @llvm.aarch64.sve.add.single.x2.nxv16i8(<vscale x 16 x i8> [[ZN_COERCE0:%.*]], <vscale x 16 x i8> [[ZN_COERCE1:%.*]], <vscale x 16 x i8> [[ZM:%.*]])
// CPP-CHECK-NEXT:    ret { <vscale x 16 x i8>, <vscale x 16 x i8> } [[TMP0]]
//
svuint8x2_t test_svadd_vector_single2_u8(svuint8x2_t zn, svuint8_t zm) __arm_streaming {
  return SVE_ACLE_FUNC(svadd,_single_u8_x2,,,)(zn, zm);
}

// CHECK-LABEL: @test_svadd_vector_single2_s16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 8 x i16>, <vscale x 8 x i16> } @llvm.aarch64.sve.add.single.x2.nxv8i16(<vscale x 8 x i16> [[ZN_COERCE0:%.*]], <vscale x 8 x i16> [[ZN_COERCE1:%.*]], <vscale x 8 x i16> [[ZM:%.*]])
// CHECK-NEXT:    ret { <vscale x 8 x i16>, <vscale x 8 x i16> } [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z29test_svadd_vector_single2_s1611svint16x2_tu11__SVInt16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 8 x i16>, <vscale x 8 x i16> } @llvm.aarch64.sve.add.single.x2.nxv8i16(<vscale x 8 x i16> [[ZN_COERCE0:%.*]], <vscale x 8 x i16> [[ZN_COERCE1:%.*]], <vscale x 8 x i16> [[ZM:%.*]])
// CPP-CHECK-NEXT:    ret { <vscale x 8 x i16>, <vscale x 8 x i16> } [[TMP0]]
//
svint16x2_t test_svadd_vector_single2_s16(svint16x2_t zn, svint16_t zm) __arm_streaming {
  return SVE_ACLE_FUNC(svadd,_single_s16_x2,,,)(zn, zm);
}

// CHECK-LABEL: @test_svadd_vector_single2_u16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 8 x i16>, <vscale x 8 x i16> } @llvm.aarch64.sve.add.single.x2.nxv8i16(<vscale x 8 x i16> [[ZN_COERCE0:%.*]], <vscale x 8 x i16> [[ZN_COERCE1:%.*]], <vscale x 8 x i16> [[ZM:%.*]])
// CHECK-NEXT:    ret { <vscale x 8 x i16>, <vscale x 8 x i16> } [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z29test_svadd_vector_single2_u1612svuint16x2_tu12__SVUint16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 8 x i16>, <vscale x 8 x i16> } @llvm.aarch64.sve.add.single.x2.nxv8i16(<vscale x 8 x i16> [[ZN_COERCE0:%.*]], <vscale x 8 x i16> [[ZN_COERCE1:%.*]], <vscale x 8 x i16> [[ZM:%.*]])
// CPP-CHECK-NEXT:    ret { <vscale x 8 x i16>, <vscale x 8 x i16> } [[TMP0]]
//
svuint16x2_t test_svadd_vector_single2_u16(svuint16x2_t zn, svuint16_t zm) __arm_streaming {
  return SVE_ACLE_FUNC(svadd,_single_u16_x2,,,)(zn, zm);
}

// CHECK-LABEL: @test_svadd_vector_single2_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.aarch64.sve.add.single.x2.nxv4i32(<vscale x 4 x i32> [[ZN_COERCE0:%.*]], <vscale x 4 x i32> [[ZN_COERCE1:%.*]], <vscale x 4 x i32> [[ZM:%.*]])
// CHECK-NEXT:    ret { <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z29test_svadd_vector_single2_s3211svint32x2_tu11__SVInt32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.aarch64.sve.add.single.x2.nxv4i32(<vscale x 4 x i32> [[ZN_COERCE0:%.*]], <vscale x 4 x i32> [[ZN_COERCE1:%.*]], <vscale x 4 x i32> [[ZM:%.*]])
// CPP-CHECK-NEXT:    ret { <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP0]]
//
svint32x2_t test_svadd_vector_single2_s32(svint32x2_t zn, svint32_t zm) __arm_streaming {
  return SVE_ACLE_FUNC(svadd,_single_s32_x2,,,)(zn, zm);
}

// CHECK-LABEL: @test_svadd_vector_single2_u32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.aarch64.sve.add.single.x2.nxv4i32(<vscale x 4 x i32> [[ZN_COERCE0:%.*]], <vscale x 4 x i32> [[ZN_COERCE1:%.*]], <vscale x 4 x i32> [[ZM:%.*]])
// CHECK-NEXT:    ret { <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z29test_svadd_vector_single2_u3212svuint32x2_tu12__SVUint32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.aarch64.sve.add.single.x2.nxv4i32(<vscale x 4 x i32> [[ZN_COERCE0:%.*]], <vscale x 4 x i32> [[ZN_COERCE1:%.*]], <vscale x 4 x i32> [[ZM:%.*]])
// CPP-CHECK-NEXT:    ret { <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP0]]
//
svuint32x2_t test_svadd_vector_single2_u32(svuint32x2_t zn, svuint32_t zm) __arm_streaming {
  return SVE_ACLE_FUNC(svadd,_single_u32_x2,,,)(zn, zm);
}

// CHECK-LABEL: @test_svadd_vector_single2_s64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.aarch64.sve.add.single.x2.nxv2i64(<vscale x 2 x i64> [[ZN_COERCE0:%.*]], <vscale x 2 x i64> [[ZN_COERCE1:%.*]], <vscale x 2 x i64> [[ZM:%.*]])
// CHECK-NEXT:    ret { <vscale x 2 x i64>, <vscale x 2 x i64> } [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z29test_svadd_vector_single2_s6411svint64x2_tu11__SVInt64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.aarch64.sve.add.single.x2.nxv2i64(<vscale x 2 x i64> [[ZN_COERCE0:%.*]], <vscale x 2 x i64> [[ZN_COERCE1:%.*]], <vscale x 2 x i64> [[ZM:%.*]])
// CPP-CHECK-NEXT:    ret { <vscale x 2 x i64>, <vscale x 2 x i64> } [[TMP0]]
//
svint64x2_t test_svadd_vector_single2_s64(svint64x2_t zn, svint64_t zm) __arm_streaming {
  return SVE_ACLE_FUNC(svadd,_single_s64_x2,,,)(zn, zm);
}

// CHECK-LABEL: @test_svadd_vector_single2_u64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.aarch64.sve.add.single.x2.nxv2i64(<vscale x 2 x i64> [[ZN_COERCE0:%.*]], <vscale x 2 x i64> [[ZN_COERCE1:%.*]], <vscale x 2 x i64> [[ZM:%.*]])
// CHECK-NEXT:    ret { <vscale x 2 x i64>, <vscale x 2 x i64> } [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z29test_svadd_vector_single2_u6412svuint64x2_tu12__SVUint64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.aarch64.sve.add.single.x2.nxv2i64(<vscale x 2 x i64> [[ZN_COERCE0:%.*]], <vscale x 2 x i64> [[ZN_COERCE1:%.*]], <vscale x 2 x i64> [[ZM:%.*]])
// CPP-CHECK-NEXT:    ret { <vscale x 2 x i64>, <vscale x 2 x i64> } [[TMP0]]
//
svuint64x2_t test_svadd_vector_single2_u64(svuint64x2_t zn, svuint64_t zm) __arm_streaming {
  return SVE_ACLE_FUNC(svadd,_single_u64_x2,,,)(zn, zm);
}


// x4

// CHECK-LABEL: @test_svadd_vector_single4_s8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } @llvm.aarch64.sve.add.single.x4.nxv16i8(<vscale x 16 x i8> [[ZN_COERCE0:%.*]], <vscale x 16 x i8> [[ZN_COERCE1:%.*]], <vscale x 16 x i8> [[ZN_COERCE2:%.*]], <vscale x 16 x i8> [[ZN_COERCE3:%.*]], <vscale x 16 x i8> [[ZM:%.*]])
// CHECK-NEXT:    ret { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z28test_svadd_vector_single4_s810svint8x4_tu10__SVInt8_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } @llvm.aarch64.sve.add.single.x4.nxv16i8(<vscale x 16 x i8> [[ZN_COERCE0:%.*]], <vscale x 16 x i8> [[ZN_COERCE1:%.*]], <vscale x 16 x i8> [[ZN_COERCE2:%.*]], <vscale x 16 x i8> [[ZN_COERCE3:%.*]], <vscale x 16 x i8> [[ZM:%.*]])
// CPP-CHECK-NEXT:    ret { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } [[TMP0]]
//
svint8x4_t test_svadd_vector_single4_s8(svint8x4_t zn, svint8_t zm) __arm_streaming {
  return SVE_ACLE_FUNC(svadd,_single_s8_x4,,,)(zn, zm);
}

// CHECK-LABEL: @test_svadd_vector_single4_u8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } @llvm.aarch64.sve.add.single.x4.nxv16i8(<vscale x 16 x i8> [[ZN_COERCE0:%.*]], <vscale x 16 x i8> [[ZN_COERCE1:%.*]], <vscale x 16 x i8> [[ZN_COERCE2:%.*]], <vscale x 16 x i8> [[ZN_COERCE3:%.*]], <vscale x 16 x i8> [[ZM:%.*]])
// CHECK-NEXT:    ret { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z28test_svadd_vector_single4_u811svuint8x4_tu11__SVUint8_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } @llvm.aarch64.sve.add.single.x4.nxv16i8(<vscale x 16 x i8> [[ZN_COERCE0:%.*]], <vscale x 16 x i8> [[ZN_COERCE1:%.*]], <vscale x 16 x i8> [[ZN_COERCE2:%.*]], <vscale x 16 x i8> [[ZN_COERCE3:%.*]], <vscale x 16 x i8> [[ZM:%.*]])
// CPP-CHECK-NEXT:    ret { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } [[TMP0]]
//
svuint8x4_t test_svadd_vector_single4_u8(svuint8x4_t zn, svuint8_t zm) __arm_streaming {
  return SVE_ACLE_FUNC(svadd,_single_u8_x4,,,)(zn, zm);
}

// CHECK-LABEL: @test_svadd_vector_single4_s16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16> } @llvm.aarch64.sve.add.single.x4.nxv8i16(<vscale x 8 x i16> [[ZN_COERCE0:%.*]], <vscale x 8 x i16> [[ZN_COERCE1:%.*]], <vscale x 8 x i16> [[ZN_COERCE2:%.*]], <vscale x 8 x i16> [[ZN_COERCE3:%.*]], <vscale x 8 x i16> [[ZM:%.*]])
// CHECK-NEXT:    ret { <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16> } [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z29test_svadd_vector_single4_s1611svint16x4_tu11__SVInt16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16> } @llvm.aarch64.sve.add.single.x4.nxv8i16(<vscale x 8 x i16> [[ZN_COERCE0:%.*]], <vscale x 8 x i16> [[ZN_COERCE1:%.*]], <vscale x 8 x i16> [[ZN_COERCE2:%.*]], <vscale x 8 x i16> [[ZN_COERCE3:%.*]], <vscale x 8 x i16> [[ZM:%.*]])
// CPP-CHECK-NEXT:    ret { <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16> } [[TMP0]]
//
svint16x4_t test_svadd_vector_single4_s16(svint16x4_t zn, svint16_t zm) __arm_streaming {
  return SVE_ACLE_FUNC(svadd,_single_s16_x4,,,)(zn, zm);
}

// CHECK-LABEL: @test_svadd_vector_single4_u16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16> } @llvm.aarch64.sve.add.single.x4.nxv8i16(<vscale x 8 x i16> [[ZN_COERCE0:%.*]], <vscale x 8 x i16> [[ZN_COERCE1:%.*]], <vscale x 8 x i16> [[ZN_COERCE2:%.*]], <vscale x 8 x i16> [[ZN_COERCE3:%.*]], <vscale x 8 x i16> [[ZM:%.*]])
// CHECK-NEXT:    ret { <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16> } [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z29test_svadd_vector_single4_u1612svuint16x4_tu12__SVUint16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16> } @llvm.aarch64.sve.add.single.x4.nxv8i16(<vscale x 8 x i16> [[ZN_COERCE0:%.*]], <vscale x 8 x i16> [[ZN_COERCE1:%.*]], <vscale x 8 x i16> [[ZN_COERCE2:%.*]], <vscale x 8 x i16> [[ZN_COERCE3:%.*]], <vscale x 8 x i16> [[ZM:%.*]])
// CPP-CHECK-NEXT:    ret { <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16> } [[TMP0]]
//
svuint16x4_t test_svadd_vector_single4_u16(svuint16x4_t zn, svuint16_t zm) __arm_streaming {
  return SVE_ACLE_FUNC(svadd,_single_u16_x4,,,)(zn, zm);
}

// CHECK-LABEL: @test_svadd_vector_single4_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.aarch64.sve.add.single.x4.nxv4i32(<vscale x 4 x i32> [[ZN_COERCE0:%.*]], <vscale x 4 x i32> [[ZN_COERCE1:%.*]], <vscale x 4 x i32> [[ZN_COERCE2:%.*]], <vscale x 4 x i32> [[ZN_COERCE3:%.*]], <vscale x 4 x i32> [[ZM:%.*]])
// CHECK-NEXT:    ret { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z29test_svadd_vector_single4_s3211svint32x4_tu11__SVInt32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.aarch64.sve.add.single.x4.nxv4i32(<vscale x 4 x i32> [[ZN_COERCE0:%.*]], <vscale x 4 x i32> [[ZN_COERCE1:%.*]], <vscale x 4 x i32> [[ZN_COERCE2:%.*]], <vscale x 4 x i32> [[ZN_COERCE3:%.*]], <vscale x 4 x i32> [[ZM:%.*]])
// CPP-CHECK-NEXT:    ret { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP0]]
//
svint32x4_t test_svadd_vector_single4_s32(svint32x4_t zn, svint32_t zm) __arm_streaming {
  return SVE_ACLE_FUNC(svadd,_single_s32_x4,,,)(zn, zm);
}

// CHECK-LABEL: @test_svadd_vector_single4_u32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.aarch64.sve.add.single.x4.nxv4i32(<vscale x 4 x i32> [[ZN_COERCE0:%.*]], <vscale x 4 x i32> [[ZN_COERCE1:%.*]], <vscale x 4 x i32> [[ZN_COERCE2:%.*]], <vscale x 4 x i32> [[ZN_COERCE3:%.*]], <vscale x 4 x i32> [[ZM:%.*]])
// CHECK-NEXT:    ret { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z29test_svadd_vector_single4_u3212svuint32x4_tu12__SVUint32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.aarch64.sve.add.single.x4.nxv4i32(<vscale x 4 x i32> [[ZN_COERCE0:%.*]], <vscale x 4 x i32> [[ZN_COERCE1:%.*]], <vscale x 4 x i32> [[ZN_COERCE2:%.*]], <vscale x 4 x i32> [[ZN_COERCE3:%.*]], <vscale x 4 x i32> [[ZM:%.*]])
// CPP-CHECK-NEXT:    ret { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP0]]
//
svuint32x4_t test_svadd_vector_single4_u32(svuint32x4_t zn, svuint32_t zm) __arm_streaming {
  return SVE_ACLE_FUNC(svadd,_single_u32_x4,,,)(zn, zm);
}

// CHECK-LABEL: @test_svadd_vector_single4_s64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.aarch64.sve.add.single.x4.nxv2i64(<vscale x 2 x i64> [[ZN_COERCE0:%.*]], <vscale x 2 x i64> [[ZN_COERCE1:%.*]], <vscale x 2 x i64> [[ZN_COERCE2:%.*]], <vscale x 2 x i64> [[ZN_COERCE3:%.*]], <vscale x 2 x i64> [[ZM:%.*]])
// CHECK-NEXT:    ret { <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64> } [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z29test_svadd_vector_single4_s6411svint64x4_tu11__SVInt64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.aarch64.sve.add.single.x4.nxv2i64(<vscale x 2 x i64> [[ZN_COERCE0:%.*]], <vscale x 2 x i64> [[ZN_COERCE1:%.*]], <vscale x 2 x i64> [[ZN_COERCE2:%.*]], <vscale x 2 x i64> [[ZN_COERCE3:%.*]], <vscale x 2 x i64> [[ZM:%.*]])
// CPP-CHECK-NEXT:    ret { <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64> } [[TMP0]]
//
svint64x4_t test_svadd_vector_single4_s64(svint64x4_t zn, svint64_t zm) __arm_streaming {
  return SVE_ACLE_FUNC(svadd,_single_s64_x4,,,)(zn, zm);
}

// CHECK-LABEL: @test_svadd_vector_single4_u64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.aarch64.sve.add.single.x4.nxv2i64(<vscale x 2 x i64> [[ZN_COERCE0:%.*]], <vscale x 2 x i64> [[ZN_COERCE1:%.*]], <vscale x 2 x i64> [[ZN_COERCE2:%.*]], <vscale x 2 x i64> [[ZN_COERCE3:%.*]], <vscale x 2 x i64> [[ZM:%.*]])
// CHECK-NEXT:    ret { <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64> } [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z29test_svadd_vector_single4_u6412svuint64x4_tu12__SVUint64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.aarch64.sve.add.single.x4.nxv2i64(<vscale x 2 x i64> [[ZN_COERCE0:%.*]], <vscale x 2 x i64> [[ZN_COERCE1:%.*]], <vscale x 2 x i64> [[ZN_COERCE2:%.*]], <vscale x 2 x i64> [[ZN_COERCE3:%.*]], <vscale x 2 x i64> [[ZM:%.*]])
// CPP-CHECK-NEXT:    ret { <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64> } [[TMP0]]
//
svuint64x4_t test_svadd_vector_single4_u64(svuint64x4_t zn, svuint64_t zm) __arm_streaming {
  return SVE_ACLE_FUNC(svadd,_single_u64_x4,,,)(zn, zm);
}