import 'package:flutter/material.dart';

class HeaderChatting extends StatelessWidget {
  HeaderChatting({
    super.key,
    required this.replyer,
    required this.replyerDesc,
    required this.withDesc
  });

  String replyer;
  String replyerDesc;
  bool withDesc;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(replyer, style: TextStyle(fontSize: withDesc ? 18 : 20)),
          withDesc ? Text(replyerDesc, style: const TextStyle(fontSize: 13, color: Colors.grey)) : Container()
        ]);
  }
}