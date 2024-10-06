import 'dart:math';

import 'package:flutter/material.dart';
import 'package:neo_starrail_chatui/packs/starrail_list.dart';
import 'package:neo_starrail_chatui/packs/starrail_page.dart';

import '../packs/starrail_user_obj.dart';

class ChatChannelPage extends StatefulWidget implements NamedPage {
  const ChatChannelPage({super.key});

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
  Widget build(BuildContext context) {
    return Scaffold(body: Padding(padding: const EdgeInsets.only(left: 30, right: 30), child: StarRailList(key: listKey, innerPanel: Container(), flatted: true)), floatingActionButton: FloatingActionButton(onPressed: () {
      listKey.currentState!.pushMsg(ListTile(
          minVerticalPadding: 0,
          contentPadding: EdgeInsets.zero,
          title: StarRailUserObject(
            avatar: Image.asset("assets/avatars/jack253-png.png", width: 50, height: 50),
            title: "Coder2",
            subtitle: "Test!",
            hasNewMsg: Random.secure().nextInt(2) % 2 == 0
          )
      ));
    }));
  }
}