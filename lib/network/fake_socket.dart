import 'dart:io';

import 'package:flutter/material.dart';
import 'package:neo_starrail_chatui/network/socket_interface.dart';

import '../controls/starrail_user_obj.dart';

class FakeSocket extends AbstractSocket {
  int i = 3;

  @override
  void c2sFetchChannel() {
    List<StarRailUserObject> l = [];
    for (int _ = 0; _ < i; _++) {
      c2sFetchAvatar("coder2");
      while (!uiInternalCheckAvatarCallback("coder2")) {}

      l.add(StarRailUserObject(
        avatar: uiInternalAvatarCallback("coder2"),
        title: "Coder2",
        subtitle: "Test!",
        userdesc: "Neo StarRail ChatUI 开发者",
        hasNewMsg: _ % 2 == 0,
        cid: "$_",
      ));
    }
    s2cFetchChannelCallback(l);
  }

  @override
  void c2sFetchAvatar(String id) {
    if (uiInternalCheckAvatarCallback(id)) return;

    sleep(const Duration(milliseconds: 1000));
    s2cAvatarUpdateCallback(id,
        Image.asset("assets/avatars/jack253-png.png", width: 50, height: 50));
  }

  @override
  void c2sLogin(String name, String password) {
    print("Login: \"$name\" \"$password\"");
    s2cLoginCallback("test");
  }
}
