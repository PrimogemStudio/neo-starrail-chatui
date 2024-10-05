import 'package:flutter/material.dart';
import 'package:neo_starrail_chatui/packs/starrail_colors.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:neo_starrail_chatui/packs/starrail_list.dart';
import 'package:neo_starrail_chatui/packs/starrail_message_line.dart';

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  GlobalKey<StarRailListState> listKey = GlobalKey();
  void _incrementCounter() {
    setState(() {
      listKey.currentState!.pushMsg(ListTile(title: StarRailMessageLine(
          avatar: Image.asset("assets/avatars/jack253-png.png",
              width: 50.0, height: 50.0),
          self: true,
          username: "Coder2",
          text: "test!",
          msgResv: false,
          onLoadComplete: () {
            setState(() {
              listKey.currentState!.scrollToBottom();
            });
          })));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: StarRailList(key: listKey, innerPanel: Container()),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
