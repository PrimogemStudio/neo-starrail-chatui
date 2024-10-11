import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:neo_starrail_chatui/packs/starrail_page.dart';
import 'package:neo_starrail_chatui/packs/starrail_page_route.dart';
import 'package:neo_starrail_chatui/pages/chat_channel_page.dart';
import 'package:neo_starrail_chatui/pages/chat_page.dart';
import 'package:neo_starrail_chatui/pages/login_page.dart';

import '../../packs/starrail_chatheader.dart';
import '../../packs/starrail_colors.dart';
import '../../packs/starrail_user_obj.dart';

class TopPageContainer extends StatefulWidget {
  TopPageContainer({super.key});

  List<StarRailUserObject> userObjs = <StarRailUserObject>[];

  @override
  State<StatefulWidget> createState() => TopPageContainerState();
}

class TopPageContainerState extends State<TopPageContainer> {
  GlobalKey<ChatHeaderState> headerKey = GlobalKey();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  Map<String, ChatPage> pages = {};

  double blursize = 0;

  @override
  Widget build(BuildContext context) {
    var i = Scaffold(
      appBar: AppBar(
          backgroundColor: uiSurfaceColor,
          shadowColor: Colors.transparent,
          elevation: 0,
          title: ChatHeader(key: headerKey, replyer: "", replyerDesc: ""),
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent),
      body: Navigator(
        key: navigatorKey,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;

          if (settings.name == "/") { builder = (BuildContext context) => LoginPage(containerState: this); }
          else if (settings.name == "/channels") { builder = (BuildContext context) => ChatChannelPage(containerState: this); }
          else if (settings.name!.startsWith("/chat/uid/")) {
            var i = settings.name!.replaceAll("/chat/uid/", "");
            if (!pages.containsKey(i)) {
              pages[i] = ChatPage(containerState: this);
            }

            builder = (BuildContext context) => pages[i]!;
          }
          else { throw Exception("No page named ${settings.name}"); }

          var i = builder(context);
          if (i is NamedPage && headerKey.currentState != null) {
            headerKey.currentState!.updateText((i as NamedPage).getName(), (i as NamedPage).getDesc());
          }

          return genBuilder(builder, settings.name!.startsWith("/chat/uid/") ? 0 : 0.1, 300);
        },
      )
    );

    return ImageFiltered(imageFilter: ImageFilter.blur(sigmaX: blursize, sigmaY: blursize), child: i);
  }

  void updateBlur(double v) {
    setState(() {
      blursize = v;
    });
  }

  void loginReq(String server, String name, String password) {
    print("$server $name $password");
    navigatorKey.currentState!.pushReplacementNamed('/channels');
  }
}