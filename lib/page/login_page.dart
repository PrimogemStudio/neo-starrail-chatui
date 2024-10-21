import 'package:flutter/material.dart';
import 'package:neo_starrail_chatui/controls/sr_buttonstyles.dart';
import 'package:neo_starrail_chatui/main.dart';
import 'package:neo_starrail_chatui/network/fake_socket.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  var username = TextEditingController();
  var password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DropdownButton(
                          items: const [DropdownMenuItem(child: Text("本地服务端"))],
                          onChanged: (a) {}),
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
                            socket = FakeSocket();
                            var i =
                                socket!.c2sLogin(username.text, password.text);
                            Navigator.of(context).pushReplacementNamed("//");
                            print(await i);
                          })
                    ]))));
  }
}