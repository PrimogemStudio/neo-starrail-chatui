import 'dart:async';

import 'package:flutter/material.dart';
import 'package:neo_starrail_chatui/controls/sr_scrollbar.dart';

class SrList extends StatefulWidget {
  SrList({super.key, required this.invertDrag});

  bool invertDrag;

  @override
  State<StatefulWidget> createState() => SrListState();
}

class SrListState extends State<SrList> {
  ScrollController controller = ScrollController();
  bool scrolling = false;

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(milliseconds: 16), (d) {
      if (scrolling) controller.jumpTo(controller.offset);
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
                child: ListView.builder(
                    itemBuilder: (a, b) {
                      return Text("$b");
                    },
                    itemCount: 100,
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
