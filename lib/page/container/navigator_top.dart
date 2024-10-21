import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:neo_starrail_chatui/controls/sr_page_funcs.dart';

import '../../controls/sr_colors.dart';
import '../../controls/sr_header.dart';
import '../login_page.dart';

class NavigatorTop extends StatefulWidget {
  const NavigatorTop({super.key});

  @override
  State<StatefulWidget> createState() => NavigatorTopState();
}

class NavigatorTopState extends State<NavigatorTop> {
  GlobalKey<SrHeaderState> headerKey = GlobalKey();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: uiSurfaceColor,
          shadowColor: Colors.transparent,
          elevation: 0,
          title: SrHeader(key: headerKey, replyer: "", replyerDesc: ""),
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent),
      body: Navigator(
        key: navigatorKey,
        onGenerateRoute: (RouteSettings settings) => genRoute(settings),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        navigatorKey.currentState!.pushReplacementNamed("/");
      }),
    );
  }

  PageRouteBuilder genRoute(RouteSettings settings) {
    return genBuilder((BuildContext context) {
      if (settings.name == "/") {
        return const LoginPage();
      } else if (settings.name == "/logging") {
        return Scaffold(
            body: Center(
                child: LoadingAnimationWidget.waveDots(
                    color: uiBtnBorder, size: 100)));
      } else {
        return Scaffold(body: Text(settings.name!));
      }
    }, 0.1, 300);
  }
}
