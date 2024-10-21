import 'package:flutter/material.dart';
import 'package:neo_starrail_chatui/controls/sr_buttonstyles.dart';

class SrUserButton extends StatefulWidget {
  const SrUserButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  State<StatefulWidget> createState() => SrUserButtonState();
}

class SrUserButtonState extends State<SrUserButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: widget.onPressed,
        style: srStyleList,
        child: const Text("data"));
  }
}
