import 'dart:convert';
/// Access : "CIS"
/// Business Unit : "CIS"
/// Designation : "Programmer Analyst"
/// Email Id : "krishnaprabhaa@srmtech.com"
/// Emp Id : "A2947"
/// Full Name : "KrishnaPrabha"
/// Mobile No : 7338905729

AuthDataModel authDataModelFromJson(String str) => AuthDataModel.fromJson(json.decode(str));
String authDataModelToJson(AuthDataModel data) => json.encode(data.toJson());
class AuthDataModel {
  AuthDataModel({
      String? access, 
      String? businessUnit, 
      String? designation, 
      String? emailId, 
      String? empId, 
      String? fullName, 
      int? mobileNo,}){
    _access = access;
    _businessUnit = businessUnit;
    _designation = designation;
    _emailId = emailId;
    _empId = empId;
    _fullName = fullName;
    _mobileNo = mobileNo;
}

  AuthDataModel.fromJson(dynamic json) {
    _access = json['Access'];
    _businessUnit = json['Business Unit'];
    _designation = json['Designation'];
    _emailId = json['Email Id'];
    _empId = json['Emp Id'];
    _fullName = json['Full Name'];
    _mobileNo = json['Mobile No'];
  }
  String? _access;
  String? _businessUnit;
  String? _designation;
  String? _emailId;
  String? _empId;
  String? _fullName;
  int? _mobileNo;

  String? get access => _access;
  String? get businessUnit => _businessUnit;
  String? get designation => _designation;
  String? get emailId => _emailId;
  String? get empId => _empId;
  String? get fullName => _fullName;
  int? get mobileNo => _mobileNo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Access'] = _access;
    map['Business Unit'] = _businessUnit;
    map['Designation'] = _designation;
    map['Email Id'] = _emailId;
    map['Emp Id'] = _empId;
    map['Full Name'] = _fullName;
    map['Mobile No'] = _mobileNo;
    return map;
  }

}