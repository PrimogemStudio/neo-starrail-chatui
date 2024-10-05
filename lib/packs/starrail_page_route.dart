import 'package:flutter/material.dart';

PageRouteBuilder genBuilder(WidgetBuilder builder) {
  return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 150),
      pageBuilder:
          (context, animation, secondaryAnimation) => builder(context),
      transitionsBuilder:
          (context, animation, secondaryAnimation, child) {
        var a = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutQuint,
            reverseCurve: Curves.easeOutQuint);
        return FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0)
                .animate(a),
            child: SlideTransition(
                position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: const Offset(0.0, 0.0))
                    .animate(a),
                child: child));
      });
}