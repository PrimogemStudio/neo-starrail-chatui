import 'package:flutter/material.dart';

void showSrDialog(BuildContext context, Function onAnimation, Widget w) {
  showGeneralDialog(
    barrierColor: Colors.transparent,
    barrierDismissible: true,
    barrierLabel: "",
    context: context,
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => w,
    transitionDuration: const Duration(milliseconds: 100),
    transitionBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      var a = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic);
      animation.addListener(() { onAnimation(a.value * 5); });
      return FadeTransition(opacity: a, child: SlideTransition(position: Tween<Offset>(
          begin: const Offset(0, 0.1), end: const Offset(0, 0)).animate(a), child: child));
    },
  );
}