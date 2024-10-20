
import 'package:flutter/material.dart';
import 'package:neo_starrail_chatui/controls/starrail_animatable.dart';
import 'package:neo_starrail_chatui/controls/starrail_avatar.dart';
import 'package:neo_starrail_chatui/controls/starrail_button.dart';
import 'package:neo_starrail_chatui/controls/starrail_colors.dart';

class StarRailUserObject extends StatefulWidget
    implements StarRailAnimatableObj {
  StarRailUserObject(
      {required this.avatar,
      required this.title,
      required this.subtitle,
      required this.userdesc,
      required this.hasNewMsg,
      required this.cid})
      : super(key: GlobalKey<StarRailUserObjectState>());

  Animation<double>? animation;
  Image avatar;
  String title;
  String subtitle;
  String userdesc;
  bool hasNewMsg;
  String cid;

  @override
  void setAnimation(Animation<double> a) {
    animation = a;
  }

  @override
  State<StatefulWidget> createState() => StarRailUserObjectState();
}

class StarRailUserObjectState extends State<StarRailUserObject> {
  @override
  void didUpdateWidget(covariant StarRailUserObject oldWidget) {
    super.didUpdateWidget(oldWidget);

    widget.animation = oldWidget.animation;
    widget.avatar = oldWidget.avatar;
    widget.title = oldWidget.title;
    widget.subtitle = oldWidget.subtitle;
    widget.hasNewMsg = oldWidget.hasNewMsg;
  }

  @override
  Widget build(BuildContext context) {
    var lft = Expanded(child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
      widget.hasNewMsg ? Badge(
          offset: const Offset(0.1, 0.1),
          backgroundColor: Colors.redAccent,
          label: const Text("!"),
          isLabelVisible: true,
          child: StarRailAvatar(avatar: widget.avatar)
      ) : StarRailAvatar(avatar: widget.avatar),
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
        onPressed: () =>
            Navigator.of(context).pushNamed("/chat/uid/${widget.cid}"),
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
