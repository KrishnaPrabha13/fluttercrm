enum AppThemeKey { LIGHT, DARK }

const double BOTTOM_SHEET_PERCENT_60 = 0.60;
const defaultPadding = 16.0;
const double kPadding = 10.0;
double CARD_RADIUS = 16.0;
const double Padding_8 = 8.0;
const double Padding_7 = 7.0;
const double Padding_6 = 6.0;
const double Padding_5 = 5.0;
String? userAccess;
String? getUserName;
String? getAccess;
String? getEmpId;
String? getDesignation;
String? getDepartment;
String? getEmail;
String? getMobile;
String? selectedText = "Select Business Unit";
int? dealsTabIndex;
int? selectIndex = 0;
int? leadTabIndex;
int navigationSelectedIndex = 0;
late int? todaysLeads;
late int? totalLeads;
late int? monthlyLeads;
late int? weeklyLeads;
late int? unTouchedLeads;
late int? othersLeads;
late int? monthlyDeals;
late int? dealsInPipeline;
late int? revenueThisMonth;
late int? revenueLostThisMonth;
late int? totalDeals;

List<String> selectBusinessUnit = [
  'Select Business Unit',
  'All',
  'CIS',
  'PES',
  'AES - Captive',
  'AES - Japan',
  'AES - US',
  'Digital Practice',
];
