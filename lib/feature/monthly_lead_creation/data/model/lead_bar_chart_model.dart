import 'dart:convert';

import 'package:flutter/material.dart';
/// months : "Jan"
/// count : 3

LeadBarchartModel leadBarChartModelFromJson(String str) => LeadBarchartModel.fromJson(json.decode(str));
String leadBarChartModelToJson(LeadBarchartModel data) => json.encode(data.toJson());
class LeadBarchartModel {
  LeadBarchartModel({
      String? months, 
      int? count, required String x, required int yValue,required Color pointColor,}){
    _months = months;
    _count = count;
}

  LeadBarchartModel.fromJson(dynamic json) {
    _months = json['months'];
    _count = json['count'];
  }
  String? _months;
  int? _count;

  String? get months => _months;
  int? get count => _count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['months'] = _months;
    map['count'] = _count;
    return map;
  }

}