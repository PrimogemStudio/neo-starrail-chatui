import 'package:flutter/material.dart';
import 'package:neo_starrail_chatui/packs/starrail_button.dart';
import 'package:neo_starrail_chatui/packs/starrail_list.dart';
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
    return Scaffold(body: StarRailList(key: listKey, innerPanel: StarRailPanel(key: panelState, func: () {}, onMoving: () { listKey.currentState!.scrollToBottomImm(); }), flatted: false),
        floatingActionButton: Column(
            verticalDirection: VerticalDirection.up,
            children: [
              FloatingActionButton(onPressed: () {
                Navigator.of(context).pushReplacementNamed("/channels");
              }),
              FloatingActionButton(onPressed: () {
                panelState.currentState!.openPanel();
              })
            ]
        )
    );
  }
}