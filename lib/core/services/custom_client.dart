import 'package:jbaza/jbaza.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:wisdom/config/constants/constants.dart';
import 'package:wisdom/core/db/preference_helper.dart';

class CustomClient extends JClient {
  CustomClient({required this.sharedPreferenceHelper});

  final SharedPreferenceHelper sharedPreferenceHelper;

  @override
  Map<String, String>? getGlobalHeaders() {
    var token = sharedPreferenceHelper.getString(Constants.KEY_TOKEN, '');
    if (token != '') {
      return {'token': token};
    }
    return {'token': ''};
  }

  @override
  int get unauthorized => 401;

  @override
  Future updateToken() {
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
