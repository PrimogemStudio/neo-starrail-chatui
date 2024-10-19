import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:neo_starrail_chatui/packs/starrail_animatable.dart';
import 'package:neo_starrail_chatui/packs/starrail_rounded_rect.dart';

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

    _controller.addListener(() {
      final scrollDirection = _controller.position.userScrollDirection;
      if (scrollDirection != ScrollDirection.idle) {
        double scrollEnd = _controller.offset +
            (scrollDirection == ScrollDirection.reverse ? -50 : 50);
        if (_controller.offset == _controller.position.minScrollExtent ||
            _controller.offset == _controller.position.maxScrollExtent) return;
        _controller.jumpTo(scrollEnd);
      }
    });
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
        if ((widget.list[relI] as ListTile).title is AnimatableObj) {
          ((widget.list[relI] as ListTile).title as AnimatableObj).setAnimation(animation);
        }

        return widget.list[relI];
      },
      controller: _controller,
      physics: const BouncingScrollPhysics(),
    );

    final viewpanel = ScrollConfiguration(
        behavior:
        const ScrollBehavior().copyWith(scrollbars: false),
        child: widget.view!);

    return Stack(
      alignment: Alignment.topRight,
      children: [
        Column(
          children: [
            Expanded(child: viewpanel),
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