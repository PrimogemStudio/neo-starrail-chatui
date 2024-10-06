import 'package:flutter/material.dart';
import 'package:neo_starrail_chatui/packs/starrail_button.dart';
import 'package:neo_starrail_chatui/packs/starrail_page.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: TextButton(onPressed: () {
      Navigator.of(context).pushReplacementNamed("/channels");
    }, style: srStyle, child: const Text("data")));
  }
}