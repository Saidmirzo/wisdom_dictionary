import 'package:wisdom/data/model/subscribe_model.dart';
import 'package:wisdom/data/model/verify_model.dart';

import '../../data/model/tariffs_model.dart';

abstract class ProfileRepository {
  Future<void> getTariffs();

  Future<bool> login(String phoneNumber);

  Future<VerifyModel?> verify(String phoneNumber, String smsCode, String deviceId);

  Future<bool> applyFirebaseId(String token);

  Future<SubscribeModel> subscribe(int id);

  List<TariffsModel> get tariffsModel;
}
