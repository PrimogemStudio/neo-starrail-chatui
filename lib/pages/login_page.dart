import 'package:flutter/material.dart';
import 'package:neo_starrail_chatui/packs/starrail_page.dart';

import '../packs/starrail_button.dart';

class LoginPage extends StatefulWidget implements NamedPage {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => LoginPageState();

  @override
  String getName() {
    return "登录至服务器";
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
                  Navigator.of(context).pushReplacementNamed('/second');
                  /*await socketConnect();
                handlePacker(RecvAvatarPacket, AvatarManager.handle);
                socketSend(LoginPacket(
                    username: username.text, password: password.text));
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 1000),
                        pageBuilder:
                            (context, animation, secondaryAnimation) =>
                            ChatIndeterminatePage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          var a = CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeOutExpo,
                              reverseCurve: Curves.easeOutExpo);
                          return FadeTransition(
                              opacity: Tween<double>(begin: 0.0, end: 1.0)
                                  .animate(a),
                              child: SlideTransition(
                                  position: Tween<Offset>(
                                      begin: Offset(1.0, 0.0),
                                      end: Offset(0.0, 0.0))
                                      .animate(a),
                                  child: child));
                        }));*/
                })
          ])))
    );
  }
}