import 'package:flutter/material.dart';
import 'package:neo_starrail_chatui/controls/sr_list.dart';
import 'package:neo_starrail_chatui/controls/sr_userbutton.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: "StarRailFont_bundle",
        fontFamilyFallback: const ["u2400"]
      ),
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
  GlobalKey<SrListState> listKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
        body: SrList(key: listKey, invertDrag: true),
        floatingActionButton: FloatingActionButton(onPressed: () {
          listKey.currentState!
              .add(ListTile(title: SrUserButton(onPressed: () {})));
        }));
  }
}
