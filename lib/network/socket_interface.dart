import 'package:neo_starrail_chatui/controls/starrail_user_obj.dart';

abstract class AbstractSocket {
  void c2sLogin(String name, String password);

  Function s2cLoginCallback = (int id) {};

  void c2sFetchChannel();

  Function s2cFetchChannelCallback = (List<StarRailUserObject> channels) {};
  Function s2cChannelNameChange = (String id, String name) {};
}
