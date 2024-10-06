import 'package:flutter/material.dart';
import 'package:neo_starrail_chatui/packs/starrail_list.dart';
import 'package:neo_starrail_chatui/packs/starrail_message_line.dart';
import 'package:neo_starrail_chatui/packs/starrail_page.dart';
import 'package:neo_starrail_chatui/packs/starrail_panel.dart';

class ChatPage extends StatefulWidget implements NamedPage {
  const ChatPage({super.key});

  @override
  String getName() {
    return "Coder2";
  }

  @override
  String? getDesc() {
    return "Neo StarRail ChatUI 开发者";
  }

  @override
  State<StatefulWidget> createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  GlobalKey<StarRailListState> listKey = GlobalKey();
  GlobalKey<StarRailPanelState> panelState = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: StarRailList(key: listKey, innerPanel: StarRailPanel(key: panelState, func: () {
      listKey.currentState!.appendItem(ListTile(
        title: StarRailMessageLine(
            avatar: Image.asset("assets/avatars/jack253-png.png", width: 50, height: 50),
            self: true,
            username: "Coder2",
            text: panelState.currentState!.getText(),
            msgResv: true,
            onLoadComplete: () { listKey.currentState!.scrollToBottom(); }),
      ));
    }, onMoving: () { listKey.currentState!.scrollToBottomImm(); }), flatted: false),
        floatingActionButton: Column(
            verticalDirection: VerticalDirection.up,
            children: [
              FloatingActionButton(tooltip: "返回 Channels", onPressed: () {
                Navigator.of(context).pushNamed("/channels");
              }),
              FloatingActionButton(tooltip: "打开 Panel", onPressed: () {
                panelState.currentState!.openPanel();
              })
            ]
        )
    );
  }
}