import 'package:flutter/material.dart';
import 'package:neo_starrail_chatui/packs/starrail_button.dart';
import 'package:neo_starrail_chatui/packs/starrail_page.dart';
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
        key: GlobalKey<NavigatorState>(),
        // 定义局部路由的页面
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case '/':
              builder = (BuildContext context) => const LoginPage();
              break;
            case '/second':
              builder = (BuildContext context) => Scaffold(body: TextButton(style: srStyle, onPressed: () {
                Navigator.of(context).pushReplacementNamed("/");
              }, child: const Text("data")));
              break;
            default:
              throw Exception('Invalid route: ${settings.name}');
          }

          var i = builder(context);
          if (i is NamedPage) {
            headerKey.currentState!.updateText((i as NamedPage).getName(), null, 600);
          }

          return PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 150),
              pageBuilder:
                  (context, animation, secondaryAnimation) => builder(context),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                var a = CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutQuint,
                    reverseCurve: Curves.easeOutQuint);
                return FadeTransition(
                    opacity: Tween<double>(begin: 0.0, end: 1.0)
                        .animate(a),
                    child: SlideTransition(
                        position: Tween<Offset>(
                            begin: const Offset(1.0, 0.0),
                            end: const Offset(0.0, 0.0))
                            .animate(a),
                        child: child));
              });
        },
      )
    );
  }
}