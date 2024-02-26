import 'dart:convert';

/// leadbysource : "Cold Calling"
/// count : 5

LeadbysourceModel leadbysourceModelFromJson(String str) =>
    LeadbysourceModel.fromJson(json.decode(str));
String leadbysourceModelToJson(LeadbysourceModel data) =>
    json.encode(data.toJson());

class LeadbysourceModel {
  LeadbysourceModel({
    String? leadbysource,
    double? count,
  }) {
    _leadbysource = leadbysource;
    _count = count;
  }

  LeadbysourceModel.fromJson(dynamic json) {
    _leadbysource = json['leadbysource'];
    _count = json['count'];
  }
  String? _leadbysource;
  double? _count;

  String? get leadbysource => _leadbysource;
  double? get count => _count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['leadbysource'] = _leadbysource;
    map['count'] = _count;
    return map;
  }
}
