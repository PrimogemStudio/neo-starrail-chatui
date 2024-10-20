import 'dart:math';

import 'package:flutter/material.dart';
import 'package:neo_starrail_chatui/controls/starrail_list.dart';
import 'package:neo_starrail_chatui/controls/starrail_page.dart';
import 'package:neo_starrail_chatui/controls/starrail_user_obj.dart';
import 'package:neo_starrail_chatui/pages/container/route_container.dart';

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

    Future(() {
      while (listKey.currentState == null) {}

      for (var a in widget.containerState.widget.userObjs) {
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

    widget.containerState = oldWidget.containerState;
  }

  @override
  Widget build(BuildContext context) {
    var i = Scaffold(body: Padding(padding: const EdgeInsets.only(left: 30, right: 30), child: StarRailList(key: listKey, innerPanel: Container(), flatted: true)), floatingActionButton: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      verticalDirection: VerticalDirection.up,
      children: [
        FloatingActionButton(tooltip: "新增 Channel", onPressed: () {
          widget.containerState.widget.userObjs.add(StarRailUserObject(
                      avatar: Image.asset("assets/avatars/jack253-png.png",
                          width: 50, height: 50),
                      title: "Coder2",
                      subtitle: "Test!",
                      hasNewMsg: Random.secure().nextInt(2) % 2 == 0,
                      cid: "0",
                    ));

          listKey.currentState!.appendItem(ListTile(
              minVerticalPadding: 0,
              contentPadding: EdgeInsets.zero,
              title: widget.containerState.widget.userObjs.last
          ));
        }), 
        FloatingActionButton(tooltip: "删除 Channel", onPressed: () {
          int i = widget.containerState.widget.userObjs.length - 1;
          widget.containerState.widget.userObjs.removeAt(i);
          listKey.currentState!.removeItemAt(i);
        })
      ]
    ));

    return i;
  }
}