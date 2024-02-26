// To parse this JSON data, do
//
//     final dealsInfoModel = dealsInfoModelFromMap(jsonString);

/*import 'dart:convert';

List<DealsInfoModel> dealsInfoModelFromMap(String str) =>
    List<DealsInfoModel>.from(
        json.decode(str).map((x) => DealsInfoModel.fromMap(x)));

String dealsInfoModelToMap(List<DealsInfoModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class DealsInfoModel {
  String? recordId;
  String? dealsName;
  String? accountName;
  int? amount;
  String? businessUnit;
  String? closingDate;
  String? dealsOwner;
  String? contactName;

  DealsInfoModel({
    this.recordId,
    this.dealsName,
    this.accountName,
    this.amount,
    this.businessUnit,
    this.closingDate,
    this.dealsOwner,
    this.contactName,
  });

  factory DealsInfoModel.fromMap(Map<String, dynamic> json) => DealsInfoModel(
        recordId: json["Record Id"],
        dealsName: json["Deals Name"],
        accountName: json["Account Name"],
        amount: json["Amount"],
        businessUnit: json["Business Unit"],
        closingDate: json["Closing Date"],
        dealsOwner: json["Deals Owner"],
        contactName: json["Contact Name"],
      );

  Map<String, dynamic> toMap() => {
        "Record Id": recordId,
        "Deals Name": dealsName,
        "Account Name": accountName,
        "Amount": amount,
        "Business Unit": businessUnit,
        "Closing Date": closingDate,
        "Deals Owner": dealsOwner,
        "Contact Name": contactName,
      };
}*/
