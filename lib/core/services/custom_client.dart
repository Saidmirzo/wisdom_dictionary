import 'package:jbaza/jbaza.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class CustomClient extends JClient {
  CustomClient();

  @override
  Map<String, String>? getGlobalHeaders() {
    // if (tokenModel != null && tokenModel?.access != null) {
    //   return {'token': '${tokenModel?.access}'};
    // }
    return {'token': ''};
  }

  @override
  int get unauthorized => 401;

  @override
  Future updateToken() {
    //   tokenModel = await locator<LocalViewModel>().updateToken();
    throw UnimplementedError();
  }
}

class NetWorkChecker {
  Future<bool> isNetworkAvailable() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
}
