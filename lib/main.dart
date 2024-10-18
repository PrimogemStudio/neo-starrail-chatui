import 'dart:async';

import 'package:flutter/material.dart';
import 'package:neo_starrail_chatui/controls/sr_scroll_bar.dart';

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
        useMaterial3: true
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
  var c = ScrollController();

  var scr = false;

  late Timer timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(milliseconds: 16), (_) {
      if (scr) c.jumpTo(c.offset);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: GestureDetector(
          child: SrScrollBar(
            controller: c,
            child: ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(scrollbars: false),
                child: ListView.builder(
                    itemBuilder: (i, b) { return Text("$b"); },
                    physics: const BouncingScrollPhysics(),
                    itemCount: 100,
                    controller: c
                )
            )
          ),
          onVerticalDragUpdate: (dud) { c.jumpTo(c.offset - dud.delta.dy); },
          onVerticalDragStart: (dud) { scr = true; },
          onVerticalDragEnd: (dud) { scr = false; },
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          c.jumpTo(-200);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
