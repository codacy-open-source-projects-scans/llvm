//===-- Implementation of strtod_l ----------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "src/stdlib/strtod_l.h"
#include "src/__support/common.h"
#include "src/__support/macros/config.h"
#include "src/__support/str_to_float.h"
#include "src/errno/libc_errno.h"

namespace LIBC_NAMESPACE_DECL {

LLVM_LIBC_FUNCTION(double, strtod_l,
                   (const char *__restrict str, char **__restrict str_end,
                    locale_t)) {
  auto result = internal::strtofloatingpoint<double>(str);
  if (result.has_error())
    libc_errno = result.error;

  if (str_end != nullptr)
    *str_end = const_cast<char *>(str + result.parsed_len);

  return result.value;
}

} // namespace LIBC_NAMESPACE_DECL