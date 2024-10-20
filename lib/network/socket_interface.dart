import 'package:flutter/material.dart';
import 'package:neo_starrail_chatui/controls/starrail_user_obj.dart';

abstract class AbstractSocket {
  void c2sLogin(String name, String password);

  Function s2cLoginCallback = (int id) {};

  void c2sFetchChannel();

  Function s2cFetchChannelCallback = (List<StarRailUserObject> channels) {};
  Function s2cChannelDataCallback = (String id, String? name, String? subtitle,
      Image? avatar, bool? newMsg) {};
}
