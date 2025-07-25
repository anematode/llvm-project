//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef _LIBCPP___TYPE_TRAITS_IS_NOTHROW_CONSTRUCTIBLE_H
#define _LIBCPP___TYPE_TRAITS_IS_NOTHROW_CONSTRUCTIBLE_H

#include <__config>
#include <__type_traits/add_reference.h>
#include <__type_traits/integral_constant.h>

#if !defined(_LIBCPP_HAS_NO_PRAGMA_SYSTEM_HEADER)
#  pragma GCC system_header
#endif

_LIBCPP_BEGIN_NAMESPACE_STD

template < class _Tp, class... _Args>
struct _LIBCPP_NO_SPECIALIZATIONS is_nothrow_constructible
    : integral_constant<bool, __is_nothrow_constructible(_Tp, _Args...)> {};

#if _LIBCPP_STD_VER >= 17
template <class _Tp, class... _Args>
_LIBCPP_NO_SPECIALIZATIONS inline constexpr bool is_nothrow_constructible_v =
    is_nothrow_constructible<_Tp, _Args...>::value;
#endif

template <class _Tp>
struct _LIBCPP_NO_SPECIALIZATIONS is_nothrow_copy_constructible
    : integral_constant<bool, __is_nothrow_constructible(_Tp, __add_lvalue_reference_t<const _Tp>)> {};

#if _LIBCPP_STD_VER >= 17
template <class _Tp>
_LIBCPP_NO_SPECIALIZATIONS inline constexpr bool is_nothrow_copy_constructible_v =
    is_nothrow_copy_constructible<_Tp>::value;
#endif

template <class _Tp>
struct _LIBCPP_NO_SPECIALIZATIONS is_nothrow_move_constructible
    : integral_constant<bool, __is_nothrow_constructible(_Tp, __add_rvalue_reference_t<_Tp>)> {};

#if _LIBCPP_STD_VER >= 17
template <class _Tp>
_LIBCPP_NO_SPECIALIZATIONS inline constexpr bool is_nothrow_move_constructible_v =
    is_nothrow_move_constructible<_Tp>::value;
#endif

template <class _Tp>
struct _LIBCPP_NO_SPECIALIZATIONS is_nothrow_default_constructible
    : integral_constant<bool, __is_nothrow_constructible(_Tp)> {};

#if _LIBCPP_STD_VER >= 17
template <class _Tp>
_LIBCPP_NO_SPECIALIZATIONS inline constexpr bool is_nothrow_default_constructible_v = __is_nothrow_constructible(_Tp);
#endif

_LIBCPP_END_NAMESPACE_STD

#endif // _LIBCPP___TYPE_TRAITS_IS_NOTHROW_CONSTRUCTIBLE_H
