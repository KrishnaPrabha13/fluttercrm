import 'dart:ui';

import 'package:country_picker/country_picker.dart';
import 'package:crm_dashboard/shared/theme/colors.dart';
import 'package:intl/intl.dart';

bool visibleEmptyText = false;
bool visibleErrorText = false;
bool visibleWrongOTPText = false;
String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
RegExp regExp = new RegExp(pattern);
String? getCurrentDateTime() {
  String? currentDateTime;
  currentDateTime = DateFormat('MMM d, yyyy').format(DateTime.now()).toString();
  return currentDateTime;
}

String? getCTPDateTimeYear(CTPdate) {
  String? getDateTime;
  var parsedDate = DateFormat('yyyy-MM-ddTHH:mm:ss').parse(CTPdate.toString());
  getDateTime = DateFormat("MMM d, yyyy hh:mm a").format(parsedDate);
  //print('jsonResponseChart getDateTime $getDateTime');

  var parsedDate1 = DateFormat('MMM d, yyyy').parse(getDateTime);
  String getYear = DateFormat("yyyy-MM-dd hh:mm:ss").format(parsedDate1);
  //print('jsonResponseChart getYear ${getYear.substring(0, 4)}');
  return getYear.substring(0, 4);
}

String? getCTPDateTime(CTPdate) {
  String? getDateTime;
  var parsedDate = DateFormat('yyyy-MM-ddTHH:mm:ss').parse(CTPdate.toString());
  getDateTime = DateFormat("MMM d, yyyy hh:mm a").format(parsedDate);
  //print('jsonResponseChart getDateTime ${getDateTime}');
  return getDateTime;
}

List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
  List<DateTime> days = [];
  for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
    days.add(startDate.add(Duration(days: i)));
  }

  return days;
}

Country selectedCountry = Country(
  phoneCode: "91",
  countryCode: "IN",
  e164Sc: 0,
  geographic: true,
  level: 1,
  name: "India",
  example: "India",
  displayName: "India",
  displayNameNoCountryCode: "IN",
  e164Key: "",
);
Color? getDealsColor(String? stages) {
  Color? _color;
  switch (stages) {
    case 'Qualification':
      _color = lightGreen1;
      break;
    case 'Needs Analysis':
      _color = lightBlue1;
      break;
    case 'Value Proposition':
      _color = darkBlue1;
      break;
    case 'Identify Decision Mak':
      _color = lightOrange1;
      break;
    case 'Proposal/Price Quote':
      _color = lightYellow1;
      break;
    case 'Negotiation/Review':
      _color = lightBlue;
      break;
    case 'Closed Won':
      _color = green;
      break;
    case 'Closed Lost':
      _color = lightRed;
      break;
    case 'Closed-Lost to Competition':
      _color = lightVoilet;
      break;
    default:
      _color = srmBlueGreen;
      break;
  }
  return _color;
}

Color? getDealsTextColor(String? stages) {
  Color? _color;
  switch (stages) {
    case 'Qualification':
      _color = AppColors.qualificationTextGreen;
      break;
    case 'Needs Analysis':
      _color = AppColors.needAnalysisTextblue;
      break;
    case 'Value Proposition':
      _color = AppColors.valuepropositionTextviolet;
      break;
    case 'Identify Decision Mak':
      _color = AppColors.identiftdecisionmakTextivory;
      break;
    case 'Proposal/Price Quote':
      _color = AppColors.proposalpricequateTextyellow;
      break;
    case 'Negotiation/Review':
      _color = AppColors.negotiationreviewTextblue;
      break;
    case 'Closed Won':
      _color = AppColors.closedwonTextgreen;
      break;
    case 'Closed Lost':
      _color = AppColors.closedlostTextpink;
      break;
    case 'Closed-Lost to Competition':
      _color = AppColors.closedlosttocompetitionTextviolet;
      break;
    default:
      _color = AppColors.defaultTextgreenblue;
      break;
  }
  return _color;
}

Color? getLeadColor(String? source) {
  Color? _color;
  switch (source) {
    case 'Contacted':
      _color = AppColors.connectedgreen;
      break;
    case 'Not Contacted':
      _color = AppColors.notconnectedpink;
      break;
    case 'Pre-Qualified':
      _color = AppColors.prequalifiedviolet;
      break;
    case 'Not Qualified':
      _color = AppColors.notqualifiedviolet;
      break;
    case 'Attempted to Contact':
      _color = AppColors.attemptedtocontactyellow;
      break;
    case 'Lost Lead':
      _color = AppColors.lostleadBurgundy;
      break;
    case 'Junk':
      _color = AppColors.junkgreen;
      break;
  }
  return _color;
}

Color? getTextColor(String? source) {
  Color? _color;
  switch (source) {
    case 'Contacted':
      _color = AppColors.connectedtextgreen;
      break;
    case 'Not Contacted':
      _color = AppColors.notconnectedtextpink;
      break;
    case 'Pre-Qualified':
      _color = AppColors.prequalifiedtextviolet;
      break;
    case 'Not Qualified':
      _color = AppColors.notqualifiedtextviolet;
      break;
    case 'Attempted to Contact':
      _color = AppColors.attemptedtocontacttextyellow;
      break;
    case 'Lost Lead':
      _color = AppColors.lostleadtextBurgundy;
      break;
    case 'Junk':
      _color = AppColors.junktextgreen;
      break;
  }
  return _color;
}
