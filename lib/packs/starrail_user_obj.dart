import 'dart:math';

import 'package:flutter/material.dart';
import 'package:neo_starrail_chatui/packs/starrail_animatable.dart';
import 'package:neo_starrail_chatui/packs/starrail_button.dart';
import 'package:neo_starrail_chatui/packs/starrail_colors.dart';

class StarRailUserObject extends StatefulWidget implements AnimatableObj {
  StarRailUserObject({super.key, required this.avatar, required this.title, required this.subtitle});

  Animation<double>? animation;
  Image avatar;
  String title;
  String subtitle;

  @override
  void setAnimation(Animation<double> a) {
    animation = a;
  }

  @override
  State<StatefulWidget> createState() => StarRailUserObjectState();
}

class StarRailUserObjectState extends State<StarRailUserObject> {
  @override
  Widget build(BuildContext context) {
    var lft = Expanded(child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
      widget.avatar,
      Expanded(child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title),
                Text(widget.subtitle, style: TextStyle(color: uiMsgSrc))
              ])))
    ]));
    var ri = const Icon(Icons.arrow_forward_ios_rounded, size: 14);
    var m = Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Expanded(child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [lft])),
      Expanded(child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [ri])),
    ]);
    var b = TextButton(
        onPressed: () {},
        style: srStyleList,
        child: FadeTransition(
          opacity: widget.animation!,
          child: Padding(padding: const EdgeInsets.only(top: 5, bottom: 5), child: m)
        ));
    return Column(children: [
      b,
      Container(
        height: 1,
        color: uiViewSplitI,
      )
    ]);
  }
}
