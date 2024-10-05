import 'package:flutter/material.dart';

import '../headers/header_chatting.dart';

class ChatHeader extends StatefulWidget {
  ChatHeader({super.key, required this.replyer, required this.replyerDesc});

  String replyer;
  String replyerDesc;
  bool withDesc = false;

  AnimationController? mainAnimation;
  Animation<double>? opacityAnimation;
  Animation<Offset>? offsetAnimation;

  @override
  State<StatefulWidget> createState() => ChatHeaderState();
}

class StaticCurve extends Curve {
  @override
  double transform(double t) {
    if (t == 0.0 || t == 1.0) {
      return t;
    }
    return 1;
  }
}

class ChatHeaderState extends State<ChatHeader> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    widget.mainAnimation = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    widget.opacityAnimation =
        CurveTween(curve: Curves.easeOutExpo).animate(widget.mainAnimation!);
    widget.offsetAnimation =
        Tween<Offset>(begin: const Offset(0.15, 0), end: const Offset(0, 0))
            .animate(CurvedAnimation(
            parent: widget.mainAnimation!,
            curve: Curves.easeOutExpo,
            reverseCurve: StaticCurve()));
    widget.mainAnimation!.forward();
    updateText(() {
      widget.replyer = "聊天频道";
      widget.withDesc = false;
    });
  }

  @override
  void didUpdateWidget(covariant ChatHeader oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.mainAnimation = oldWidget.mainAnimation;
    widget.opacityAnimation = oldWidget.opacityAnimation;
    widget.offsetAnimation = oldWidget.offsetAnimation;
    widget.replyer = oldWidget.replyer;
    widget.replyerDesc = oldWidget.replyerDesc;
  }

  void updateText(Function t) async {
    var c = widget.mainAnimation!;

    c.reverse();
    Future.delayed(const Duration(milliseconds: 700), () {
      setState(() => t());
      c.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
        position: widget.offsetAnimation!,
        child: FadeTransition(
            opacity: widget.opacityAnimation!,
            child: Card(
                color: Colors.transparent,
                shadowColor: Colors.transparent,
                margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: HeaderChatting(
                    replyer: widget.replyer,
                    replyerDesc: widget.replyerDesc,
                    withDesc: widget.withDesc))));
  }
}
