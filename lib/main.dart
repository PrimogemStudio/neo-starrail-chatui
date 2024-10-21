import 'package:flutter/material.dart';
import 'package:neo_starrail_chatui/page/container/navigator_top.dart';

import 'controls/sr_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.light(surface: uiSurfaceColor),
          useMaterial3: true,
        fontFamily: "StarRailFont_bundle",
        fontFamilyFallback: const ["u2400"]
      ),
        home: const NavigatorTop());
  }
}
