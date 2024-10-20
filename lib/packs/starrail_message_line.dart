import 'dart:math';

import 'package:flutter/material.dart';
import 'package:neo_starrail_chatui/packs/dialogs/starrail_chatimage_dialog.dart';
import 'package:neo_starrail_chatui/packs/starrail_animatable.dart';
import 'package:neo_starrail_chatui/packs/starrail_avatar.dart';
import 'package:neo_starrail_chatui/packs/starrail_button.dart';
import 'package:neo_starrail_chatui/packs/starrail_colors.dart';
import 'package:neo_starrail_chatui/packs/starrail_dialog.dart';
import 'package:neo_starrail_chatui/packs/starrail_rounded_rect.dart';

class StarRailMessageLine extends StatefulWidget
    implements StarRailAnimatableObj {
  StarRailMessageLine(
      {
        super.key,
        required this.avatar,
        required this.self,
        required this.username,
        required this.text,
        required this.msgResv,
        required this.onLoadComplete,
        required this.image,
        required this.onImagePressed
      }) {
    if (self) msgResv = true;
  }

  Image avatar;
  final bool self;
  String username;
  final String text;
  final Function onLoadComplete;
  final ImageProvider<Object>? image;
  final Function onImagePressed;
  Animation<double>? animation;
  AnimationController? mainAnimation;
  AnimationController? msgAnimation;
  bool msgResv;

  @override
  State<StarRailMessageLine> createState() => StarRailMessageLineState();

  @override
  void setAnimation(Animation<double> a) {
    if (animation != null) return;
    animation = a;
  }
}

class StarRailMessageLineState extends State<StarRailMessageLine> with TickerProviderStateMixin {
  double o = 0;
  double o2 = 0;
  double o3 = 0;

  static double toO(double d) {
    return (sin(d * 3.1415926 * 2) + 1) / 2;
  }

  @override
  void dispose() {
    widget.mainAnimation?.dispose();
    widget.msgAnimation?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    widget.mainAnimation = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    widget.msgAnimation = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));

    widget.mainAnimation!.addListener(() {
      setState(() {
        o = toO(-widget.mainAnimation!.value - 0.1);
        o2 = toO(-widget.mainAnimation!.value);
        o3 = toO(-widget.mainAnimation!.value + 0.1);
      });
    });
    if (!widget.self) widget.mainAnimation!.repeat();
    Future.delayed(
        Duration(
            milliseconds: min(
                (widget.text.length + widget.username.length) * 30 + 100,
                3000)), () {
      bool t = widget.msgResv;
      widget.msgResv = true;
      if (!t) widget.onLoadComplete();
    });
  }

  @override
  Widget build(BuildContext context) {
    final msgMain = Card(
        margin: const EdgeInsets.only(top: 10),
        shadowColor: Colors.transparent,
        color: Colors.transparent,
        child: Row(children: [
          const Padding(padding: EdgeInsets.all(5)),
          RoundedRect(
              width: 10,
              height: 10,
              radius: 10,
              color: Colors.black.withOpacity(o)),
          const Padding(padding: EdgeInsets.all(1)),
          RoundedRect(
              width: 10,
              height: 10,
              radius: 10,
              color: Colors.black.withOpacity(o2)),
          const Padding(padding: EdgeInsets.all(1)),
          RoundedRect(
              width: 10,
              height: 10,
              radius: 10,
              color: Colors.black.withOpacity(o3)),
        ]));

    if (widget.msgResv) {
      widget.mainAnimation!.stop();
      widget.msgAnimation!.forward();
    }

    final msgMain2 = Card(
        elevation: 0,
        color: uiMsgShadow,
        margin: widget.self
            ? const EdgeInsets.fromLTRB(0, 0, 10, 5)
            : const EdgeInsets.fromLTRB(10, 5, 0, 0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: widget.self
                    ? const Radius.circular(10)
                    : const Radius.circular(0),
                topRight: widget.self
                    ? const Radius.circular(0)
                    : const Radius.circular(10),
                bottomLeft: const Radius.circular(10),
                bottomRight: const Radius.circular(11.5))),
        child: Card(
            elevation: 0,
            color: widget.self ? uiMsgMainSlf : uiMsgMainOth,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: widget.self
                        ? const Radius.circular(10)
                        : const Radius.circular(0),
                    topRight: widget.self
                        ? const Radius.circular(0)
                        : const Radius.circular(10),
                    bottomLeft: const Radius.circular(10),
                    bottomRight: const Radius.circular(10))),
            margin: widget.self
                ? const EdgeInsets.fromLTRB(0, 0, 0.75, 2)
                : const EdgeInsets.fromLTRB(0.75, 0, 0, 2),
            child: Card(
                color: Colors.transparent,
                shadowColor: Colors.transparent,
                margin: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                child: Container(
                  constraints: const BoxConstraints(minWidth: 10),
                  child: Text(
                    widget.text,
                    style: const TextStyle(color: Colors.black, fontSize: 16.0),
                  )
                ))));

    var msgMainI = widget.image != null ? Padding(padding: const EdgeInsets.only(left: 10, right: 10, top: 3), child: TextButton(onPressed: () {
      showSrDialog(context, (v) { widget.onImagePressed(v); }, StarRailChatImageDialog(image: widget.image!));
    }, style: srStyleImage, child: Image(image: widget.image!, width: 300))) : Container();
    return Padding(
        padding: const EdgeInsets.only(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: widget.self ? TextDirection.rtl : TextDirection.ltr,
          children: <Widget>[
            SlideTransition(
                position: Tween<Offset>(
                        begin: const Offset(0, 0.7), end: const Offset(0, 0))
                    .animate(CurvedAnimation(
                        parent: widget.animation!,
                        curve: Curves.easeOutBack,
                        reverseCurve: Curves.easeOutBack)),
                child:
                    FadeTransition(opacity: widget.animation!, child: StarRailAvatar(avatar: widget.avatar))),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: widget.self ? TextDirection.rtl : TextDirection.ltr,
              children: <Widget>[
                Card(
                    color: Colors.transparent,
                    shadowColor: Colors.transparent,
                    margin: widget.self
                        ? const EdgeInsets.fromLTRB(0, 0, 10, 5)
                        : const EdgeInsets.fromLTRB(10, 5, 0, 0),
                    child: FadeTransition(
                        opacity: widget.animation!,
                        child: Text(widget.username, style: TextStyle(color: uiMsgSrc)))),
                Stack(
                    textDirection: widget.self ? TextDirection.rtl : TextDirection.ltr,
                    children: [
                      FadeTransition(
                          opacity: widget.animation!, child: msgMain),
                      widget.msgResv
                          ? FadeTransition(
                              opacity: widget.msgAnimation!, child: widget.image != null ? msgMainI : msgMain2)
                          : Container()
                    ])
              ],
            ))
          ],
        ));
  }
}
