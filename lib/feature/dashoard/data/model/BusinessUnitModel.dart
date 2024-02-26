import 'dart:convert';

/// businessUnitName : "AES - Captive"

BusinessUnitModel businessUnitModelFromJson(String str) =>
    BusinessUnitModel.fromJson(json.decode(str));
String businessUnitModelToJson(BusinessUnitModel data) =>
    json.encode(data.toJson());

class BusinessUnitModel {
  BusinessUnitModel({
    String? businessUnitName,
  }) {
    _businessUnitName = businessUnitName;
  }

  BusinessUnitModel.fromJson(dynamic json) {
    _businessUnitName = json['businessUnitName'];
  }
  String? _businessUnitName;

  String? get businessUnitName => _businessUnitName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['businessUnitName'] = _businessUnitName;
    return map;
  }
}
