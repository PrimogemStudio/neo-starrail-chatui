import 'package:flutter/material.dart';
import 'package:neo_starrail_chatui/packs/starrail_button.dart';
import 'package:neo_starrail_chatui/packs/starrail_page.dart';
import 'package:neo_starrail_chatui/packs/starrail_page_route.dart';
import 'package:neo_starrail_chatui/pages/chat_channel_page.dart';
import 'package:neo_starrail_chatui/pages/chat_page.dart';
import 'package:neo_starrail_chatui/pages/login_page.dart';

import '../../packs/starrail_chatheader.dart';
import '../../packs/starrail_colors.dart';

class TopPageContainer extends StatefulWidget {
  const TopPageContainer({super.key});

  @override
  State<StatefulWidget> createState() => TopPageContainerState();
}

class TopPageContainerState extends State<TopPageContainer> {
  GlobalKey<ChatHeaderState> headerKey = GlobalKey();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          else if (settings.name == "/channels") { builder = (BuildContext context) => const ChatChannelPage(); }
          else if (settings.name!.startsWith("/chat/uid/")) {
            print(settings.name!.replaceAll("/chat/uid/", ""));
            builder = (BuildContext context) => const ChatPage();
          }
          else { throw Exception("No page named ${settings.name}"); }

          var i = builder(context);
          if (i is NamedPage && headerKey.currentState != null) {
            headerKey.currentState!.updateText((i as NamedPage).getName(), (i as NamedPage).getDesc(), 600);
          }

          return genBuilder(builder);
        },
      )
    );
  }

  void loginReq(String server, String name, String password) {
    print("$server $name $password");
    navigatorKey.currentState!.pushReplacementNamed('/channels');
  }
}