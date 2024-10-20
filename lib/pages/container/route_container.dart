import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:neo_starrail_chatui/controls/starrail_chatheader.dart';
import 'package:neo_starrail_chatui/controls/starrail_colors.dart';
import 'package:neo_starrail_chatui/controls/starrail_page.dart';
import 'package:neo_starrail_chatui/controls/starrail_page_route.dart';
import 'package:neo_starrail_chatui/controls/starrail_user_obj.dart';
import 'package:neo_starrail_chatui/network/fake_socket.dart';
import 'package:neo_starrail_chatui/network/socket_interface.dart';
import 'package:neo_starrail_chatui/pages/chat_channel_page.dart';
import 'package:neo_starrail_chatui/pages/chat_page.dart';
import 'package:neo_starrail_chatui/pages/login_page.dart';

class TopPageContainer extends StatefulWidget {
  TopPageContainer({super.key});

  final List<StarRailUserObject> userObjs = <StarRailUserObject>[];

  StarRailUserObject? findObj(String id) {
    for (var o in userObjs) {
      if (o.cid == id) return o;
    }
    return null;
  }

  @override
  State<StatefulWidget> createState() => TopPageContainerState();
}

class TopPageContainerState extends State<TopPageContainer> {
  GlobalKey<StarRailChatHeaderState> headerKey = GlobalKey();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  ChatChannelPage? channelPage;

  Map<String, ChatPage> pages = {};

  double blursize = 0;

  AbstractSocket? socket;

  final String PREFIX = "/chat/uid/";

  @override
  Widget build(BuildContext context) {
    var i = Scaffold(
      appBar: AppBar(
          backgroundColor: uiSurfaceColor,
          shadowColor: Colors.transparent,
          elevation: 0,
            title: StarRailChatHeader(
                key: headerKey, replyer: "", replyerDesc: ""),
            scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent),
      body: Navigator(
        key: navigatorKey,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;

            if (settings.name == "/") {
              builder =
                  (BuildContext context) => LoginPage(containerState: this);
            } else if (settings.name == "/channels") {
              builder = (BuildContext context) {
                channelPage ??= ChatChannelPage(containerState: this);
                return channelPage!;
              };
            } else if (settings.name!.startsWith(PREFIX)) {
              var i = settings.name!.replaceAll(PREFIX, "");
              if (!pages.containsKey(i)) {
                pages[i] = ChatPage(
                    containerState: this,
                    name: widget.findObj(i)?.title ?? "",
                    desc: widget.findObj(i)?.userdesc);
              } else {
                pages[i]?.name = widget.findObj(i)?.title ?? "";
                pages[i]?.desc = widget.findObj(i)?.userdesc;
              }

              builder = (BuildContext context) => pages[i]!;
          }
          else { throw Exception("No page named ${settings.name}"); }

          var i = builder(context);
          if (i is NamedPage && headerKey.currentState != null) {
            headerKey.currentState!.updateText((i as NamedPage).getName(), (i as NamedPage).getDesc());
          }

            return genBuilder(
                builder, settings.name!.startsWith(PREFIX) ? 0 : 0.1, 300);
          },
        ));

    return ImageFiltered(imageFilter: ImageFilter.blur(sigmaX: blursize, sigmaY: blursize), child: i);
  }

  void updateBlur(double v) {
    setState(() {
      blursize = v;
    });
  }

  void initSoc() {
    socket = FakeSocket();
    socket!.s2cLoginCallback =
        (int i) => navigatorKey.currentState!.pushReplacementNamed('/channels');
    socket!.s2cFetchChannelCallback = (List<StarRailUserObject> l) {
      widget.userObjs.clear();
      widget.userObjs.addAll(l);
      channelPage!.loaded = true;
    };
    socket!.s2cChannelNameChange = (String id, String name) {
      widget.findObj(id)?.title = name;
    };
  }
}