import 'package:flutter/material.dart';
import 'package:neo_starrail_chatui/controls/starrail_list.dart';
import 'package:neo_starrail_chatui/controls/starrail_page.dart';

import 'container/route_container.dart';

class ChatChannelPage extends StatefulWidget implements NamedPage {
  ChatChannelPage({super.key, required this.containerState});

  TopPageContainerState containerState;

  bool loaded = false;

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

      for (var a in widget.containerState.widget.userObjs) {
        Future.delayed(const Duration(milliseconds: 50), () {
          listKey.currentState!.appendItem(ListTile(
              minVerticalPadding: 0,
              contentPadding: EdgeInsets.zero,
              title: a));
        });
      }
    });
  }

  void updateName(String id, String name) {
    setState(() {
      widget.containerState.widget.findObj(id)?.title = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: StarRailList(
                key: listKey, innerPanel: Container(), flatted: true)),
        floatingActionButton: FloatingActionButton(onPressed: () {
          widget.containerState.socket!.s2cChannelNameChange("0", "test");
        }));
  }
}