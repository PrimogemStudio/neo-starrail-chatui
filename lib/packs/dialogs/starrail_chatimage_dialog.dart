import 'package:flutter/material.dart';

import '../starrail_colors.dart';

class StarRailChatImageDialog extends StatelessWidget {
  const StarRailChatImageDialog({super.key, required this.image});

  final ImageProvider<Object> image;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: uiDialogBg,
      contentPadding: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 10),
      titlePadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0))
      ),
      content: Stack(alignment: Alignment.bottomCenter, children: [
        Padding(padding: const EdgeInsets.only(bottom: 30), child: Image(image: image, width: MediaQuery.of(context).size.width / 2)),
        const Text("◉ 点击任意位置关闭", style: TextStyle(fontFamily: "u2400"))
      ]),
      actions: const []
    );
  }
}