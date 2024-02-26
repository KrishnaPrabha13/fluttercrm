import 'dart:convert';

/// Record Id : "zcrm_5236023000018773023"
/// Deals Name : "Test Demo Org"
/// Account Name : "Test Demo Org"
/// Amount : 20000000
/// Business Unit : "AES"
/// Closing Date : "Jul 31, 2023"
/// Deals Owner : "SRM Admin"
/// Contact Name : "Test"

DealsDataModel dealsDataModelFromJson(String str) =>
    DealsDataModel.fromJson(json.decode(str));
String dealsDataModelToJson(DealsDataModel data) => json.encode(data.toJson());

class DealsDataModel {
  DealsDataModel({
    String? recordId,
    String? dealsName,
    String? accountName,
    int? amount,
    String? businessUnit,
    String? closingDate,
    String? dealsOwner,
    String? contactName,
    String? dealsStage,
  }) {
    _recordId = recordId;
    _dealsName = dealsName;
    _accountName = accountName;
    _amount = amount;
    _businessUnit = businessUnit;
    _closingDate = closingDate;
    _dealsOwner = dealsOwner;
    _contactName = contactName;
    _dealsStage = dealsStage;
  }

  DealsDataModel.fromJson(dynamic json) {
    _recordId = json['Record Id'];
    _dealsName = json['Deals Name'];
    _accountName = json['Account Name'];
    _amount = json['Amount'];
    _businessUnit = json['Business Unit'];
    _closingDate = json['Closing Date'];
    _dealsOwner = json['Deals Owner'];
    _contactName = json['Contact Name'];
    _dealsStage = json['Deals Stages'];
  }
  String? _recordId;
  String? _dealsName;
  String? _accountName;
  int? _amount;
  String? _businessUnit;
  String? _closingDate;
  String? _dealsOwner;
  String? _contactName;
  String? _dealsStage;

  String? get recordId => _recordId;
  String? get dealsName => _dealsName;
  String? get accountName => _accountName;
  int? get amount => _amount;
  String? get businessUnit => _businessUnit;
  String? get closingDate => _closingDate;
  String? get dealsOwner => _dealsOwner;
  String? get contactName => _contactName;
  String? get dealsStage => _dealsStage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Record Id'] = _recordId;
    map['Deals Name'] = _dealsName;
    map['Account Name'] = _accountName;
    map['Amount'] = _amount;
    map['Business Unit'] = _businessUnit;
    map['Closing Date'] = _closingDate;
    map['Deals Owner'] = _dealsOwner;
    map['Contact Name'] = _contactName;
    map['Deals Stages'] = _dealsStage;
    return map;
  }
}
