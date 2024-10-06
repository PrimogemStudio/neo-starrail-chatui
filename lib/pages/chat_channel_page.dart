import 'dart:math';

import 'package:flutter/material.dart';
import 'package:neo_starrail_chatui/packs/starrail_list.dart';
import 'package:neo_starrail_chatui/packs/starrail_page.dart';
import 'package:neo_starrail_chatui/pages/container/top_page_container.dart';

import '../packs/starrail_user_obj.dart';

class ChatChannelPage extends StatefulWidget implements NamedPage {
  ChatChannelPage({super.key, required this.containerState});

  TopPageContainerState containerState;

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

    for (var a in widget.containerState.widget.userObjs) {
      listKey.currentState!.pushMsg(ListTile(
        minVerticalPadding: 0,
        contentPadding: EdgeInsets.zero,
        title: a
      ));
    }
  }

  @override
  void didUpdateWidget(covariant ChatChannelPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    widget.containerState = oldWidget.containerState;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Padding(padding: const EdgeInsets.only(left: 30, right: 30), child: StarRailList(key: listKey, innerPanel: Container(), flatted: true)), floatingActionButton: FloatingActionButton(onPressed: () {
      widget.containerState.widget.userObjs.add(StarRailUserObject(
          avatar: Image.asset("assets/avatars/jack253-png.png", width: 50, height: 50),
          title: "Coder2",
          subtitle: "Test!",
          hasNewMsg: Random.secure().nextInt(2) % 2 == 0
      ));

      listKey.currentState!.removeAll();

      for (var a in widget.containerState.widget.userObjs) {
        listKey.currentState!.pushMsg(ListTile(
            minVerticalPadding: 0,
            contentPadding: EdgeInsets.zero,
            title: a
        ));
      }
    }));
  }
}