import 'dart:convert';

import 'package:wisdom/data/model/tariffs_model.dart';

/// status : true
/// token : ""
/// expiry_tariff : ""
/// tariffs : []

VerifyModel verifyModelFromJson(String str) => VerifyModel.fromJson(json.decode(str));

String verifyModelToJson(VerifyModel data) => json.encode(data.toJson());

class VerifyModel {
  VerifyModel({
    bool? status,
    String? token,
    int? expiryTariff,
    List<TariffsModel>? tariffs,
  }) {
    _status = status;
    _token = token;
    _expiryTariff = expiryTariff;
    _tariffs = tariffs;
  }

  VerifyModel.fromJson(dynamic json) {
    _status = json['status'];
    _token = json['token'];
    _expiryTariff = json['expiry_tariff'];
    if (json['tariffs'] != null) {
      _tariffs = [];
      json['tariffs'].forEach((v) {
        _tariffs?.add(TariffsModel.fromJson(v));
      });
    }
  }

  bool? _status;
  String? _token;
  int? _expiryTariff;
  List<TariffsModel>? _tariffs;

  VerifyModel copyWith({
    bool? status,
    String? token,
    int? expiryTariff,
    List<TariffsModel>? tariffs,
  }) =>
      VerifyModel(
        status: status ?? _status,
        token: token ?? _token,
        expiryTariff: expiryTariff ?? _expiryTariff,
        tariffs: tariffs ?? _tariffs,
      );

  bool? get status => _status;

  String? get token => _token;

  int? get expiryTariff => _expiryTariff;

  List<TariffsModel>? get tariffs => _tariffs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['token'] = _token;
    map['expiry_tariff'] = _expiryTariff;
    if (_tariffs != null) {
      map['tariffs'] = _tariffs?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
