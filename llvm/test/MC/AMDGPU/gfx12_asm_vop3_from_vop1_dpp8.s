// RUN: llvm-mc -triple=amdgcn -mcpu=gfx1200 -mattr=+wavefrontsize32,+real-true16 -show-encoding %s | FileCheck --check-prefix=GFX12 %s

v_bfrev_b32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xb8,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_bfrev_b32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xb8,0xd5,0xea,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_bfrev_b32_e64_dpp v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x00,0xb8,0xd5,0xe9,0x00,0x00,0x00,0xff,0x00,0x00,0x00]

v_ceil_f16_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xdc,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_ceil_f16_e64_dpp v5, v1 mul:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xdc,0xd5,0xe9,0x00,0x00,0x08,0x01,0x77,0x39,0x05]

v_ceil_f16_e64_dpp v5, v1 mul:4 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xdc,0xd5,0xea,0x00,0x00,0x10,0x01,0x77,0x39,0x05]

v_ceil_f16_e64_dpp v255, -|v255| clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x81,0xdc,0xd5,0xe9,0x00,0x00,0x38,0xff,0x00,0x00,0x00]

v_ceil_f32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xa2,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_ceil_f32_e64_dpp v5, v1 mul:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xa2,0xd5,0xe9,0x00,0x00,0x08,0x01,0x77,0x39,0x05]

v_ceil_f32_e64_dpp v5, v1 mul:4 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xa2,0xd5,0xea,0x00,0x00,0x10,0x01,0x77,0x39,0x05]

v_ceil_f32_e64_dpp v255, -|v255| clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x81,0xa2,0xd5,0xe9,0x00,0x00,0x38,0xff,0x00,0x00,0x00]

v_cls_i32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xbb,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cls_i32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xbb,0xd5,0xea,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cls_i32_e64_dpp v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x00,0xbb,0xd5,0xe9,0x00,0x00,0x00,0xff,0x00,0x00,0x00]

v_clz_i32_u32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xb9,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_clz_i32_u32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xb9,0xd5,0xea,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_clz_i32_u32_e64_dpp v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x00,0xb9,0xd5,0xe9,0x00,0x00,0x00,0xff,0x00,0x00,0x00]

v_cos_f16_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xe1,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cos_f16_e64_dpp v5, v1 mul:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xe1,0xd5,0xe9,0x00,0x00,0x08,0x01,0x77,0x39,0x05]

v_cos_f16_e64_dpp v5, v1 mul:4 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xe1,0xd5,0xea,0x00,0x00,0x10,0x01,0x77,0x39,0x05]

v_cos_f16_e64_dpp v255, -|v255| clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x81,0xe1,0xd5,0xe9,0x00,0x00,0x38,0xff,0x00,0x00,0x00]

v_cos_f32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xb6,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cos_f32_e64_dpp v5, v1 mul:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xb6,0xd5,0xe9,0x00,0x00,0x08,0x01,0x77,0x39,0x05]

v_cos_f32_e64_dpp v5, v1 mul:4 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xb6,0xd5,0xea,0x00,0x00,0x10,0x01,0x77,0x39,0x05]

v_cos_f32_e64_dpp v255, -|v255| clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x81,0xb6,0xd5,0xe9,0x00,0x00,0x38,0xff,0x00,0x00,0x00]

v_ctz_i32_b32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xba,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_ctz_i32_b32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xba,0xd5,0xea,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_ctz_i32_b32_e64_dpp v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x00,0xba,0xd5,0xe9,0x00,0x00,0x00,0xff,0x00,0x00,0x00]

v_cvt_f32_fp8_e64_dpp v5, v1 dpp8:[0,1,2,3,4,5,6,7]
// GFX12: encoding: [0x05,0x00,0xec,0xd5,0xe9,0x00,0x00,0x00,0x01,0x88,0xc6,0xfa]

v_cvt_f32_fp8_e64_dpp v1, v3 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0x01,0x00,0xec,0xd5,0xe9,0x00,0x00,0x00,0x03,0x77,0x39,0x05]

v_cvt_f32_bf8_e64_dpp v5, v1 dpp8:[0,1,2,3,4,5,6,7]
// GFX12: encoding: [0x05,0x00,0xed,0xd5,0xe9,0x00,0x00,0x00,0x01,0x88,0xc6,0xfa]

v_cvt_f32_bf8_e64_dpp v1, v3 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: encoding: [0x01,0x00,0xed,0xd5,0xe9,0x00,0x00,0x00,0x03,0x77,0x39,0x05]

v_cvt_f16_f32_e64_dpp v5.l, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0x8a,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_f16_f32_e64_dpp v5.l, v1 mul:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0x8a,0xd5,0xe9,0x00,0x00,0x08,0x01,0x77,0x39,0x05]

v_cvt_f16_f32_e64_dpp v5.l, v1 mul:4 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0x8a,0xd5,0xea,0x00,0x00,0x10,0x01,0x77,0x39,0x05]

v_cvt_f16_f32_e64_dpp v255.l, -|v255| clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x81,0x8a,0xd5,0xe9,0x00,0x00,0x38,0xff,0x00,0x00,0x00]

v_cvt_f16_f32_e64_dpp v255.h, -|v255| clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0xc1,0x8a,0xd5,0xe9,0x00,0x00,0x38,0xff,0x00,0x00,0x00]

v_cvt_f16_i16_e64_dpp v5.l, v1.l dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xd1,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_f16_i16_e64_dpp v5.l, v1.l mul:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xd1,0xd5,0xe9,0x00,0x00,0x08,0x01,0x77,0x39,0x05]

v_cvt_f16_i16_e64_dpp v5.l, v1.l mul:4 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xd1,0xd5,0xea,0x00,0x00,0x10,0x01,0x77,0x39,0x05]

v_cvt_f16_i16_e64_dpp v255.l, v255.l clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x80,0xd1,0xd5,0xe9,0x00,0x00,0x18,0xff,0x00,0x00,0x00]

v_cvt_f16_i16_e64_dpp v5.h, v1.h mul:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x48,0xd1,0xd5,0xe9,0x00,0x00,0x08,0x01,0x77,0x39,0x05]

v_cvt_f16_i16_e64_dpp v5.l, v1.h mul:4 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x08,0xd1,0xd5,0xea,0x00,0x00,0x10,0x01,0x77,0x39,0x05]

v_cvt_f16_i16_e64_dpp v255.h, v255.l clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0xc0,0xd1,0xd5,0xe9,0x00,0x00,0x18,0xff,0x00,0x00,0x00]

v_cvt_f16_u16_e64_dpp v5.l, v1.l dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xd0,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_f16_u16_e64_dpp v5.l, v1.l mul:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xd0,0xd5,0xe9,0x00,0x00,0x08,0x01,0x77,0x39,0x05]

v_cvt_f16_u16_e64_dpp v5.l, v1.l mul:4 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xd0,0xd5,0xea,0x00,0x00,0x10,0x01,0x77,0x39,0x05]

v_cvt_f16_u16_e64_dpp v255.l, v255.l clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x80,0xd0,0xd5,0xe9,0x00,0x00,0x18,0xff,0x00,0x00,0x00]

v_cvt_f16_u16_e64_dpp v5.h, v1.h mul:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x48,0xd0,0xd5,0xe9,0x00,0x00,0x08,0x01,0x77,0x39,0x05]

v_cvt_f16_u16_e64_dpp v5.l, v1.h mul:4 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x08,0xd0,0xd5,0xea,0x00,0x00,0x10,0x01,0x77,0x39,0x05]

v_cvt_f16_u16_e64_dpp v255.h, v255.l clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0xc0,0xd0,0xd5,0xe9,0x00,0x00,0x18,0xff,0x00,0x00,0x00]

v_cvt_f32_f16_e64_dpp v5, v1.l dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0x8b,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_f32_f16_e64_dpp v5, v1.l mul:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0x8b,0xd5,0xe9,0x00,0x00,0x08,0x01,0x77,0x39,0x05]

v_cvt_f32_f16_e64_dpp v5, v1.l mul:4 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0x8b,0xd5,0xea,0x00,0x00,0x10,0x01,0x77,0x39,0x05]

v_cvt_f32_f16_e64_dpp v255, -|v255.l| clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x81,0x8b,0xd5,0xe9,0x00,0x00,0x38,0xff,0x00,0x00,0x00]

v_cvt_f32_f16_e64_dpp v255, -|v255.h| clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x89,0x8b,0xd5,0xe9,0x00,0x00,0x38,0xff,0x00,0x00,0x00]

v_cvt_f32_fp8 v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: v_cvt_f32_fp8_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0] ; encoding: [0xe9,0xd8,0x02,0x7e,0x02,0x77,0x39,0x05]

v_cvt_f32_fp8 v1, v2 byte_sel:0 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: v_cvt_f32_fp8_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0] ; encoding: [0x01,0x00,0xec,0xd5,0xe9,0x00,0x00,0x00,0x02,0x77,0x39,0x05]

v_cvt_f32_fp8 v1, v2 byte_sel:1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: v_cvt_f32_fp8_e64_dpp v1, v2 byte_sel:1 dpp8:[7,6,5,4,3,2,1,0] ; encoding: [0x01,0x10,0xec,0xd5,0xe9,0x00,0x00,0x00,0x02,0x77,0x39,0x05]

v_cvt_f32_fp8 v1, v2 byte_sel:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: v_cvt_f32_fp8_e64_dpp v1, v2 byte_sel:2 dpp8:[7,6,5,4,3,2,1,0] ; encoding: [0x01,0x08,0xec,0xd5,0xe9,0x00,0x00,0x00,0x02,0x77,0x39,0x05]

v_cvt_f32_fp8 v1, v2 byte_sel:3 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: v_cvt_f32_fp8_e64_dpp v1, v2 byte_sel:3 dpp8:[7,6,5,4,3,2,1,0] ; encoding: [0x01,0x18,0xec,0xd5,0xe9,0x00,0x00,0x00,0x02,0x77,0x39,0x05]

v_cvt_f32_bf8 v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: v_cvt_f32_bf8_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0] ; encoding: [0xe9,0xda,0x02,0x7e,0x02,0x77,0x39,0x05]

v_cvt_f32_bf8 v1, v2 byte_sel:0 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: v_cvt_f32_bf8_e64_dpp v1, v2 dpp8:[7,6,5,4,3,2,1,0] ; encoding: [0x01,0x00,0xed,0xd5,0xe9,0x00,0x00,0x00,0x02,0x77,0x39,0x05]

v_cvt_f32_bf8 v1, v2 byte_sel:1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: v_cvt_f32_bf8_e64_dpp v1, v2 byte_sel:1 dpp8:[7,6,5,4,3,2,1,0] ; encoding: [0x01,0x10,0xed,0xd5,0xe9,0x00,0x00,0x00,0x02,0x77,0x39,0x05]

v_cvt_f32_bf8 v1, v2 byte_sel:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: v_cvt_f32_bf8_e64_dpp v1, v2 byte_sel:2 dpp8:[7,6,5,4,3,2,1,0] ; encoding: [0x01,0x08,0xed,0xd5,0xe9,0x00,0x00,0x00,0x02,0x77,0x39,0x05]

v_cvt_f32_bf8 v1, v2 byte_sel:3 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: v_cvt_f32_bf8_e64_dpp v1, v2 byte_sel:3 dpp8:[7,6,5,4,3,2,1,0] ; encoding: [0x01,0x18,0xed,0xd5,0xe9,0x00,0x00,0x00,0x02,0x77,0x39,0x05]

v_cvt_f32_i32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0x85,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_f32_i32_e64_dpp v5, v1 mul:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0x85,0xd5,0xe9,0x00,0x00,0x08,0x01,0x77,0x39,0x05]

v_cvt_f32_i32_e64_dpp v5, v1 mul:4 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0x85,0xd5,0xea,0x00,0x00,0x10,0x01,0x77,0x39,0x05]

v_cvt_f32_i32_e64_dpp v255, v255 clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x80,0x85,0xd5,0xe9,0x00,0x00,0x18,0xff,0x00,0x00,0x00]

v_cvt_f32_u32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0x86,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_f32_u32_e64_dpp v5, v1 mul:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0x86,0xd5,0xe9,0x00,0x00,0x08,0x01,0x77,0x39,0x05]

v_cvt_f32_u32_e64_dpp v5, v1 mul:4 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0x86,0xd5,0xea,0x00,0x00,0x10,0x01,0x77,0x39,0x05]

v_cvt_f32_u32_e64_dpp v255, v255 clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x80,0x86,0xd5,0xe9,0x00,0x00,0x18,0xff,0x00,0x00,0x00]

v_cvt_f32_ubyte0_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0x91,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_f32_ubyte0_e64_dpp v5, v1 mul:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0x91,0xd5,0xe9,0x00,0x00,0x08,0x01,0x77,0x39,0x05]

v_cvt_f32_ubyte0_e64_dpp v5, v1 mul:4 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0x91,0xd5,0xea,0x00,0x00,0x10,0x01,0x77,0x39,0x05]

v_cvt_f32_ubyte0_e64_dpp v255, v255 clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x80,0x91,0xd5,0xe9,0x00,0x00,0x18,0xff,0x00,0x00,0x00]

v_cvt_f32_ubyte1_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0x92,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_f32_ubyte1_e64_dpp v5, v1 mul:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0x92,0xd5,0xe9,0x00,0x00,0x08,0x01,0x77,0x39,0x05]

v_cvt_f32_ubyte1_e64_dpp v5, v1 mul:4 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0x92,0xd5,0xea,0x00,0x00,0x10,0x01,0x77,0x39,0x05]

v_cvt_f32_ubyte1_e64_dpp v255, v255 clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x80,0x92,0xd5,0xe9,0x00,0x00,0x18,0xff,0x00,0x00,0x00]

v_cvt_f32_ubyte2_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0x93,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_f32_ubyte2_e64_dpp v5, v1 mul:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0x93,0xd5,0xe9,0x00,0x00,0x08,0x01,0x77,0x39,0x05]

v_cvt_f32_ubyte2_e64_dpp v5, v1 mul:4 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0x93,0xd5,0xea,0x00,0x00,0x10,0x01,0x77,0x39,0x05]

v_cvt_f32_ubyte2_e64_dpp v255, v255 clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x80,0x93,0xd5,0xe9,0x00,0x00,0x18,0xff,0x00,0x00,0x00]

v_cvt_f32_ubyte3_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0x94,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_f32_ubyte3_e64_dpp v5, v1 mul:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0x94,0xd5,0xe9,0x00,0x00,0x08,0x01,0x77,0x39,0x05]

v_cvt_f32_ubyte3_e64_dpp v5, v1 mul:4 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0x94,0xd5,0xea,0x00,0x00,0x10,0x01,0x77,0x39,0x05]

v_cvt_f32_ubyte3_e64_dpp v255, v255 clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x80,0x94,0xd5,0xe9,0x00,0x00,0x18,0xff,0x00,0x00,0x00]

v_cvt_floor_i32_f32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0x8d,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_floor_i32_f32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0x8d,0xd5,0xea,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_floor_i32_f32_e64_dpp v255, -|v255| dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x01,0x8d,0xd5,0xe9,0x00,0x00,0x20,0xff,0x00,0x00,0x00]

v_cvt_flr_i32_f32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0x8d,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_flr_i32_f32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0x8d,0xd5,0xea,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_flr_i32_f32_e64_dpp v255, -|v255| dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x01,0x8d,0xd5,0xe9,0x00,0x00,0x20,0xff,0x00,0x00,0x00]

v_cvt_i16_f16_e64_dpp v5.l, v1.l dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xd3,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_i16_f16_e64_dpp v5.l, v1.l dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xd3,0xd5,0xea,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_i16_f16_e64_dpp v255.l, -|v255.l| clamp dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x81,0xd3,0xd5,0xe9,0x00,0x00,0x20,0xff,0x00,0x00,0x00]

v_cvt_i16_f16_e64_dpp v5.h, v1.h dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x48,0xd3,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_i16_f16_e64_dpp v5.l, v1.h dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x08,0xd3,0xd5,0xea,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_i16_f16_e64_dpp v255.h, -|v255.l| clamp dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0xc1,0xd3,0xd5,0xe9,0x00,0x00,0x20,0xff,0x00,0x00,0x00]

v_cvt_i32_f32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0x88,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_i32_f32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0x88,0xd5,0xea,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_i32_f32_e64_dpp v255, -|v255| clamp dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x81,0x88,0xd5,0xe9,0x00,0x00,0x20,0xff,0x00,0x00,0x00]

v_cvt_i32_i16_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xea,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_i32_i16_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xea,0xd5,0xea,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_i32_i16_e64_dpp v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x00,0xea,0xd5,0xe9,0x00,0x00,0x00,0xff,0x00,0x00,0x00]

v_cvt_nearest_i32_f32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0x8c,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_nearest_i32_f32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0x8c,0xd5,0xea,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_nearest_i32_f32_e64_dpp v255, -|v255| dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x01,0x8c,0xd5,0xe9,0x00,0x00,0x20,0xff,0x00,0x00,0x00]

v_cvt_norm_i16_f16_e64_dpp v5.l, v1.l dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xe3,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_norm_i16_f16_e64_dpp v5.l, v1.l dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xe3,0xd5,0xea,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_norm_i16_f16_e64_dpp v255.l, -|v255.l| dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x01,0xe3,0xd5,0xe9,0x00,0x00,0x20,0xff,0x00,0x00,0x00]

v_cvt_norm_i16_f16_e64_dpp v5.h, v1.h dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x48,0xe3,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_norm_i16_f16_e64_dpp v5.l, v1.h dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x08,0xe3,0xd5,0xea,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_norm_i16_f16_e64_dpp v255.h, -|v255.l| dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x41,0xe3,0xd5,0xe9,0x00,0x00,0x20,0xff,0x00,0x00,0x00]

v_cvt_norm_u16_f16_e64_dpp v5.l, v1.l dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xe4,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_norm_u16_f16_e64_dpp v5.l, v1.l dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xe4,0xd5,0xea,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_norm_u16_f16_e64_dpp v255.l, -|v255.l| dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x01,0xe4,0xd5,0xe9,0x00,0x00,0x20,0xff,0x00,0x00,0x00]

v_cvt_norm_u16_f16_e64_dpp v5.h, v1.h dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x48,0xe4,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_norm_u16_f16_e64_dpp v5.l, v1.h dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x08,0xe4,0xd5,0xea,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_norm_u16_f16_e64_dpp v255.h, -|v255.l| dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x41,0xe4,0xd5,0xe9,0x00,0x00,0x20,0xff,0x00,0x00,0x00]

v_cvt_off_f32_i4_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0x8e,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_off_f32_i4_e64_dpp v5, v1 mul:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0x8e,0xd5,0xe9,0x00,0x00,0x08,0x01,0x77,0x39,0x05]

v_cvt_off_f32_i4_e64_dpp v5, v1 mul:4 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0x8e,0xd5,0xea,0x00,0x00,0x10,0x01,0x77,0x39,0x05]

v_cvt_off_f32_i4_e64_dpp v255, v255 clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x80,0x8e,0xd5,0xe9,0x00,0x00,0x18,0xff,0x00,0x00,0x00]

v_cvt_rpi_i32_f32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0x8c,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_rpi_i32_f32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0x8c,0xd5,0xea,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_rpi_i32_f32_e64_dpp v255, -|v255| dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x01,0x8c,0xd5,0xe9,0x00,0x00,0x20,0xff,0x00,0x00,0x00]

v_cvt_u16_f16_e64_dpp v5.l, v1.l dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xd2,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_u16_f16_e64_dpp v5.l, v1.l dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xd2,0xd5,0xea,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_u16_f16_e64_dpp v255.l, -|v255.l| clamp dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x81,0xd2,0xd5,0xe9,0x00,0x00,0x20,0xff,0x00,0x00,0x00]

v_cvt_u16_f16_e64_dpp v5.h, v1.h dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x48,0xd2,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_u16_f16_e64_dpp v5.l, v1.h dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x08,0xd2,0xd5,0xea,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_u16_f16_e64_dpp v255.h, -|v255.l| clamp dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0xc1,0xd2,0xd5,0xe9,0x00,0x00,0x20,0xff,0x00,0x00,0x00]

v_cvt_u32_f32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0x87,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_u32_f32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0x87,0xd5,0xea,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_u32_f32_e64_dpp v255, -|v255| clamp dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x81,0x87,0xd5,0xe9,0x00,0x00,0x20,0xff,0x00,0x00,0x00]

v_cvt_u32_u16_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xeb,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_u32_u16_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xeb,0xd5,0xea,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_cvt_u32_u16_e64_dpp v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x00,0xeb,0xd5,0xe9,0x00,0x00,0x00,0xff,0x00,0x00,0x00]

v_exp_f16_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xd8,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_exp_f16_e64_dpp v5, v1 mul:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xd8,0xd5,0xe9,0x00,0x00,0x08,0x01,0x77,0x39,0x05]

v_exp_f16_e64_dpp v5, v1 mul:4 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xd8,0xd5,0xea,0x00,0x00,0x10,0x01,0x77,0x39,0x05]

v_exp_f16_e64_dpp v255, -|v255| clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x81,0xd8,0xd5,0xe9,0x00,0x00,0x38,0xff,0x00,0x00,0x00]

v_exp_f32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xa5,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_exp_f32_e64_dpp v5, v1 mul:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xa5,0xd5,0xe9,0x00,0x00,0x08,0x01,0x77,0x39,0x05]

v_exp_f32_e64_dpp v5, v1 mul:4 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xa5,0xd5,0xea,0x00,0x00,0x10,0x01,0x77,0x39,0x05]

v_exp_f32_e64_dpp v255, -|v255| clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x81,0xa5,0xd5,0xe9,0x00,0x00,0x38,0xff,0x00,0x00,0x00]

v_ffbh_i32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xbb,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_ffbh_i32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xbb,0xd5,0xea,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_ffbh_i32_e64_dpp v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x00,0xbb,0xd5,0xe9,0x00,0x00,0x00,0xff,0x00,0x00,0x00]

v_ffbh_u32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xb9,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_ffbh_u32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xb9,0xd5,0xea,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_ffbh_u32_e64_dpp v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x00,0xb9,0xd5,0xe9,0x00,0x00,0x00,0xff,0x00,0x00,0x00]

v_ffbl_b32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xba,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_ffbl_b32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xba,0xd5,0xea,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_ffbl_b32_e64_dpp v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x00,0xba,0xd5,0xe9,0x00,0x00,0x00,0xff,0x00,0x00,0x00]

v_floor_f16_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xdb,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_floor_f16_e64_dpp v5, v1 mul:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xdb,0xd5,0xe9,0x00,0x00,0x08,0x01,0x77,0x39,0x05]

v_floor_f16_e64_dpp v5, v1 mul:4 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xdb,0xd5,0xea,0x00,0x00,0x10,0x01,0x77,0x39,0x05]

v_floor_f16_e64_dpp v255, -|v255| clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x81,0xdb,0xd5,0xe9,0x00,0x00,0x38,0xff,0x00,0x00,0x00]

v_floor_f32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xa4,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_floor_f32_e64_dpp v5, v1 mul:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xa4,0xd5,0xe9,0x00,0x00,0x08,0x01,0x77,0x39,0x05]

v_floor_f32_e64_dpp v5, v1 mul:4 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xa4,0xd5,0xea,0x00,0x00,0x10,0x01,0x77,0x39,0x05]

v_floor_f32_e64_dpp v255, -|v255| clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x81,0xa4,0xd5,0xe9,0x00,0x00,0x38,0xff,0x00,0x00,0x00]

v_fract_f16_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xdf,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_fract_f16_e64_dpp v5, v1 mul:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xdf,0xd5,0xe9,0x00,0x00,0x08,0x01,0x77,0x39,0x05]

v_fract_f16_e64_dpp v5, v1 mul:4 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xdf,0xd5,0xea,0x00,0x00,0x10,0x01,0x77,0x39,0x05]

v_fract_f16_e64_dpp v255, -|v255| clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x81,0xdf,0xd5,0xe9,0x00,0x00,0x38,0xff,0x00,0x00,0x00]

v_fract_f32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xa0,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_fract_f32_e64_dpp v5, v1 mul:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xa0,0xd5,0xe9,0x00,0x00,0x08,0x01,0x77,0x39,0x05]

v_fract_f32_e64_dpp v5, v1 mul:4 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xa0,0xd5,0xea,0x00,0x00,0x10,0x01,0x77,0x39,0x05]

v_fract_f32_e64_dpp v255, -|v255| clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x81,0xa0,0xd5,0xe9,0x00,0x00,0x38,0xff,0x00,0x00,0x00]

v_frexp_exp_i16_f16_e64_dpp v5.l, v1.l dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xda,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_frexp_exp_i16_f16_e64_dpp v5.l, v1.l dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xda,0xd5,0xea,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_frexp_exp_i16_f16_e64_dpp v255.l, -|v255.l| dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x01,0xda,0xd5,0xe9,0x00,0x00,0x20,0xff,0x00,0x00,0x00]

v_frexp_exp_i16_f16_e64_dpp v5.h, v1.h dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x48,0xda,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_frexp_exp_i16_f16_e64_dpp v5.l, v1.h dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x08,0xda,0xd5,0xea,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_frexp_exp_i16_f16_e64_dpp v255.h, -|v255.l| dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x41,0xda,0xd5,0xe9,0x00,0x00,0x20,0xff,0x00,0x00,0x00]

v_frexp_exp_i32_f32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xbf,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_frexp_exp_i32_f32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xbf,0xd5,0xea,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_frexp_exp_i32_f32_e64_dpp v255, -|v255| dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x01,0xbf,0xd5,0xe9,0x00,0x00,0x20,0xff,0x00,0x00,0x00]

v_frexp_mant_f16_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xd9,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_frexp_mant_f16_e64_dpp v5, v1 mul:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xd9,0xd5,0xe9,0x00,0x00,0x08,0x01,0x77,0x39,0x05]

v_frexp_mant_f16_e64_dpp v5, v1 mul:4 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xd9,0xd5,0xea,0x00,0x00,0x10,0x01,0x77,0x39,0x05]

v_frexp_mant_f16_e64_dpp v255, -|v255| clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x81,0xd9,0xd5,0xe9,0x00,0x00,0x38,0xff,0x00,0x00,0x00]

v_frexp_mant_f32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xc0,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_frexp_mant_f32_e64_dpp v5, v1 mul:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xc0,0xd5,0xe9,0x00,0x00,0x08,0x01,0x77,0x39,0x05]

v_frexp_mant_f32_e64_dpp v5, v1 mul:4 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xc0,0xd5,0xea,0x00,0x00,0x10,0x01,0x77,0x39,0x05]

v_frexp_mant_f32_e64_dpp v255, -|v255| clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x81,0xc0,0xd5,0xe9,0x00,0x00,0x38,0xff,0x00,0x00,0x00]

v_log_f16_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xd7,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_log_f16_e64_dpp v5, v1 mul:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xd7,0xd5,0xe9,0x00,0x00,0x08,0x01,0x77,0x39,0x05]

v_log_f16_e64_dpp v5, v1 mul:4 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xd7,0xd5,0xea,0x00,0x00,0x10,0x01,0x77,0x39,0x05]

v_log_f16_e64_dpp v255, -|v255| clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x81,0xd7,0xd5,0xe9,0x00,0x00,0x38,0xff,0x00,0x00,0x00]

v_log_f32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xa7,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_log_f32_e64_dpp v5, v1 mul:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xa7,0xd5,0xe9,0x00,0x00,0x08,0x01,0x77,0x39,0x05]

v_log_f32_e64_dpp v5, v1 mul:4 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xa7,0xd5,0xea,0x00,0x00,0x10,0x01,0x77,0x39,0x05]

v_log_f32_e64_dpp v255, -|v255| clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x81,0xa7,0xd5,0xe9,0x00,0x00,0x38,0xff,0x00,0x00,0x00]

v_mov_b32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0x81,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_mov_b32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0x81,0xd5,0xea,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_mov_b32_e64_dpp v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x00,0x81,0xd5,0xe9,0x00,0x00,0x00,0xff,0x00,0x00,0x00]

v_movrels_b32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xc3,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_movrels_b32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xc3,0xd5,0xea,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_movrels_b32_e64_dpp v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x00,0xc3,0xd5,0xe9,0x00,0x00,0x00,0xff,0x00,0x00,0x00]

v_not_b16_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xe9,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_not_b16_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xe9,0xd5,0xea,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_not_b16_e64_dpp v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x00,0xe9,0xd5,0xe9,0x00,0x00,0x00,0xff,0x00,0x00,0x00]

v_not_b32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xb7,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_not_b32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xb7,0xd5,0xea,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_not_b32_e64_dpp v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x00,0xb7,0xd5,0xe9,0x00,0x00,0x00,0xff,0x00,0x00,0x00]

v_rcp_f16_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xd4,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_rcp_f16_e64_dpp v5, v1 mul:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xd4,0xd5,0xe9,0x00,0x00,0x08,0x01,0x77,0x39,0x05]

v_rcp_f16_e64_dpp v5, v1 mul:4 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xd4,0xd5,0xea,0x00,0x00,0x10,0x01,0x77,0x39,0x05]

v_rcp_f16_e64_dpp v255, -|v255| clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x81,0xd4,0xd5,0xe9,0x00,0x00,0x38,0xff,0x00,0x00,0x00]

v_rcp_f32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xaa,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_rcp_f32_e64_dpp v5, v1 mul:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xaa,0xd5,0xe9,0x00,0x00,0x08,0x01,0x77,0x39,0x05]

v_rcp_f32_e64_dpp v5, v1 mul:4 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xaa,0xd5,0xea,0x00,0x00,0x10,0x01,0x77,0x39,0x05]

v_rcp_f32_e64_dpp v255, -|v255| clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x81,0xaa,0xd5,0xe9,0x00,0x00,0x38,0xff,0x00,0x00,0x00]

v_rcp_iflag_f32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xab,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_rcp_iflag_f32_e64_dpp v5, v1 mul:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xab,0xd5,0xe9,0x00,0x00,0x08,0x01,0x77,0x39,0x05]

v_rcp_iflag_f32_e64_dpp v5, v1 mul:4 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xab,0xd5,0xea,0x00,0x00,0x10,0x01,0x77,0x39,0x05]

v_rcp_iflag_f32_e64_dpp v255, -|v255| clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x81,0xab,0xd5,0xe9,0x00,0x00,0x38,0xff,0x00,0x00,0x00]

v_rndne_f16_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xde,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_rndne_f16_e64_dpp v5, v1 mul:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xde,0xd5,0xe9,0x00,0x00,0x08,0x01,0x77,0x39,0x05]

v_rndne_f16_e64_dpp v5, v1 mul:4 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xde,0xd5,0xea,0x00,0x00,0x10,0x01,0x77,0x39,0x05]

v_rndne_f16_e64_dpp v255, -|v255| clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x81,0xde,0xd5,0xe9,0x00,0x00,0x38,0xff,0x00,0x00,0x00]

v_rndne_f32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xa3,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_rndne_f32_e64_dpp v5, v1 mul:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xa3,0xd5,0xe9,0x00,0x00,0x08,0x01,0x77,0x39,0x05]

v_rndne_f32_e64_dpp v5, v1 mul:4 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xa3,0xd5,0xea,0x00,0x00,0x10,0x01,0x77,0x39,0x05]

v_rndne_f32_e64_dpp v255, -|v255| clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x81,0xa3,0xd5,0xe9,0x00,0x00,0x38,0xff,0x00,0x00,0x00]

v_rsq_f16_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xd6,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_rsq_f16_e64_dpp v5, v1 mul:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xd6,0xd5,0xe9,0x00,0x00,0x08,0x01,0x77,0x39,0x05]

v_rsq_f16_e64_dpp v5, v1 mul:4 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xd6,0xd5,0xea,0x00,0x00,0x10,0x01,0x77,0x39,0x05]

v_rsq_f16_e64_dpp v255, -|v255| clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x81,0xd6,0xd5,0xe9,0x00,0x00,0x38,0xff,0x00,0x00,0x00]

v_rsq_f32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xae,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_rsq_f32_e64_dpp v5, v1 mul:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xae,0xd5,0xe9,0x00,0x00,0x08,0x01,0x77,0x39,0x05]

v_rsq_f32_e64_dpp v5, v1 mul:4 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xae,0xd5,0xea,0x00,0x00,0x10,0x01,0x77,0x39,0x05]

v_rsq_f32_e64_dpp v255, -|v255| clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x81,0xae,0xd5,0xe9,0x00,0x00,0x38,0xff,0x00,0x00,0x00]

v_sat_pk_u8_i16_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xe2,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_sat_pk_u8_i16_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xe2,0xd5,0xea,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_sat_pk_u8_i16_e64_dpp v255, v255 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x00,0xe2,0xd5,0xe9,0x00,0x00,0x00,0xff,0x00,0x00,0x00]

v_sin_f16_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xe0,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_sin_f16_e64_dpp v5, v1 mul:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xe0,0xd5,0xe9,0x00,0x00,0x08,0x01,0x77,0x39,0x05]

v_sin_f16_e64_dpp v5, v1 mul:4 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xe0,0xd5,0xea,0x00,0x00,0x10,0x01,0x77,0x39,0x05]

v_sin_f16_e64_dpp v255, -|v255| clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x81,0xe0,0xd5,0xe9,0x00,0x00,0x38,0xff,0x00,0x00,0x00]

v_sin_f32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xb5,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_sin_f32_e64_dpp v5, v1 mul:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xb5,0xd5,0xe9,0x00,0x00,0x08,0x01,0x77,0x39,0x05]

v_sin_f32_e64_dpp v5, v1 mul:4 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xb5,0xd5,0xea,0x00,0x00,0x10,0x01,0x77,0x39,0x05]

v_sin_f32_e64_dpp v255, -|v255| clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x81,0xb5,0xd5,0xe9,0x00,0x00,0x38,0xff,0x00,0x00,0x00]

v_sqrt_f16_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xd5,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_sqrt_f16_e64_dpp v5, v1 mul:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xd5,0xd5,0xe9,0x00,0x00,0x08,0x01,0x77,0x39,0x05]

v_sqrt_f16_e64_dpp v5, v1 mul:4 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xd5,0xd5,0xea,0x00,0x00,0x10,0x01,0x77,0x39,0x05]

v_sqrt_f16_e64_dpp v255, -|v255| clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x81,0xd5,0xd5,0xe9,0x00,0x00,0x38,0xff,0x00,0x00,0x00]

v_sqrt_f32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xb3,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_sqrt_f32_e64_dpp v5, v1 mul:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xb3,0xd5,0xe9,0x00,0x00,0x08,0x01,0x77,0x39,0x05]

v_sqrt_f32_e64_dpp v5, v1 mul:4 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xb3,0xd5,0xea,0x00,0x00,0x10,0x01,0x77,0x39,0x05]

v_sqrt_f32_e64_dpp v255, -|v255| clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x81,0xb3,0xd5,0xe9,0x00,0x00,0x38,0xff,0x00,0x00,0x00]

v_trunc_f16_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xdd,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_trunc_f16_e64_dpp v5, v1 mul:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xdd,0xd5,0xe9,0x00,0x00,0x08,0x01,0x77,0x39,0x05]

v_trunc_f16_e64_dpp v5, v1 mul:4 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xdd,0xd5,0xea,0x00,0x00,0x10,0x01,0x77,0x39,0x05]

v_trunc_f16_e64_dpp v255, -|v255| clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x81,0xdd,0xd5,0xe9,0x00,0x00,0x38,0xff,0x00,0x00,0x00]

v_trunc_f32_e64_dpp v5, v1 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xa1,0xd5,0xe9,0x00,0x00,0x00,0x01,0x77,0x39,0x05]

v_trunc_f32_e64_dpp v5, v1 mul:2 dpp8:[7,6,5,4,3,2,1,0]
// GFX12: [0x05,0x00,0xa1,0xd5,0xe9,0x00,0x00,0x08,0x01,0x77,0x39,0x05]

v_trunc_f32_e64_dpp v5, v1 mul:4 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX12: [0x05,0x00,0xa1,0xd5,0xea,0x00,0x00,0x10,0x01,0x77,0x39,0x05]

v_trunc_f32_e64_dpp v255, -|v255| clamp div:2 dpp8:[0,0,0,0,0,0,0,0] fi:0
// GFX12: [0xff,0x81,0xa1,0xd5,0xe9,0x00,0x00,0x38,0xff,0x00,0x00,0x00]