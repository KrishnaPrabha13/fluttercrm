import 'package:crm_dashboard/config/responsive/responsive.dart';
import 'package:crm_dashboard/feature/dashoard/presentation/screen/dashboard.dart';
import 'package:crm_dashboard/feature/deals_info/data/model/DealsDataModel.dart';
import 'package:crm_dashboard/feature/deals_info/presentation/screen/deals_in_pipeline.dart';
import 'package:crm_dashboard/feature/deals_info/presentation/screen/deals_revenue_lost_detail.dart';
import 'package:crm_dashboard/feature/deals_info/presentation/screen/deals_revenue_month_detail.dart';
import 'package:crm_dashboard/feature/deals_info/presentation/screen/deals_this_month_detail.dart.dart';
import 'package:crm_dashboard/feature/deals_info/presentation/screen/deals_total_detail.dart';
import 'package:crm_dashboard/shared/theme/app_fonts.dart';
import 'package:crm_dashboard/shared/theme/colors.dart';
import 'package:crm_dashboard/shared/util/app_ennum_const_util.dart';
import 'package:crm_dashboard/shared/util/app_string.dart';
import 'package:flutter/material.dart';

class DealsDetailTab extends StatefulWidget {
  DealsDetailTab(
      {Key? key,
      // this.dealsTabIndex,
      required this.hideappbar,
      required this.getAccess})
      : super(key: key);

  //List<DealsDataModel> crmDealList = [];
  //int? dealsTabIndex;
  bool? hideappbar;
  String? getAccess;
  @override
  State<DealsDetailTab> createState() => DealsDetailTabState();
}

class DealsDetailTabState extends State<DealsDetailTab>
    with TickerProviderStateMixin {
  String searchQuery = '';
  List<DealsDataModel> dealsDataModelList = [];
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);

    setState(() {
      getAccess;
      print('selectIndex Init ${selectIndex}');
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 6,
        child: Scaffold(
          backgroundColor: AppColors.primaryBg,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (widget.hideappbar == true)
                  ? const SizedBox(
                      height: 20,
                    )
                  : const SizedBox(
                      height: 5,
                    ),
              (widget.hideappbar == true)
                  ? Container()
                  : Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10),
                          child: Center(
                            child: InkWell(
                              child: const Icon(
                                Icons.arrow_back,
                                color: AppColors.primary,
                              ),
                              onTap: () {
                                setState(() {
                                  selectIndex = 0;
                                  // widget.selectIndex = 1;
                                });
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Dashboard();
                                    },
                                  ),
                                  (route) => false,
                                );
                              },
                            ),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10),
                          child: Center(
                            child: Text(AppString.dealsDetails,
                                style: TextStyle(
                                    fontSize:
                                        Responsive.isDesktop(context) ? 14 : 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontName.montserrat)),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                      height: 50,
                      //width: MediaQuery.of(context).size.width,
                      child: TabBar(
                        isScrollable: (Responsive.isDesktop(context) ||
                                Responsive.isTablet(context))
                            ? false
                            : true,
                        onTap: (index) {
                          setState(() {
                            selectIndex = index;
                            print('selectIndex onTap ${selectIndex}');
                          });
                        },
                        labelPadding:
                            const EdgeInsets.symmetric(horizontal: 05),
                        indicatorColor: Colors.transparent,
                        tabs: [
                          selectIndex != 0
                              //widget.selectIndex != 1
                              ? Container(
                                  width: 130,
                                  height: 44,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          width: 1, color: Color(0xFFE0E0E0)),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      AppString.totalDeals,
                                      style: TextStyle(
                                          color: black,
                                          fontFamily: FontName.montserrat,
                                          fontSize:
                                              (Responsive.isDesktop(context))
                                                  ? 13
                                                  : 11),
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 130,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: srmBlueGreen,
                                  ),
                                  child: Center(
                                    child: Text(
                                      AppString.totalDeals,
                                      style: TextStyle(
                                          color: AppColors.white,
                                          fontFamily: FontName.montserrat,
                                          fontSize:
                                              (Responsive.isDesktop(context))
                                                  ? 13
                                                  : 11),
                                    ),
                                  ),
                                ),
                          (selectIndex != 1)
                              ? Container(
                                  width: 150,
                                  height: 44,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          width: 1, color: Color(0xFFE0E0E0)),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      AppString.dealsCreatedThisMonth,
                                      style: TextStyle(
                                          color: black,
                                          fontFamily: FontName.montserrat,
                                          fontSize:
                                              (Responsive.isDesktop(context))
                                                  ? 13
                                                  : 11),
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 130,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: srmBlueGreen,
                                  ),
                                  child: Center(
                                    child: Text(
                                      AppString.dealsCreatedThisMonth,
                                      style: TextStyle(
                                          color: AppColors.white,
                                          fontFamily: FontName.montserrat,
                                          fontSize:
                                              (Responsive.isDesktop(context))
                                                  ? 13
                                                  : 11),
                                    ),
                                  ),
                                ),
                          selectIndex != 2
                              ? Container(
                                  width: 150,
                                  height: 44,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          width: 1, color: Color(0xFFE0E0E0)),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      AppString.dealsPipeline,
                                      style: TextStyle(
                                          color: black,
                                          fontFamily: FontName.montserrat,
                                          fontSize:
                                              (Responsive.isDesktop(context))
                                                  ? 13
                                                  : 11),
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 130,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: srmBlueGreen,
                                  ),
                                  child: Center(
                                    child: Text(
                                      AppString.dealsPipeline,
                                      style: TextStyle(
                                          color: AppColors.white,
                                          fontFamily: FontName.montserrat,
                                          fontSize:
                                              (Responsive.isDesktop(context))
                                                  ? 13
                                                  : 11),
                                    ),
                                  ),
                                ),
                          selectIndex != 3
                              ? Container(
                                  width: 150,
                                  height: 44,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          width: 1, color: Color(0xFFE0E0E0)),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      AppString.revenueThisMonth,
                                      style: TextStyle(
                                          color: black,
                                          fontFamily: FontName.montserrat,
                                          fontSize:
                                              (Responsive.isDesktop(context))
                                                  ? 13
                                                  : 11),
                                    ),
                                  ),
                                )
                              : Container(
                                  width:
                                      Responsive.isDesktop(context) ? 145 : 140,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: srmBlueGreen,
                                  ),
                                  child: Center(
                                    child: Text(
                                      AppString.revenueThisMonth,
                                      style: TextStyle(
                                          color: AppColors.white,
                                          fontFamily: FontName.montserrat,
                                          fontSize:
                                              (Responsive.isDesktop(context))
                                                  ? 13
                                                  : 11),
                                    ),
                                  ),
                                ),
                          selectIndex != 4
                              ? Container(
                                  width: 175,
                                  height: 44,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          width: 1, color: Color(0xFFE0E0E0)),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      AppString.revenueLostThisMonth,
                                      style: TextStyle(
                                          color: black,
                                          fontFamily: FontName.montserrat,
                                          fontSize:
                                              (Responsive.isDesktop(context))
                                                  ? 13
                                                  : 11),
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 170,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: srmBlueGreen,
                                  ),
                                  child: Center(
                                    child: Text(
                                      AppString.revenueLostThisMonth,
                                      style: TextStyle(
                                          color: AppColors.white,
                                          fontFamily: FontName.montserrat,
                                          fontSize:
                                              (Responsive.isDesktop(context))
                                                  ? 13
                                                  : 11),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          if (selectIndex == 0)
                            TotalDealsDetailPage(
                                hideappbar: true, getAccess: widget.getAccess),
                          if (selectIndex == 1)
                            DealsThisMonthDetail(
                                //dealsTabIndex: 2,
                                hideappbar: true,
                                getAccess: widget.getAccess),
                          if (selectIndex == 2)
                            DealsInPipeline(
                                //selectIndex: 3,
                                hideappbar: true,
                                getAccess: widget.getAccess),
                          if (selectIndex == 3)
                            RevenueThisMonth(
                                //selectIndex: 4,
                                hideappbar: true,
                                getAccess: widget.getAccess),
                          if (selectIndex == 4)
                            RevenueLostThisMonth(
                                //selectIndex: 5,
                                hideappbar: true,
                                getAccess: widget.getAccess),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
