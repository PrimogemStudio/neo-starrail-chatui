import 'package:flutter/material.dart';
import 'package:neo_starrail_chatui/controls/starrail_list.dart';
import 'package:neo_starrail_chatui/controls/starrail_page.dart';
import 'package:neo_starrail_chatui/controls/starrail_user_obj.dart';

import 'container/route_container.dart';

class ChatChannelPage extends StatefulWidget implements NamedPage {
  ChatChannelPage({super.key, required this.containerState});

  TopPageContainerState containerState;

  bool loaded = false;
  List<StarRailUserObject> userObjs = <StarRailUserObject>[];

  StarRailUserObject? findObj(String id) {
    for (var o in userObjs) {
      if (o.cid == id) return o;
    }
    return null;
  }

  @override
  String getName() {
    return "聊天频道";
  }

  @override
  String? getDesc() {
    return null;
  }

  @override
  State<StatefulWidget> createState() => ChatChannelPageState();
}

class ChatChannelPageState extends State<ChatChannelPage> {
  GlobalKey<StarRailListState> listKey = GlobalKey();
  @override
  void initState() {
    super.initState();

    Future(() {
      while (listKey.currentState == null) {}

      widget.loaded = false;
      widget.containerState.socket!.c2sFetchChannel();
      while (!widget.loaded) {}

      for (var a in widget.userObjs) {
        listKey.currentState!.appendItem(ListTile(
            minVerticalPadding: 0,
            contentPadding: EdgeInsets.zero,
            title: a
        ));
      }
    });
  }

  @override
  void didUpdateWidget(covariant ChatChannelPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    widget.userObjs = oldWidget.userObjs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: StarRailList(
                key: listKey, innerPanel: Container(), flatted: true)));
  }
}