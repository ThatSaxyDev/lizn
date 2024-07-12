// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final double? height;
  final double? width;
  final String? hintText;
  final String? labelText;
  final bool hastitle;
  final bool? filled;
  final bool readOnly;
  final Color? fillColor;
  final TextEditingController controller;
  final bool obscuretext;
  final FormFieldValidator<String>? validator;
  final Widget? prefixIcon;
  final Widget? prefix;
  final Widget? suffixIcon;
  final void Function(String)? onFieldSubmitted;
  final Widget? suffix;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final List<TextInputFormatter>? inputFormatters;
  final Color? titleColor;
  final Color? borderColor;
  final void Function()? onTap;
  final void Function(PointerDownEvent)? onTapOutside;
  final Widget? iconn;
  final int? maxLength;
  final int? maxLines;
  final Widget? cardIcon;
  const CustomTextField({
    super.key,
    this.height,
    this.width,
    this.hintText,
    this.labelText,
    this.hastitle = true,
    this.filled,
    this.readOnly = false,
    this.fillColor,
    required this.controller,
    this.obscuretext = false,
    this.validator,
    this.suffixIcon,
    this.prefix,
    this.prefixIcon,
    this.onFieldSubmitted,
    this.suffix,
    this.focusNode,
    this.keyboardType,
    this.onChanged,
    this.onSaved,
    this.inputFormatters,
    this.titleColor,
    this.borderColor,
    this.onTap,
    this.onTapOutside,
    this.iconn,
    this.maxLength,
    this.maxLines,
    this.cardIcon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: SizedBox(
        height: 50.h,
        child: TextFormField(
          textInputAction: TextInputAction.done,
          readOnly: readOnly,
          maxLines: maxLines,
          maxLength: maxLength,
          onTap: onTap,
          onTapOutside: onTapOutside,
          keyboardType: keyboardType,
          focusNode: focusNode,
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChanged,
          onSaved: onSaved,
          style: TextStyle(
            fontSize: 16.sp,
            // color: grey900,
          ),
          controller: controller,
          inputFormatters: inputFormatters,
          obscureText: obscuretext,
          obscuringCharacter: '*',
          // cursorColor: SwimfluenceTheme.lightTheme.primaryColor,
          // cursorHeight: 16.h,
          decoration: InputDecoration(
            filled: filled,
            fillColor: fillColor,
            // isDense: true,
            suffix: suffix,
            contentPadding: EdgeInsets.only(left: 16.w),
            helperText: " ",
            helperStyle: const TextStyle(fontSize: 0.0005),
            errorStyle: const TextStyle(fontSize: 0.0005),
            suffixIcon: suffixIcon,
            prefix: prefix,
            prefixIcon: prefixIcon,
            suffixIconConstraints:
                BoxConstraints(minHeight: 20.h, minWidth: 20.w),
            hintText: hintText,
            // hintStyle: TextStyle(
            //   color: SwimfluenceTheme.lightTheme.hintColor,
            //   fontSize: 16.sp,
            // ),
            // labelText: labelText,
            // labelStyle: TextStyle(
            //   color: SwimfluenceTheme.lightTheme.hintColor,
            // ),
            // enabledBorder: OutlineInputBorder(
            //   borderSide:
            //       BorderSide(color: SwimfluenceTheme.lightTheme.primaryColor),
            // ),
            // focusedBorder: OutlineInputBorder(
            //   borderSide: BorderSide(
            //     color: SwimfluenceTheme.lightTheme.primaryColor,
            //     width: 2,
            //   ),
            // ),
          ),
          validator: validator,
        ),
      ),
    );
  }
}
