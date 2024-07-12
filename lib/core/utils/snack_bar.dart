import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lizn/core/theme/app_pallete.dart';
import 'package:lizn/core/typedefs/type_defs.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:lizn/core/utils/extensions.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

void showSnackBar({
  required BuildContext context,
  required String theMessage,
  required NotificationType theType,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: theType == NotificationType.failure
            ? Colors.red.shade400
            : theType == NotificationType.success
                ? Colors.green.shade400
                : Pallete.gradient1,
        content: Row(
          children: [
            Icon(
              theType == NotificationType.failure
                  ? PhosphorIconsFill.warning
                  : theType == NotificationType.success
                      ? PhosphorIconsBold.checks
                      : PhosphorIconsFill.warningCircle,
              color: Colors.white,
              size: 18.sp,
            ),
            7.sbW,
            Expanded(
              child: theMessage.txt16(
                size: 14.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
}

void showBanner({
  required BuildContext context,
  required String theMessage,
  required NotificationType theType,
}) {
  Flushbar(
    message: theMessage,
    messageSize: 15.sp,
    duration: const Duration(seconds: 4),
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.FLOATING,
    margin: EdgeInsets.symmetric(horizontal: 10.w),
    borderRadius: BorderRadius.circular(7.r),
    reverseAnimationCurve: Curves.decelerate,
    forwardAnimationCurve: Curves.linearToEaseOut,
    messageColor: Colors.white,
    icon: Icon(
      theType == NotificationType.failure
          ? PhosphorIconsBold.warning
          : theType == NotificationType.success
              ? PhosphorIconsBold.checks
              : PhosphorIconsBold.warningCircle,
      color: Colors.white,
    ),
    backgroundColor: theType == NotificationType.failure
        ? Colors.red.shade400
        : theType == NotificationType.success
            ? Colors.green.shade400
            : Pallete.gradient1,
  ).show(context);
}
