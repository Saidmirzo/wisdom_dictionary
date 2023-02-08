import 'dart:convert';
/// status : true
/// expiry_date : ""
/// expiry_status : true

SubscribeCheckModel subscribeCheckModelFromJson(String str) => SubscribeCheckModel.fromJson(json.decode(str));
String subscribeCheckModelToJson(SubscribeCheckModel data) => json.encode(data.toJson());
class SubscribeCheckModel {
  SubscribeCheckModel({
      bool? status, 
      String? expiryDate, 
      bool? expiryStatus,}){
    _status = status;
    _expiryDate = expiryDate;
    _expiryStatus = expiryStatus;
}

  SubscribeCheckModel.fromJson(dynamic json) {
    _status = json['status'];
    _expiryDate = json['expiry_date'];
    _expiryStatus = json['expiry_status'];
  }
  bool? _status;
  String? _expiryDate;
  bool? _expiryStatus;
SubscribeCheckModel copyWith({  bool? status,
  String? expiryDate,
  bool? expiryStatus,
}) => SubscribeCheckModel(  status: status ?? _status,
  expiryDate: expiryDate ?? _expiryDate,
  expiryStatus: expiryStatus ?? _expiryStatus,
);
  bool? get status => _status;
  String? get expiryDate => _expiryDate;
  bool? get expiryStatus => _expiryStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['expiry_date'] = _expiryDate;
    map['expiry_status'] = _expiryStatus;
    return map;
  }

}