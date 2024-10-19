import 'package:flutter/material.dart';
import 'package:neo_starrail_chatui/packs/starrail_colors.dart';

class SrScrollBar extends Scrollbar {
  const SrScrollBar({super.key, required super.child, required super.controller}) : super(
      thumbVisibility: true,
      radius: Radius.zero
  );
  @override
  Widget build(BuildContext context) {
    return SrScrollbarI(
      controller: controller,
      thumbVisibility: thumbVisibility,
      trackVisibility: trackVisibility,
      thickness: thickness,
      radius: radius,
      notificationPredicate: notificationPredicate,
      interactive: interactive,
      scrollbarOrientation: scrollbarOrientation,
      child: child,
    );
  }
}

class SrScrollbarI extends RawScrollbar {
  const SrScrollbarI({
    super.key,
    required super.child,
    super.controller,
    super.thumbVisibility,
    super.trackVisibility,
    super.thickness,
    super.radius,
    ScrollNotificationPredicate? notificationPredicate,
    super.interactive,
    super.scrollbarOrientation,
  }) : super(
    fadeDuration: Duration.zero,
    timeToFade: Duration.zero,
    pressDuration: Duration.zero,
    notificationPredicate: notificationPredicate ?? defaultScrollNotificationPredicate,
  );

  @override
  SrScrollbarStateI createState() => SrScrollbarStateI();
}

class SrScrollbarStateI extends RawScrollbarState<SrScrollbarI> {
  @override
  bool get showScrollbar => true;

  ScrollbarPainter? painter;

  @override
  void updateScrollbarPainter() {
    scrollbarPainter
      ..color = uiViewBarMain
      ..trackColor = uiViewBarBg
      ..trackBorderColor = Colors.transparent
      ..textDirection = Directionality.of(context)
      ..thickness = 3
      ..radius = Radius.zero
      ..crossAxisMargin = 0
      ..mainAxisMargin = 0
      ..minLength = 0
      ..minOverscrollLength = 0
      ..padding = const EdgeInsets.only(right: 8, top: 8, bottom: 24)
      ..scrollbarOrientation = widget.scrollbarOrientation
      ..ignorePointer = false;
  }
}
