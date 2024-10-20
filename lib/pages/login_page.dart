import 'package:flutter/material.dart';
import 'package:neo_starrail_chatui/controls/starrail_button.dart';
import 'package:neo_starrail_chatui/controls/starrail_page.dart';
import 'package:neo_starrail_chatui/pages/container/route_container.dart';

class LoginPage extends StatefulWidget implements NamedPage {
  LoginPage({super.key, required this.containerState});

  TopPageContainerState containerState;
  @override
  State<StatefulWidget> createState() => LoginPageState();

  @override
  String getName() {
    return "登录至服务器";
  }

  @override
  String? getDesc() {
    return null;
  }
}

class LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextField(
                controller: username,
                decoration: const InputDecoration(
                  hintText: '用户名',
                )),
            const Padding(padding: EdgeInsets.all(5)),
            TextField(
                controller: password,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: '密码',
                )),
            const Padding(padding: EdgeInsets.all(5)),
            ElevatedButton(
                style: srStyle,
                child: const Text('登录'),
                onPressed: () async {
                            widget.containerState.initSoc();
                            widget.containerState.socket!
                                .c2sLogin(username.text, password.text);
                          })
          ])))
    );
  }
}