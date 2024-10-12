
import 'package:flutter/material.dart';
import 'package:neo_starrail_chatui/packs/starrail_list.dart';
import 'package:neo_starrail_chatui/packs/starrail_message_line.dart';
import 'package:neo_starrail_chatui/packs/starrail_page.dart';
import 'package:neo_starrail_chatui/packs/starrail_panel.dart';
import 'package:neo_starrail_chatui/pages/container/top_page_container.dart';

class ChatPage extends StatefulWidget implements NamedPage {
  ChatPage({super.key, required this.containerState});

  TopPageContainerState containerState;
  List<ListTile> msgs = [];

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
  GlobalKey<StarRailPanelState> panelKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    Future(() {
      while (listKey.currentState == null) {}

      listKey.currentState!.appendAll(widget.msgs);

      WidgetsBinding.instance.addPostFrameCallback((t) { listKey.currentState!.updateList() ;listKey.currentState!.scrollToBottomImmFast(); });
    });
  }

  @override
  void didUpdateWidget(covariant ChatPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    widget.msgs = oldWidget.msgs;
    widget.containerState = oldWidget.containerState;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: StarRailList(key: listKey, innerPanel: StarRailPanel(key: panelKey, func: () {
      var i = ListTile(
        title: StarRailMessageLine(
            avatar: Image.asset("assets/avatars/jack253-png.png", width: 50, height: 50),
            self: true,
            username: "Coder2",
            text: panelKey.currentState!.getText(),
            msgResv: true,
            onLoadComplete: () { listKey.currentState!.scrollToBottom(); },
            image: const NetworkImage("https://www.imagehub.cc/content/images/system/home_cover_1670160663727_f2dcdb.jpeg"),
            onImagePressed: (v) { widget.containerState.updateBlur(v); }
        ),
      );
      widget.msgs.add(i);
      listKey.currentState!.appendItem(i);
    }, onMoving: () { listKey.currentState!.scrollToBottomImm(); }), flatted: false),
        floatingActionButton: Column(
            verticalDirection: VerticalDirection.up,
            children: [
              FloatingActionButton(tooltip: "返回 Channels", onPressed: () {
                Navigator.of(context).pushNamed("/channels");
              }),
              FloatingActionButton(tooltip: "打开 Panel", onPressed: () {
                panelKey.currentState!.openPanel();
              })
            ]
        )
    );
  }
}