
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:neo_starrail_chatui/controls/starrail_colors.dart';
import 'package:neo_starrail_chatui/pages/container/route_container.dart';

void main() async {
  timeDilation = 1.5;
  runApp(const ClipRRect(borderRadius: BorderRadius.only(topRight: Radius.circular(30)), child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter StarRail',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.light(surface: uiSurfaceColor),
          useMaterial3: true,
          fontFamily: "StarRailFont_bundle"),
      home: TopPageContainer(),
    );
  }
}