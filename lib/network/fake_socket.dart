import 'dart:math';

import 'package:flutter/material.dart';
import 'package:neo_starrail_chatui/network/socket_interface.dart';

import '../controls/starrail_user_obj.dart';

class FakeSocket extends AbstractSocket {
  int i = 3;

  @override
  void c2sFetchChannel() {
    List<StarRailUserObject> l = [];
    for (int _ = 0; _ < i; _++) {
      l.add(StarRailUserObject(
        avatar: Image.asset("assets/avatars/jack253-png.png",
            width: 50, height: 50),
        title: "Coder2",
        subtitle: "Test!",
        userdesc: "Neo StarRail ChatUI 开发者",
        hasNewMsg: Random.secure().nextInt(2) % 2 == 0,
        cid: "$_",
      ));
    }
    s2cFetchChannelCallback(l);
  }

  @override
  void c2sLogin(String name, String password) {
    print("Login: \"$name\" \"$password\"");
    s2cLoginCallback(Random().nextInt(16384));
  }
}
