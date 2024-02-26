import 'dart:convert';

/// leadbysource : "Cold Calling"
/// count : 5

DealbystageModel dealbystageModelFromJson(String str) =>
    DealbystageModel.fromJson(json.decode(str));
String dealbystageModelToJson(DealbystageModel data) =>
    json.encode(data.toJson());

class DealbystageModel {
  DealbystageModel({
    String? dealbystage,
    int? count,
    int? orderbystatus,
  }) {
    _dealbystage = dealbystage;
    _count = count;
    _orderbystatus = orderbystatus;
  }

  DealbystageModel.fromJson(dynamic json) {
    _dealbystage = json['dealbystage'];
    _count = json['count'];
    _orderbystatus = json['orderbystatus'];
  }
  String? _dealbystage;
  int? _count;
  int? _orderbystatus;

  String? get dealbystage => _dealbystage;
  int? get count => _count;
  int? get orderbystatus => _orderbystatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dealbystage'] = _dealbystage;
    map['count'] = _count;
    map['orderbystatus'] = _orderbystatus;
    return map;
  }
}
