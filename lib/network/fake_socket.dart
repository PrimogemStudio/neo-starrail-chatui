import 'package:neo_starrail_chatui/network/abstract_socket.dart';

class FakeSocket extends AbstractSocket {
  @override
  Future<String> c2sLogin(String name, String password) async {
    return Future.delayed(
        const Duration(milliseconds: 700), () => "$password@$name");
  }
}
