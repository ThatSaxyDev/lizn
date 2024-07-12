//! THIS FILE CONTAINS HOPEFULLY, ALL EXTENSIONS USED IN THE APP.
import "dart:io";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:intl/intl.dart";

//! LOG EXTENSION - THIS HELPS TO CALL A .log() ON ANY OBJECT
extension Log on Object {
  void log() {
    if (kDebugMode) {
      print(toString());
    }
  }
}

//! HELPS TO CALL A .dismissKeyboard ON A WIDGET
extension DismissKeyboard on Widget {
  void dismissKeyboard() => FocusManager.instance.primaryFocus?.unfocus();
}

const ext = 0;
final formatCurrency =
    NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');

//Formats the amount and returns a formatted amount
String formatPrice(String amount) {
  return formatCurrency.format(num.parse(amount)).toString();
}

extension StringCasingExtension on String {
  String? camelCase() => toBeginningOfSentenceCase(this);
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
  String? trimToken() => contains(":") ? split(":")[1].trim() : this;
  String? trimSpaces() => replaceAll(" ", "");
  String removeSpacesAndLower() => replaceAll(' ', '').toLowerCase();
}

extension StyledTextExtension on String {
  Text txt({
    double? size,
    Color? color,
    FontWeight? fontWeight,
    String? fontFamily,
    FontStyle? fontStyle,
    TextOverflow? overflow,
    TextDecoration? decoration,
    TextAlign? textAlign,
    int? maxLines,
    double? height,
    F? fontW,
  }) {
    return Text(
      this,
      overflow: overflow,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        height: height,
        fontSize: size ?? 14.sp,
        color: color,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
        fontStyle: fontStyle,
        decoration: decoration,
      ),
    );
  }
}

extension StyledTextExtension14 on String {
  Text txt14({
    double? size,
    Color? color,
    FontWeight? fontWeight,
    String? fontFamily,
    FontStyle? fontStyle,
    TextOverflow? overflow,
    TextDecoration? decoration,
    TextAlign? textAlign,
    int? maxLines,
    double? height,
    F? fontW,
  }) {
    return Text(
      this,
      overflow: overflow,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        height: height,
        fontSize: 14.sp,
        color: color,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
        fontStyle: fontStyle,
        decoration: decoration,
      ),
    );
  }
}

extension StyledTextExtension12 on String {
  Text txt12({
    double? size,
    Color? color,
    FontWeight? fontWeight,
    String? fontFamily,
    FontStyle? fontStyle,
    TextOverflow? overflow,
    TextDecoration? decoration,
    TextAlign? textAlign,
    int? maxLines,
    double? height,
    F? fontW,
  }) {
    return Text(
      this,
      overflow: overflow,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        height: height,
        fontSize: 12.sp,
        color: color,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
        fontStyle: fontStyle,
        decoration: decoration,
      ),
    );
  }
}

extension StyledTextExtension16 on String {
  Text txt16({
    double? size,
    Color? color,
    FontWeight? fontWeight,
    String? fontFamily,
    FontStyle? fontStyle,
    TextOverflow? overflow,
    TextDecoration? decoration,
    TextAlign? textAlign,
    int? maxLines,
    double? height,
    F? fontW,
  }) {
    return Text(
      this,
      overflow: overflow,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        height: height,
        fontSize: 16.sp,
        color: color,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
        fontStyle: fontStyle,
        decoration: decoration,
      ),
    );
  }
}

extension StyledTextExtension18 on String {
  Text txt18({
    double? size,
    Color? color,
    FontWeight? fontWeight,
    String? fontFamily,
    FontStyle? fontStyle,
    TextOverflow? overflow,
    TextDecoration? decoration,
    TextAlign? textAlign,
    int? maxLines,
    double? height,
    F? fontW,
  }) {
    return Text(
      this,
      overflow: overflow,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        height: height,
        fontSize: 18.sp,
        color: color,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
        fontStyle: fontStyle,
        decoration: decoration,
      ),
    );
  }
}

extension StyledTextExtension24 on String {
  Text txt24({
    double? size,
    Color? color,
    FontWeight? fontWeight,
    String? fontFamily,
    FontStyle? fontStyle,
    TextOverflow? overflow,
    TextDecoration? decoration,
    TextAlign? textAlign,
    int? maxLines,
    double? height,
    F? fontW,
  }) {
    return Text(
      this,
      overflow: overflow,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        height: height,
        fontSize: 24.sp,
        color: color,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
        fontStyle: fontStyle,
        decoration: decoration,
      ),
    );
  }
}

extension StyledTextExtension30 on String {
  Text txt30({
    double? size,
    Color? color,
    FontWeight? fontWeight,
    String? fontFamily,
    FontStyle? fontStyle,
    TextOverflow? overflow,
    TextDecoration? decoration,
    TextAlign? textAlign,
    int? maxLines,
    double? height,
    F? fontW,
  }) {
    return Text(
      this,
      overflow: overflow,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        height: height,
        fontSize: 28.sp,
        color: color,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
        fontStyle: fontStyle,
        decoration: decoration,
      ),
    );
  }
}

extension StyledTextExtension20 on String {
  Text txt20({
    double? size,
    Color? color,
    FontWeight? fontWeight,
    String? fontFamily,
    FontStyle? fontStyle,
    TextOverflow? overflow,
    TextDecoration? decoration,
    TextAlign? textAlign,
    int? maxLines,
    double? height,
    F? fontW,
  }) {
    return Text(
      this,
      overflow: overflow,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        height: height,
        fontSize: 20.sp,
        color: color,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
        fontStyle: fontStyle,
        decoration: decoration,
      ),
    );
  }
}

extension StyledTextExtensionTheme on String {
  Text txtThemed({
    double? size,
    Color? color,
    FontWeight? fontWeight,
    String? fontFamily,
    FontStyle? fontStyle,
    TextOverflow? overflow,
    TextDecoration? decoration,
    TextAlign? textAlign,
    int? maxLines,
    double? height,
    F? fontW,
    TextStyle? style,
  }) {
    return Text(
      this,
      overflow: overflow,
      textAlign: textAlign,
      maxLines: maxLines,
      style: style,
    );
  }
}

extension ImagePath on String {
  String get png => 'assets/$this.png';
  String get jpg => 'assets/$this.jpg';
  String get gif => 'assets/$this.gif';
}

extension SvgPath on String {
  String get svg => 'lib/assets/svgs/$this.svg';
}

extension NumExtensions on int {
  num addPercentage(num v) => this + ((v / 100) * this);
  num getPercentage(num v) => ((v / 100) * this);
}

extension NumExtensionss on num {
  num addPercentage(num v) => this + ((v / 100) * this);
  num getPercentage(num v) => ((v / 100) * this);
}

// void openUrl({String? url}) {
//   launchUrl(Uri.parse("http://$url"));
// }

// void openMailApp({String? receiver, String? title, String? body}) {
//   launchUrl(Uri.parse("mailto:$receiver?subject=$title&body=$body"));
// }

extension WidgetExtensionss on num {
  Widget get sbH => SizedBox(
        height: h,
      );

  Widget get sbW => SizedBox(
        width: w,
      );

  EdgeInsetsGeometry get padV => EdgeInsets.symmetric(vertical: h);

  EdgeInsetsGeometry get padH => EdgeInsets.symmetric(horizontal: w);
}

extension WidgetExtensions on double {
  Widget get sbH => SizedBox(
        height: h,
      );

  Widget get sbW => SizedBox(
        width: w,
      );

  EdgeInsetsGeometry get padA => EdgeInsets.all(this);

  EdgeInsetsGeometry get padV => EdgeInsets.symmetric(vertical: h);

  EdgeInsetsGeometry get padH => EdgeInsets.symmetric(horizontal: w);
}

extension ImageExtension on String {
  Image myImage({
    Color? color,
    double? height,
    BoxFit? fit,
  }) {
    return Image.asset(
      this,
      height: height,
      fit: fit,
      color: color,
    );
  }
}

extension DurationExtension on int {
  Duration duration({
    int days = 0,
    int hrs = 0,
    int mins = 0,
    int secs = 0,
    int ms = 0,
    int microsecs = 0,
  }) {
    return Duration(
      days: days,
      hours: hrs,
      minutes: mins,
      seconds: secs,
      milliseconds: ms,
      microseconds: microsecs,
    );
  }
}

extension InkWellExtension on Widget {
  InkWell tap({
    required GestureTapCallback? onTap,
    GestureTapCallback? onDoubleTap,
    GestureLongPressCallback? onLongPress,
    BorderRadius? borderRadius,
    Color? splashColor = Colors.transparent,
    Color? highlightColor = Colors.transparent,
  }) {
    return InkWell(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      borderRadius: borderRadius ?? BorderRadius.circular(12.r),
      splashColor: splashColor,
      highlightColor: highlightColor,
      child: this,
    );
  }
}

extension AlignExtension on Widget {
  Align align(Alignment alignment) {
    return Align(
      alignment: alignment,
      child: this,
    );
  }

  Align alignCenter() {
    return Align(
      alignment: Alignment.center,
      child: this,
    );
  }

  Align alignCenterLeft() {
    return Align(
      alignment: Alignment.centerLeft,
      child: this,
    );
  }

  Align alignCenterRight() {
    return Align(
      alignment: Alignment.centerRight,
      child: this,
    );
  }

  Align alignTopCenter() {
    return Align(
      alignment: Alignment.topCenter,
      child: this,
    );
  }

  Align alignBottomCenter() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: this,
    );
  }

  Align alignBottomLeft() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: this,
    );
  }

  Align alignBottomRight() {
    return Align(
      alignment: Alignment.bottomRight,
      child: this,
    );
  }

  Align alignTopRight() {
    return Align(
      alignment: Alignment.topRight,
      child: this,
    );
  }

  Align alignTopLeft() {
    return Align(
      alignment: Alignment.topLeft,
      child: this,
    );
  }

  // Add more alignment methods as needed

  // Example: alignTopCenter, alignBottomRight, etc.
}

extension WidgetAnimation on Widget {
  Animate fadeInFromTop({
    Duration? delay,
    Duration? animatiomDuration,
    Offset? offset,
  }) =>
      animate(delay: delay ?? 500.ms)
          .move(
            duration: animatiomDuration ?? 500.ms,
            begin: offset ?? const Offset(0, -10),
          )
          .fade(duration: animatiomDuration ?? 500.ms);

  Animate fadeInFromBottom({
    Duration? delay,
    Duration? animatiomDuration,
    Offset? offset,
  }) =>
      animate(delay: delay ?? 500.ms)
          .move(
            duration: animatiomDuration ?? 500.ms,
            begin: offset ?? const Offset(0, 10),
          )
          .fade(duration: animatiomDuration ?? 500.ms);

  Animate fadeIn({
    Duration? delay,
    Duration? animatiomDuration,
    Curve? curve,
  }) =>
      animate(delay: delay ?? 500.ms).fade(
        duration: animatiomDuration ?? 500.ms,
        curve: curve ?? Curves.decelerate,
      );
}

//! enum for fontweight
enum F {
  w3,
  w5,
  w6,
  w7,
  w8,
}

/// Extension for creating a ValueNotifier from a value directly.
extension ValueNotifierExtension<T> on T {
  ValueNotifier<T> get notifier {
    return ValueNotifier<T>(this);
  }
}

/// extension for listening to ValueNotifier instances.
extension ValueNotifierBuilderExtension<T> on ValueNotifier<T> {
  Widget sync({
    required Widget Function(BuildContext context, T value, Widget? child)
        builder,
  }) {
    return ValueListenableBuilder<T>(
      valueListenable: this,
      builder: builder,
    );
  }
}

extension ListenableBuilderExtension on List<Listenable> {
  Widget multiSync({
    required Widget Function(BuildContext context, Widget? child) builder,
  }) {
    return ListenableBuilder(
      listenable: Listenable.merge(this),
      builder: builder,
    );
  }
}

extension HapticFeedbackForApp on bool {
  Future<void> withHapticFeedback() async => switch (this) {
        true => await HapticFeedback.lightImpact(),
        false => await HapticFeedback.mediumImpact(),
      };
}

Future<bool> onWillPop() async {
  return false;
}

Future<bool> allowWillPop() async {
  return true;
}

const String dateFormatter = 'EEE, dd MMM yyyy';

extension DateHelper on DateTime {
  String formatDate() {
    final formatter = DateFormat(dateFormatter);
    return formatter.format(this);
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  int getDifferenceInDaysWithNow() {
    final now = DateTime.now();
    return now.difference(this).inDays;
  }
}

extension IgnorePointerExtension on Widget {
  Widget ignoreTaps(bool ignoring, {Widget? child}) {
    return IgnorePointer(
      ignoring: ignoring,
      child: this,
    );
  }
}

double height(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double width(BuildContext context) {
  return MediaQuery.of(context).size.width;
}
