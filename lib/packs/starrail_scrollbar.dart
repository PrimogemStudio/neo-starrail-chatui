import 'package:flutter/material.dart';
import 'package:neo_starrail_chatui/packs/starrail_colors.dart';

class StarRailScrollBar extends Scrollbar {
  const StarRailScrollBar(
      {super.key,
      required super.child,
      required super.controller,
      required this.flatted})
      : super(thumbVisibility: true,
      radius: Radius.zero
  );
  final bool flatted;
  @override
  Widget build(BuildContext context) {
    return StarRailScrollbarInternal(
      controller: controller,
      thumbVisibility: thumbVisibility,
      trackVisibility: trackVisibility,
      thickness: thickness,
      radius: radius,
      notificationPredicate: notificationPredicate,
      interactive: interactive,
      scrollbarOrientation: scrollbarOrientation,
      flatted: flatted,
      child: child,
    );
  }
}

class StarRailScrollbarInternal extends RawScrollbar {
  const StarRailScrollbarInternal({
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
      required this.flatted}) : super(
    fadeDuration: Duration.zero,
    timeToFade: Duration.zero,
    pressDuration: Duration.zero,
    notificationPredicate: notificationPredicate ?? defaultScrollNotificationPredicate,
  );

  final bool flatted;

  @override
  StarRailScrollbarInternalState createState() =>
      StarRailScrollbarInternalState();
}

class StarRailScrollbarInternalState
    extends RawScrollbarState<StarRailScrollbarInternal> {
  @override
  bool get showScrollbar => true;

  ScrollbarPainter? painter;

  @override
  void updateScrollbarPainter() {
    scrollbarPainter
      ..color = widget.flatted ? Colors.transparent : uiViewBarMain
      ..trackColor = widget.flatted ? Colors.transparent : uiViewBarBg
      ..trackBorderColor = Colors.transparent
      ..textDirection = Directionality.of(context)
      ..thickness = widget.flatted ? 0 : 3
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
