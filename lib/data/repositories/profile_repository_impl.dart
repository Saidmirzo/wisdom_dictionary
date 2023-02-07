import 'dart:convert';

import 'package:wisdom/config/constants/urls.dart';
import 'package:wisdom/core/domain/http_is_success.dart';
import 'package:wisdom/core/services/custom_client.dart';
import 'package:wisdom/data/model/tariffs_model.dart';
import 'package:wisdom/data/model/verify_model.dart';
import 'package:wisdom/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  ProfileRepositoryImpl(this.customClient);

  final CustomClient customClient;

  List<TariffsModel> _tariffsModel = [];

  @override
  Future<void> getTariffs() async {
    _tariffsModel.clear();
    var response = await customClient.get(Urls.getTariffs);
    if (response.isSuccessful) {
      for (var item in jsonDecode(response.body)['tariffs']) {
        _tariffsModel.add(TariffsModel.fromJson(item));
      }
    }
  }

  @override
  Future<bool> login(String phoneNumber) async {
    var response = await customClient.post(Urls.login, body: {'phone': phoneNumber});
    if (response.isSuccessful) {
      return jsonDecode(response.body)['status'];
    }
    return false;
  }

  @override
  List<TariffsModel> get tariffsModel => _tariffsModel;

  @override
  Future<VerifyModel?> verify(String phoneNumber, String smsCode, String deviceId) async {
    var response = await customClient.post(
      Urls.verify,
      body: {
        'phone': phoneNumber,
        'verify_code': smsCode,
        'phone_id': deviceId,
      },
    );
    if (response.isSuccessful) {
      return jsonDecode(response.body)['status'];
    }
    return null;
  }
}
