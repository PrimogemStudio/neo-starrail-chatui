import 'dart:async';

import 'package:flutter/material.dart';
import 'package:neo_starrail_chatui/controls/sr_scrollbar.dart';

class SrList extends StatefulWidget {
  SrList({super.key, required this.invertDrag});

  bool invertDrag;

  List<ListTile> contents = [];

  @override
  State<StatefulWidget> createState() => SrListState();
}

class SrListState extends State<SrList> {
  ScrollController controller = ScrollController();
  GlobalKey<AnimatedListState> listKey = GlobalKey();
  bool scrolling = false;

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(milliseconds: 16), (_) {
      if (scrolling) controller.jumpTo(controller.offset);
    });
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.positions.isEmpty) return;
      controller.animateTo(controller.position.maxScrollExtent,
          duration: const Duration(milliseconds: 750),
          curve: Curves.easeOutExpo);
    });
  }

  void add(ListTile t) {
    setState(() {
      widget.contents.add(t);
      listKey.currentState!.insertItem(widget.contents.length - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(scrollbars: false),
            child: SrScrollBar(
                controller: controller,
                flatted: false,
                child: AnimatedList(
                    key: listKey,
                    itemBuilder: (_, b, a) =>
                        FadeTransition(opacity: a, child: widget.contents[b]),
                    initialItemCount: widget.contents.length,
                    controller: controller))),
        onVerticalDragStart: (dud) {
          scrolling = true;
        },
        onVerticalDragUpdate: (dud) {
          controller.jumpTo(controller.offset +
              (widget.invertDrag ? -dud.delta.dy : dud.delta.dy));
        },
        onVerticalDragEnd: (dud) {
          scrolling = false;
        });
  }
}
