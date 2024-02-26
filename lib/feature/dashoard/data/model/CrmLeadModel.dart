import 'dart:convert';

/// Record Id : "zcrm_5236023000017671001"
/// Business Unit : "Digital - AES"
/// Full Name : "Okitsu Hiroshi"
/// Annual Revenue : "-"
/// Company : "A&B"
/// Geography : "Japan"
/// Lead Source : "Cold Calling"
/// Lead Status : "Contacted"
/// Looking For : "-"
/// Lead Owner : "Mohan Santhosh Kumar"
/// Probability (%) : "40 - 50"
/// Probability of Lead Closure : "Value Proposition"
/// Referrer : "-"
/// Country : "-"
/// Created Time : "Jun 21, 2023 03:03 PM"

CrmLeadModel crmModelFromJson(String str) =>
    CrmLeadModel.fromJson(json.decode(str));
String crmModelToJson(CrmLeadModel data) => json.encode(data.toJson());

class CrmLeadModel {
  CrmLeadModel({
    String? recordId,
    String? businessUnit,
    String? fullName,
    String? annualRevenue,
    String? company,
    String? geography,
    String? leadSource,
    String? leadStatus,
    String? lookingFor,
    String? leadOwner,
    String? probability,
    String? probabilityofLeadClosure,
    String? referrer,
    String? country,
    String? createdTime,
  }) {
    _recordId = recordId;
    _businessUnit = businessUnit;
    _fullName = fullName;
    _annualRevenue = annualRevenue;
    _company = company;
    _geography = geography;
    _leadSource = leadSource;
    _leadStatus = leadStatus;
    _lookingFor = lookingFor;
    _leadOwner = leadOwner;
    _probability = probability;
    _probabilityofLeadClosure = probabilityofLeadClosure;
    _referrer = referrer;
    _country = country;
    _createdTime = createdTime;
  }

  CrmLeadModel.fromJson(dynamic json) {
    _recordId = json['Record Id'];
    _businessUnit = json['Business Unit'];
    _fullName = json['Full Name'];
    _annualRevenue = json['Annual Revenue'];
    _company = json['Company'];
    _geography = json['Geography'];
    _leadSource = json['Lead Source'];
    _leadStatus = json['Lead Status'];
    _lookingFor = json['Looking For'];
    _leadOwner = json['Lead Owner'];
    _probability = json['Probability (%)'];
    _probabilityofLeadClosure = json['Probability of Lead Closure'];
    _referrer = json['Referrer'];
    _country = json['Country'];
    _createdTime = json['Created Time'];
  }
  String? _recordId;
  String? _businessUnit;
  String? _fullName;
  String? _annualRevenue;
  String? _company;
  String? _geography;
  String? _leadSource;
  String? _leadStatus;
  String? _lookingFor;
  String? _leadOwner;
  String? _probability;
  String? _probabilityofLeadClosure;
  String? _referrer;
  String? _country;
  String? _createdTime;
  CrmLeadModel copyWith({
    String? recordId,
    String? businessUnit,
    String? fullName,
    String? annualRevenue,
    String? company,
    String? geography,
    String? leadSource,
    String? leadStatus,
    String? lookingFor,
    String? leadOwner,
    String? probability,
    String? probabilityofLeadClosure,
    String? referrer,
    String? country,
    String? createdTime,
  }) =>
      CrmLeadModel(
        recordId: recordId ?? _recordId,
        businessUnit: businessUnit ?? _businessUnit,
        fullName: fullName ?? _fullName,
        annualRevenue: annualRevenue ?? _annualRevenue,
        company: company ?? _company,
        geography: geography ?? _geography,
        leadSource: leadSource ?? _leadSource,
        leadStatus: leadStatus ?? _leadStatus,
        lookingFor: lookingFor ?? _lookingFor,
        leadOwner: leadOwner ?? _leadOwner,
        probability: probability ?? _probability,
        probabilityofLeadClosure:
            probabilityofLeadClosure ?? _probabilityofLeadClosure,
        referrer: referrer ?? _referrer,
        country: country ?? _country,
        createdTime: createdTime ?? _createdTime,
      );
  String? get recordId => _recordId;
  String? get businessUnit => _businessUnit;
  String? get fullName => _fullName;
  String? get annualRevenue => _annualRevenue;
  String? get company => _company;
  String? get geography => _geography;
  String? get leadSource => _leadSource;
  String? get leadStatus => _leadStatus;
  String? get lookingFor => _lookingFor;
  String? get leadOwner => _leadOwner;
  String? get probability => _probability;
  String? get probabilityofLeadClosure => _probabilityofLeadClosure;
  String? get referrer => _referrer;
  String? get country => _country;
  String? get createdTime => _createdTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Record Id'] = _recordId;
    map['Business Unit'] = _businessUnit;
    map['Full Name'] = _fullName;
    map['Annual Revenue'] = _annualRevenue;
    map['Company'] = _company;
    map['Geography'] = _geography;
    map['Lead Source'] = _leadSource;
    map['Lead Status'] = _leadStatus;
    map['Looking For'] = _lookingFor;
    map['Lead Owner'] = _leadOwner;
    map['Probability (%)'] = _probability;
    map['Probability of Lead Closure'] = _probabilityofLeadClosure;
    map['Referrer'] = _referrer;
    map['Country'] = _country;
    map['Created Time'] = _createdTime;
    return map;
  }
}
