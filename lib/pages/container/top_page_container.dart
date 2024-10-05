import 'package:flutter/material.dart';
import 'package:neo_starrail_chatui/pages/login_page.dart';

import '../../packs/starrail_chatheader.dart';
import '../../packs/starrail_colors.dart';

class TopPageContainer extends StatefulWidget {
  const TopPageContainer({super.key});

  @override
  State<StatefulWidget> createState() => TopPageContainerState();
}

class TopPageContainerState extends State<TopPageContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: uiSurfaceColor,
          shadowColor: Colors.transparent,
          elevation: 0,
          title: ChatHeader(replyer: "", replyerDesc: ""),
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent),
      body: const LoginPage()
    );
  }
}