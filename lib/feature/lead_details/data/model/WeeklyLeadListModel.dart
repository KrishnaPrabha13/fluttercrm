class WeeklyLeadListModel {
  WeeklyLeadListModel({
    required this.dayName,
    required this.company,
    required this.probability,
    required this.businessUnit,
    required this.leadSource,
    required this.leadStatus,
    required this.leadowner,
    required this.leadlookingfor,
    required this.probailityofleadcloser,
    required this.country,
  });

  WeeklyLeadListModel.fromJson(dynamic json) {
    dayName = json['dayName'];
    company = json['Company'];
    probability = json['Probability'];
    businessUnit = json['Business Unit'];
    leadSource = json['Lead Source'];
    leadStatus = json['Lead Status'];
    leadowner = json['Lead Owner'];
    leadlookingfor = json['lead lookingfor'];
    probailityofleadcloser = json['Probabilityofleadcloser'];
    country = json['country'];
  }
  String? dayName;
  String? company;
  String? probability;
  String? businessUnit;
  String? leadSource;
  String? leadStatus;
  String? leadowner;
  String? leadlookingfor;
  String? probailityofleadcloser;
  String? country;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dayName'] = dayName;
    map['Company'] = company;
    map['Probability'] = probability;
    map['Business Unit'] = businessUnit;
    map['Lead Source'] = leadSource;
    map['Lead Status'] = leadStatus;
    map['Lead Owner'] = leadowner;
    map['lead lookingfor'] = leadlookingfor;
    map['Probabilityofleadcloser'] = probailityofleadcloser;
    map['country'] = country;
    return map;
  }
}
