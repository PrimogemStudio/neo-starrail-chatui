import 'package:flutter/material.dart';
import 'package:neo_starrail_chatui/packs/starrail_colors.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:neo_starrail_chatui/pages/container/top_page_container.dart';

void main() {
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
      home: const MyHomePage(title: 'Flutter StarRail'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return TopPageContainer();
  }
}
