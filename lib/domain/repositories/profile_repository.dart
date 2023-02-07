import 'package:wisdom/data/model/verify_model.dart';

import '../../data/model/tariffs_model.dart';

abstract class ProfileRepository {
  Future<void> getTariffs();

  Future<bool> login(String phoneNumber);

  Future<VerifyModel?> verify(String phoneNumber, String smsCode, String deviceId);

  List<TariffsModel> get tariffsModel;
}
