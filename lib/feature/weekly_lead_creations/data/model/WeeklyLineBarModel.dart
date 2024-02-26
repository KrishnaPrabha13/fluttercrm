import 'dart:convert';
/// dayName : "Mon"
/// count : 2

WeeklyLineBarModel weeklyLineBarModelFromJson(String str) => WeeklyLineBarModel.fromJson(json.decode(str));
String weeklyLineBarModelToJson(WeeklyLineBarModel data) => json.encode(data.toJson());
class WeeklyLineBarModel {
  WeeklyLineBarModel({
      String? dayName, 
      int? count,}){
    _dayName = dayName;
    _count = count;
}

  WeeklyLineBarModel.fromJson(dynamic json) {
    _dayName = json['dayName'];
    _count = json['count'];
  }
  String? _dayName;
  int? _count;

  String? get dayName => _dayName;
  int? get count => _count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dayName'] = _dayName;
    map['count'] = _count;
    return map;
  }

}