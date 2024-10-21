import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:neo_starrail_chatui/controls/sr_animatableobject.dart';
import 'package:neo_starrail_chatui/controls/sr_colors.dart';
import 'package:neo_starrail_chatui/controls/sr_scrollbar.dart';

class SrList extends StatefulWidget {
  SrList({super.key, required this.invertDrag, required this.flatted});

  bool invertDrag;
  bool flatted;

  List<ListTile> contents = [];
  int loadOffset = 0;
  final int pageSize = 4;

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

  @override
  void didUpdateWidget(covariant SrList oldWidget) {
    super.didUpdateWidget(oldWidget);

    widget.contents = oldWidget.contents;
    widget.loadOffset = oldWidget.loadOffset;
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

  void removeAt(int i) {
    setState(() {
      var l = widget.contents.removeAt(i);
      listKey.currentState!.removeItem(i, (a, b) {
        return FadeTransition(opacity: b, child: l);
      });
    });
  }

  void initAll(List<ListTile> l) {
    widget.contents.addAll(l);
    widget.loadOffset = max(0, l.length - widget.pageSize);
    listKey.currentState!.insertAllItems(0, l.length - widget.loadOffset);
  }

  void loadMore() {
    setState(() {
      var i = widget.loadOffset;
      widget.loadOffset = max(0, widget.loadOffset - widget.pageSize);
      listKey.currentState!.insertAllItems(0, i - widget.loadOffset);
    });
  }

  @override
  Widget build(BuildContext context) {
    var list = GestureDetector(
        child: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(scrollbars: false),
            child: SrScrollBar(
                controller: controller,
                flatted: false,
                child: AnimatedList(
                    key: listKey,
                    itemBuilder: (_, b, a) {
                      var item = widget.contents[b + widget.loadOffset];
                      if (item.title is SrAnimatedObject) {
                        (item.title as SrAnimatedObject).setAnimation(a);
                      }

                      return item;
                    },
                    initialItemCount:
                        widget.contents.length - widget.loadOffset,
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

    return Stack(
      alignment: Alignment.topRight,
      children: [
        list,
        Column(children: [
          Container(
            height: 1,
            color: uiViewSplit,
          ),
          Container(
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    widget.flatted ? Colors.transparent : uiSurfaceColor,
                    widget.flatted ? Colors.transparent : uiSurfaceColorTrans
                  ]),
            ),
          )
        ])
      ],
    );
  }
}
