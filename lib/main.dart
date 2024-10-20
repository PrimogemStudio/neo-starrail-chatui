import 'package:flutter/material.dart';
import 'package:neo_starrail_chatui/controls/sr_scrollbar.dart';

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
  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
        body: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(scrollbars: false),
            child: StarRailScrollBar(
                controller: controller,
                flatted: false,
                child: ListView.builder(
                    itemBuilder: (a, b) {
                      return Text("$b");
                    },
                    itemCount: 100,
                    controller: controller))));
  }
}
