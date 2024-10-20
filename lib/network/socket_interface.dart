abstract class AbstractSocket {
  void c2sLogin(String server, String name, String password);

  Function s2cLoginCallback = (int id) {};

  void c2sFetchChannel();

  Function s2cFetchChannelCallback = () {};
}
