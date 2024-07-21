// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lizn/core/utils/extensions.dart';
import 'package:lizn/features/base_nav/viewmodel/base_nav_viewmodel.dart';

class NavBarWidget extends ConsumerWidget {
  final Nav nav;
  const NavBarWidget({
    super.key,
    required this.nav,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int indexFromController = ref.watch(baseNavStateNotifierProvider);

    return SizedBox(
      width: 60.w,
      child: Column(
        children: [
          17.sbH,
          //! ICON
          Icon(
            switch (indexFromController == nav.index) {
              true => nav.selectedIcon,
              false => nav.icon,
            },
            color: switch (indexFromController == nav.index) {
              true => Colors.white,
              false => Colors.white.withOpacity(0.6),
            },
          ),
          5.sbH,
          nav.name.txt(
            size: 10.sp,
            color: switch (indexFromController == nav.index) {
              true => Colors.white,
              false => Colors.white.withOpacity(0.6),
            },
            fontWeight: switch (indexFromController == nav.index) {
              true => FontWeight.bold,
              false => FontWeight.normal,
            },
          ),

          // //! SPACER
          // 8.4.sbH,
        ],
      ),
    ).tap(
      onTap: () {
        moveToPage(
          context: context,
          ref: ref,
          index: nav.index,
        );
      },
    );
  }
}
