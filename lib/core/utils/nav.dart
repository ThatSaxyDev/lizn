import 'package:flutter/material.dart';

void goBack(BuildContext context) {
  // killKeyboard(context);
  Navigator.of(context).pop();
}

void goBackTimes(int countToMove, BuildContext context) {
  int count = 0;
  Navigator.of(context).popUntil((_) => count++ >= countToMove);
}

void goTo({
  required BuildContext context,
  required Widget view,
}) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => view,
  ));
}

//! fade page transition
fadeTo({
  required BuildContext context,
  required Widget view,
}) {
  Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, anotherAnimation) {
        return view;
      },
      transitionDuration: const Duration(milliseconds: 1000),
      transitionsBuilder: (context, animation, anotherAnimation, child) {
        animation = CurvedAnimation(
          curve: Curves.easeIn,
          parent: animation,
        );
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      }));
}

void goToAndClearStack({
  required BuildContext context,
  required Widget view,
}) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => view),
    (Route<dynamic> route) => false,
  );
}

slideTo({
  required BuildContext context,
  required Widget view,
}) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return view;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        animation = CurvedAnimation(
          curve: Curves.linearToEaseOut,
          parent: animation,
        );
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0), // from bottom
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    ),
  );
}
