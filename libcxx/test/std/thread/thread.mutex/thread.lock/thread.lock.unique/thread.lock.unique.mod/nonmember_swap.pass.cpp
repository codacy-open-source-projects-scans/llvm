//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

// <mutex>

// template <class Mutex> class unique_lock;

// template <class Mutex>
//   void swap(unique_lock<Mutex>& x, unique_lock<Mutex>& y);

#include <cassert>
#include <memory>
#include <mutex>

#include "checking_mutex.h"
#include "test_macros.h"

#if TEST_STD_VER >= 11
static_assert(noexcept(swap(std::declval<std::unique_lock<checking_mutex>&>(),
                            std::declval<std::unique_lock<checking_mutex>&>())),
              "");
#endif

int main(int, char**) {
  checking_mutex mux;
  std::unique_lock<checking_mutex> lock1(mux);
  std::unique_lock<checking_mutex> lock2;

  swap(lock1, lock2);

  assert(lock1.mutex() == nullptr);
  assert(!lock1.owns_lock());
  assert(lock2.mutex() == std::addressof(mux));
  assert(lock2.owns_lock() == true);

  return 0;
}