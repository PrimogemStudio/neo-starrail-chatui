import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:neo_starrail_chatui/controls/starrail_animatable.dart';
import 'package:neo_starrail_chatui/controls/starrail_scrollbar.dart';

import 'starrail_colors.dart';

class StarRailList extends StatefulWidget {
  StarRailList({
    super.key,
    required this.innerPanel,
    required this.flatted
  });

  final Widget? innerPanel;
  bool flatted;

  List<Widget> list = [];
  AnimatedList? view;

  int pageSize = 4;

  @override
  State<StatefulWidget> createState() => StarRailListState();
}

class StarRailListState extends State<StarRailList> {
  final ScrollController _controller = ScrollController();
  final GlobalKey<AnimatedListState> key = GlobalKey<AnimatedListState>();
  final GlobalKey barKey = GlobalKey();

  late Timer timer;
  var scr = false;

  int currentOffset = 0;

  @override
  void didUpdateWidget(covariant StarRailList oldWidget) {
    super.didUpdateWidget(oldWidget);

    widget.list = oldWidget.list;
    widget.view = oldWidget.view;
  }

  void appendItem(ListTile l) {
    setState(() {
      widget.list.add(l);
      key.currentState!.insertItem(widget.list.length - 1 - currentOffset);
      scrollToBottom();
    });
  }

  void appendAll(List<ListTile> l) {
    widget.list.addAll(l);

    currentOffset = max(0, l.length - widget.pageSize);

    key.currentState!.insertAllItems(0, l.length - currentOffset);
  }

  void loadMore() {
    setState(() {
      var i = currentOffset;
      currentOffset = max(0, currentOffset - widget.pageSize);
      key.currentState!.insertAllItems(0, i - currentOffset);
    });
  }

  void removeItemAt(int idx) {
    setState(() {
      var i = widget.list[idx];
      if (idx >= 0) widget.list.removeAt(idx);
      key.currentState!.removeItem(idx, (BuildContext context, Animation<double> animation) {
        return FadeTransition(opacity: animation, child: i);
      }, duration: const Duration(milliseconds: 100));
      scrollToBottom();
    });
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((t) {
      if (_controller.positions.isEmpty) return;
      _controller.animateTo(_controller.position.maxScrollExtent,
          duration: const Duration(milliseconds: 750),
          curve: Curves.easeOutExpo);
    });
  }

  void scrollToBottomImm() {
    _controller.animateTo(_controller.position.maxScrollExtent,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOutExpo);
  }

  void scrollToBottomImmFast() {
    _controller.jumpTo(_controller.position.maxScrollExtent);
  }

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(milliseconds: 16), (_) {
      if (scr) _controller.jumpTo(_controller.offset);
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    widget.view ??= AnimatedList(
      key: key,
      initialItemCount: widget.list.length - currentOffset,
      itemBuilder: (context, index, animation) {
        var relI = index + currentOffset;
        if (relI >= widget.list.length) {
          return Container();
        }
        if ((widget.list[relI] as ListTile).title is StarRailAnimatableObj) {
          ((widget.list[relI] as ListTile).title as StarRailAnimatableObj)
              .setAnimation(animation);
        }

        return widget.list[relI];
      },
      controller: _controller,
      physics: const BouncingScrollPhysics(),
    );

    var cont = ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(scrollbars: false),
        child: StarRailScrollBar(
            controller: _controller,
            flatted: widget.flatted,
            child: GestureDetector(
                onVerticalDragUpdate: (dud) {
                  _controller.jumpTo(_controller.offset - dud.delta.dy);
                },
                onVerticalDragStart: (dud) {
                  scr = true;
                },
                onVerticalDragEnd: (dud) {
                  scr = false;
                },
                child: widget.view!)));

    return Stack(
      alignment: Alignment.topRight,
      children: [
        Column(
          children: [
          Expanded(child: cont),
          widget.innerPanel?? Container(),
          ]
        ),
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