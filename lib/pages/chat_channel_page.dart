import 'package:flutter/material.dart';
import 'package:neo_starrail_chatui/packs/starrail_page.dart';

import '../packs/starrail_button.dart';

class ChatChannelPage extends StatefulWidget implements NamedPage {
  const ChatChannelPage({super.key});

  @override
  String getName() {
    return "聊天频道";
  }

  @override
  State<StatefulWidget> createState() => ChatChannelPageState();
}

class ChatChannelPageState extends State<ChatChannelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: TextButton(style: srStyle, onPressed: () {
      Navigator.of(context).pushReplacementNamed("/");
    }, child: const Text("data")));
  }
}