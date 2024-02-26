import 'package:crm_dashboard/config/responsive/responsive.dart';
import 'package:crm_dashboard/feature/dashoard/data/model/CrmLeadModel.dart';
import 'package:crm_dashboard/feature/dashoard/presentation/widget/dashbaord_lead_card/dashboard_lead_card_list.dart';
import 'package:crm_dashboard/feature/dashoard/presentation/widget/dashboard_card_list_info.dart';
import 'package:crm_dashboard/feature/lead_details/presentation/screen/tabview/lead_detail_tab.dart';
import 'package:crm_dashboard/shared/common_widgets/SliverGridWithCustomGeometryLayout.dart';
import 'package:crm_dashboard/shared/util/app_ennum_const_util.dart';
import 'package:crm_dashboard/shared/util/common_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DashboardLeadCardGridView extends StatefulWidget {
  DashboardLeadCardGridView(
      {Key? key,
      this.crossAxisCount = 5,
      this.childAspectRatio = 1.4,
      required this.crmLeadlist,
      required this.getAccess})
      : super(key: key);

  final int crossAxisCount;
  String? getAccess;
  final double childAspectRatio;

  List<CrmLeadModel> crmLeadlist = [];

  @override
  State<DashboardLeadCardGridView> createState() =>
      _DashboardLeadCardGridViewState();
}

class _DashboardLeadCardGridViewState extends State<DashboardLeadCardGridView> {
  String? dataTimems;
  String? sdate;
  String? cdate;
  var countList = [];
  var todaycountList = [];
  var weekList = [];
  List<CrmLeadModel> countList1 = [];
  List<CrmLeadModel> countList2 = [];
  List<String> countList3 = [];
  List<int> weekCount = [];
  List<int> todayCount = [];
  List<DateTime> FinalDateList = [];
  late List? dashboardLeadCardList;

  @override
  Widget build(BuildContext context) {
    //get total Leads
    _getTotalLeads(getAccess);
    //get todays lead
    _getTodayLeads(getAccess);
    //get weekly leads
    _getWeeklyLeads(getAccess);
    // get monthly leads
    _getMonthlyLeads(getAccess);
    //get untouched Leads
    _getUnTouchedLeads(getAccess);
    //get Others Leads
    _getOthersLeads(getAccess);
    //get dahboard lead card list data
    dashboardLeadCardList = getDashboardLeadCard(context);
    print('dd ${getAccess}');
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: dashboardLeadCardList!.length,
      gridDelegate: Responsive.isMobile(context)
          ? SliverGridDelegateWithFixedCrossAxisCountAndCentralizedLastElement(
              crossAxisCount: widget.crossAxisCount,
              crossAxisSpacing: defaultPadding,
              mainAxisSpacing: defaultPadding,
              childAspectRatio: widget.childAspectRatio,
              itemCount: dashboardLeadCardList!.length,
            )
          : SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.crossAxisCount,
              crossAxisSpacing: defaultPadding,
              mainAxisSpacing: defaultPadding,
              childAspectRatio: widget.childAspectRatio,
            ),
      itemBuilder: (context, index) => InkWell(
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return LeadDetailTab(
                      selectIndex: index,
                      hideappbar: false,
                      getAccess: getAccess);
                },
              ),
              (route) => false,
            );
          },
          child: DashboardCardListInfo(
              dashboardCardView: dashboardLeadCardList![index])),
    );
  }

  void _getTotalLeads(String? getAccess) {
    totalLeads = widget.crmLeadlist.length;
  }

  void _getTodayLeads(String? getAccess) {
    List<CrmLeadModel> todaysList = [];
    todaysList = widget.crmLeadlist
        .where((element) => getCTPDateTime(element.createdTime.toString())!
            .contains(getCurrentDateTime().toString()))
        .toList();
    /* var LeadList = todaysList
        .where((element) =>
            element.leadStatus == 'Contacted' ||
            element.leadStatus == 'Not Contacted')
        .toList();*/
    todaysLeads = todaysList.length;
  }

  void _getWeeklyLeads(String? getAccess) {
    DateTime now = DateTime.now();

    int currentDay = now.weekday;
    var LeadList = [];
    DateTime firstDayOfWeek = now.subtract(Duration(days: currentDay - 1));
    sdate = DateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(firstDayOfWeek);
    DateTime today = DateTime.now();

    cdate = DateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(today);

    DateTime CurrentDate = DateTime.parse(cdate!);
    DateTime StartDate = DateTime.parse(sdate!);

    FinalDateList = getDaysInBetween(StartDate, CurrentDate);
    countList.clear();
    FinalDateList.forEach((day) {
      String first2 = DateFormat('MMM d, yyyy').format(day);

      countList.add(first2);
    });
    weekCount.clear();

    LeadList.clear();
    for (int i = 0; i < countList.length; i++) {
      countList1 = widget.crmLeadlist
          .where((element) => getCTPDateTime(element.createdTime.toString())!
              .contains(countList[i]))
          .toList();
      /*LeadList = countList1
          .where((element) =>
              element.leadStatus == 'Contacted' ||
              element.leadStatus == 'Not Contacted')
          .toList();*/
      LeadList = countList1
          .where((element) =>
      element.leadStatus == 'Contacted'||
          element.leadStatus == 'Not Contacted').toList();

      weekCount.add(countList1.length);
    }

    var totalCount = weekCount.reduce((a, b) => a + b);

    weeklyLeads = totalCount;
  }

  void _getMonthlyLeads(String? getAccess) {
    List<CrmLeadModel> monthlyList = [];

    monthlyList = widget.crmLeadlist
        .where((element) =>
            (getCTPDateTime(element.createdTime.toString())!.contains(
                DateFormat(DateFormat.ABBR_MONTH).format(DateTime.now()))) &&
            (getCTPDateTime(element.createdTime.toString())!
                .contains(DateFormat(DateFormat.YEAR).format(DateTime.now()))))
        .toList();
    monthlyLeads = monthlyList.length;
  }

  void _getUnTouchedLeads(String? getAccess) {
    var untouchedLeads = widget.crmLeadlist
        .where((element) =>
            element.leadStatus.toString().trim() == 'Not Contacted')
        .toList();

    unTouchedLeads = untouchedLeads.length;
  }

  void _getOthersLeads(String? getAccess) {
    var otherleadsList = widget.crmLeadlist
        .where((element) => element.leadStatus != 'Not Contacted')
        .toList();
    //print('monthlyList 191== ${otherleadsList.length}');
    List<CrmLeadModel> monthlyList = [];

    monthlyList = otherleadsList
        .where((element) =>
            getCTPDateTime(element.createdTime) !=
                (getCTPDateTime(element.createdTime.toString())!.contains(
                    DateFormat(DateFormat.ABBR_MONTH)
                        .format(DateTime.now()))) &&
            (getCTPDateTime(element.createdTime.toString())!
                .contains(DateFormat(DateFormat.YEAR).format(DateTime.now()))))
        .toList();

    othersLeads = monthlyList.length;
    print('monthlyList 203== ${othersLeads.toString()}');
  }
}
