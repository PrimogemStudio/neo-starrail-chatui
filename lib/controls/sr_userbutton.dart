import 'package:flutter/material.dart';
import 'package:neo_starrail_chatui/controls/sr_animatableobject.dart';
import 'package:neo_starrail_chatui/controls/sr_buttonstyles.dart';

class SrUserButton extends StatefulWidget implements SrAnimatedObject {
  SrUserButton({super.key, required this.onPressed, required this.data});

  final VoidCallback onPressed;
  final String data;

  Animation<double>? animation;

  @override
  void setAnimation(Animation<double> a) {
    animation = a;
  }

  @override
  State<StatefulWidget> createState() => SrUserButtonState();
}

class SrUserButtonState extends State<SrUserButton> {
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: widget.animation!,
        child: TextButton(
            onPressed: widget.onPressed,
            style: srStyleList,
            child: Text(widget.data)));
  }
}
