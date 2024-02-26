import 'package:crm_dashboard/config/responsive/responsive.dart';
import 'package:crm_dashboard/feature/dashoard/presentation/widget/dashboard_card_list_info.dart';
import 'package:crm_dashboard/feature/dashoard/presentation/widget/dashboard_deals_card/dashboard_deals_card_list.dart';
import 'package:crm_dashboard/feature/deals_info/data/model/DealsDataModel.dart';
import 'package:crm_dashboard/feature/deals_info/presentation/screen/deals_detail_tab.dart';
import 'package:crm_dashboard/feature/lead_details/presentation/screen/tabview/lead_detail_tab.dart';
import 'package:crm_dashboard/shared/common_widgets/SliverGridWithCustomGeometryLayout.dart';
import 'package:crm_dashboard/shared/util/app_ennum_const_util.dart';
import 'package:crm_dashboard/shared/util/common_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DashboardDealsCardGridView extends StatefulWidget {
  DashboardDealsCardGridView(
      {Key? key,
      this.crossAxisCount = 2,
      this.childAspectRatio = 1.4,
      required this.crmDealList})
      : super(key: key);

  List<DealsDataModel> crmDealList = [];

  final int crossAxisCount;

  final double childAspectRatio;

  @override
  State<DashboardDealsCardGridView> createState() =>
      _DashboardDealsCardGridViewState();
}

class _DashboardDealsCardGridViewState
    extends State<DashboardDealsCardGridView> {
  String? dataTimems;
  late List? dashboardDealsCardList;
  @override
  Widget build(BuildContext context) {
    //get total Deals
    _getTotalDeals();

    // get monthly Deals
    _getMonthlyDeals();

    //get deals in Pipeline
    _getDealsInPipeline();

    //get deals in revenue this month
    _getDealsRevenueThisMonth();

    //get deals in revenue lost this month
    _getDealsRevenueLostThisMonth();
    //get dahboard deals card list data
    dashboardDealsCardList = getDashboardDealsCard(context);

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: dashboardDealsCardList!.length,
      gridDelegate: Responsive.isMobile(context) ||
              Responsive.isDesktop(context) ||
              Responsive.isTablet(context)
          ? SliverGridDelegateWithFixedCrossAxisCountAndCentralizedLastElement(
              crossAxisCount: widget.crossAxisCount,
              crossAxisSpacing: defaultPadding,
              mainAxisSpacing: defaultPadding,
              childAspectRatio: widget.childAspectRatio,
              itemCount: dashboardDealsCardList!.length,
            )
          : SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.crossAxisCount,
              crossAxisSpacing: defaultPadding,
              mainAxisSpacing: defaultPadding,
              childAspectRatio: widget.childAspectRatio,
            ),
      itemBuilder: (context, index) => InkWell(
          onTap: () {
            setState(() {
              if (index == 1) {
                selectIndex = 0;
              } else if (index == 2) {
                selectIndex = 1;
              } else if (index == 3) {
                selectIndex = 2;
              } else if (index == 4) {
                selectIndex = 3;
              } else if (index == 5) {
                selectIndex = 4;
              }

              print('dealsIndex ${selectIndex}');
            });

            // Content for deal detail tab
            index != 0
                ? Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return DealsDetailTab(
                            //selectIndex: index,
                            hideappbar: false,
                            getAccess: getAccess);
                      },
                    ),
                    (route) => false,
                  )
                : Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LeadDetailTab(
                          selectIndex: 5,
                          hideappbar: false,
                          getAccess: getAccess,
                        );
                      },
                    ),
                    (route) => false,
                  );
          },
          child: DashboardCardListInfo(
              dashboardCardView: dashboardDealsCardList![index])),
    );
  }

  void _getTotalDeals() {
    totalDeals = widget.crmDealList.length;
  }

  void _getMonthlyDeals() {
    List<DealsDataModel> monthlyList = [];

    monthlyList = widget.crmDealList
        .where((element) =>
            (getCTPDateTime(element.closingDate.toString())!.contains(
                DateFormat(DateFormat.ABBR_MONTH).format(DateTime.now()))) &&
            (getCTPDateTime(element.closingDate.toString())!
                .contains(DateFormat(DateFormat.YEAR).format(DateTime.now()))))
        .toList();

    monthlyDeals = monthlyList.length;
  }

  void _getDealsInPipeline() {
    var deals_Pipeline = widget.crmDealList
        .where((element) =>
            element.dealsStage != 'Closed Lost' &&
            element.dealsStage != 'Closed Won')
        .toList();
    dealsInPipeline = deals_Pipeline.length;
  }

  void _getDealsRevenueThisMonth() {
    var deals_won = widget.crmDealList
        .where((element) =>
            (getCTPDateTime(element.closingDate.toString())!.contains(
                DateFormat(DateFormat.ABBR_MONTH).format(DateTime.now()))) &&
            (getCTPDateTime(element.closingDate.toString())!
                .contains(DateFormat(DateFormat.YEAR).format(DateTime.now()))))
        .toList();
    var deals_won_this_month =
        deals_won.where((element) => element.dealsStage == 'Closed Won');
    revenueThisMonth = deals_won_this_month.length;
  }

  void _getDealsRevenueLostThisMonth() {
    var deals_lost = widget.crmDealList
        .where((element) =>
            (getCTPDateTime(element.closingDate.toString())!.contains(
                DateFormat(DateFormat.ABBR_MONTH).format(DateTime.now()))) &&
            (getCTPDateTime(element.closingDate.toString())!
                .contains(DateFormat(DateFormat.YEAR).format(DateTime.now()))))
        .toList();

    var deals_lost_this_month =
        deals_lost.where((element) => element.dealsStage == 'Closed Lost');
    revenueLostThisMonth = deals_lost_this_month.length;
  }
}
