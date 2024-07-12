// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lizn/core/theme/app_pallete.dart';

class BButton extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radius;
  final void Function()? onTap;
  final String text;
  final Widget? child;
  final Color? buttonColor;
  final Color? borderColor;
  final Color? buttonTextColour;
  final double? fontSize;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;
  final bool showBorder;
  const BButton({
    super.key,
    this.height,
    this.width,
    this.radius,
    required this.onTap,
    required this.text,
    this.child,
    this.buttonColor,
    this.borderColor,
    this.buttonTextColour,
    this.fontSize,
    this.fontWeight,
    this.padding,
    this.showBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(width ?? 327.w, height ?? 56.h),
        shape: RoundedRectangleBorder(
          side: showBorder
              ? BorderSide(color: borderColor ?? Pallete.gradient2)
              : BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(radius ?? 8.r),
          ),
        ),
        elevation: 0,
        padding: padding,
        shadowColor: Colors.transparent,
        backgroundColor: buttonColor ?? Pallete.gradient2,
      ),
      child: child ??
          Center(
            child: Text(
              text,
              style: TextStyle(
                  fontSize: fontSize ?? 18.sp,
                  fontWeight: fontWeight,
                  color: buttonTextColour ?? Pallete.backgroundColor),
            ),
          ),
    );
  }
}

class AnimatedButton extends StatelessWidget {
  final double? height;
  final double? width;
  final double? loadingWidth;
  final double? radius;
  final void Function()? onTap;
  final Widget content;
  final Widget? replace;
  final Color? color;
  final BoxBorder? border;
  final bool isLoading;
  const AnimatedButton({
    super.key,
    this.height,
    this.width,
    this.loadingWidth,
    this.radius,
    this.onTap,
    required this.content,
    this.replace,
    this.color,
    this.border,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 900),
        curve: Curves.fastOutSlowIn,
        height: height ?? 56.h,
        width: isLoading
            ? switch (loadingWidth == null) {
                true => 56.w,
                false => loadingWidth,
              }
            : switch (width == null) {
                true => 327.w,
                false => width,
              },
        decoration: BoxDecoration(
            color: color ?? Pallete.gradient2,
            borderRadius: BorderRadius.circular(
              isLoading
                  ? switch (loadingWidth == null) {
                      true => 56.w,
                      false => loadingWidth!,
                    }
                  : switch (width == null) {
                      true => 20.r,
                      false => radius!,
                    },
            ),
            border: border),
        child: Center(
            child: isLoading
                ? (replace ??
                    const CircularProgressIndicator(
                      color: Colors.white,
                    ))
                : content),
      ),
    );
  }
}
