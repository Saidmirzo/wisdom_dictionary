import 'dart:convert';

/// status : true
/// billing_id : 1
/// tariff_id : 1
/// click : ""
/// payme : ""

SubscribeModel subscribeModelFromJson(String str) => SubscribeModel.fromJson(json.decode(str));

String subscribeModelToJson(SubscribeModel data) => json.encode(data.toJson());

class SubscribeModel {
  SubscribeModel({
    bool? status,
    int? billingId,
    int? tariffId,
    String? click,
    String? payme,
  }) {
    _status = status;
    _billingId = billingId;
    _tariffId = tariffId;
    _click = click;
    _payme = payme;
  }

  SubscribeModel.fromJson(dynamic json) {
    _status = json['status'];
    _billingId = json['billing_id'];
    _tariffId = json['tariff_id'];
    _click = json['click'];
    _payme = json['payme'];
  }

  bool? _status;
  int? _billingId;
  int? _tariffId;
  String? _click;
  String? _payme;

  SubscribeModel copyWith({
    bool? status,
    int? billingId,
    int? tariffId,
    String? click,
    String? payme,
  }) =>
      SubscribeModel(
        status: status ?? _status,
        billingId: billingId ?? _billingId,
        tariffId: tariffId ?? _tariffId,
        click: click ?? _click,
        payme: payme ?? _payme,
      );

  bool? get status => _status;

  int? get billingId => _billingId;

  int? get tariffId => _tariffId;

  String? get click => _click;

  String? get payme => _payme;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['billing_id'] = _billingId;
    map['tariff_id'] = _tariffId;
    map['click'] = _click;
    map['payme'] = _payme;
    return map;
  }
}
