class MonthlyListModel {
  MonthlyListModel({
    required this.dayName,
    required this.company,
    required this.probability,
    required this.businessUnit,
    required this.leadSource,});

  MonthlyListModel.fromJson(dynamic json) {
    dayName = json['dayName'];
    company = json['Company'];
    probability = json['Probability'];
    businessUnit = json['Business Unit'];
    leadSource = json['Lead Source'];
  }
  String? dayName;
  String? company;
  String? probability;
  String? businessUnit;
  String? leadSource;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dayName'] = dayName;
    map['Company'] = company;
    map['Probability'] = probability;
    map['Business Unit'] = businessUnit;
    map['Lead Source'] = leadSource;
    return map;
  }

}