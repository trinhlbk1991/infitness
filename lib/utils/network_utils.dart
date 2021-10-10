import 'package:connectivity/connectivity.dart';

class NetworkUtils {
  NetworkUtils._();

  static Stream<ConnectivityResult> get onConnectivityChanged {
    return Connectivity().onConnectivityChanged;
  }

  static Future<bool> hasInternet() =>
      Connectivity().checkConnectivity().then((value) =>
          value == ConnectivityResult.mobile ||
          value == ConnectivityResult.wifi);
}
