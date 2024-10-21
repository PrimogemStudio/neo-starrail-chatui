import 'package:flutter/material.dart';
import 'package:neo_starrail_chatui/controls/sr_header.dart';
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
  GlobalKey<SrHeaderState> headerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: SrHeader(key: headerKey, replyer: "", replyerDesc: null),
        ),
        body: SrList(key: listKey, invertDrag: true),
        floatingActionButton: Column(children: [
          FloatingActionButton(onPressed: () {
            listKey.currentState!.add(
                ListTile(title: SrUserButton(onPressed: () {}, data: "test")));
            listKey.currentState!.scrollToBottom();
          }),
          FloatingActionButton(onPressed: () {
            listKey.currentState!.removeAt(0);
          }),
          FloatingActionButton(onPressed: () {
            List<ListTile> d = [];
            for (int i = 0; i < 100; i++) {
              d.add(ListTile(
                  title: SrUserButton(onPressed: () {}, data: "data$i")));
            }
            listKey.currentState!.initAll(d);
          }),
          FloatingActionButton(onPressed: () {
            listKey.currentState!.loadMore();
          }),
          FloatingActionButton(onPressed: () {
            headerKey.currentState!
                .updateText("${DateTime.timestamp()}", "Test!");
          })
        ]));
  }
}
