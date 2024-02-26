import 'package:crm_dashboard/config/responsive/responsive.dart';
import 'package:crm_dashboard/feature/dashoard/presentation/screen/dashboard.dart';
import 'package:crm_dashboard/feature/lead_details/presentation/screen/lead_details_view/lead_others_details.dart';
import 'package:crm_dashboard/feature/lead_details/presentation/screen/lead_details_view/lead_total_details.dart';
import 'package:crm_dashboard/shared/theme/app_fonts.dart';
import 'package:crm_dashboard/shared/theme/colors.dart';
import 'package:crm_dashboard/shared/util/app_ennum_const_util.dart';
import 'package:crm_dashboard/shared/util/app_string.dart';
import 'package:flutter/material.dart';

import '../lead_details_view/lead_monthly_details.dart';
import '../lead_details_view/lead_todays_details.dart';
import '../lead_details_view/lead_untouched_details.dart';
import '../lead_details_view/lead_weekly_details.dart';

class LeadDetailTab extends StatefulWidget {
  LeadDetailTab(
      {Key? key,
      this.selectIndex,
      required this.hideappbar,
      required this.getAccess,
      this.dealsTabIndex})
      : super(key: key);

  int? selectIndex;
  int? dealsTabIndex;
  bool? hideappbar;
  String? getAccess;
  @override
  State<LeadDetailTab> createState() => _LeadDetailTabState();
}

class _LeadDetailTabState extends State<LeadDetailTab>
    with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  late TabController _tabController;
  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  @override
  void initState() {
    _tabController = TabController(length: 6, vsync: this);
    print('selected lead Index ${widget.selectIndex}');
    print('selected deal Index ${widget.dealsTabIndex}');
    if (widget.dealsTabIndex == 0) {
      widget.selectIndex == 5;
    }
    (widget.selectIndex != null) ? widget.selectIndex : widget.selectIndex = 0;

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
                                widget.selectIndex = 0;
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
                            child: Text(AppString.detailLeadList,
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    height: 40,
                    width:
                        (Responsive.isDesktop(context)) ? 220 : double.infinity,
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(0),
                        prefixIcon: const Icon(Icons.search_outlined),
                        hintText: AppString.search,
                        fillColor: AppColors.white,
                        filled: true,
                        suffixIcon: (searchController.text.isNotEmpty)
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                color: srmGulfBlue,
                                onPressed: () {
                                  setState(() {
                                    searchQuery = '';
                                    searchController.clear();
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  });
                                },
                              )
                            : null,
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: AppColors.gOffWhite),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: AppColors.gOffWhite),
                        ),
                      ),
                      onChanged: updateSearchQuery,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: TabBar(
                        isScrollable: (Responsive.isDesktop(context) ||
                                Responsive.isTablet(context))
                            ? false
                            : true,
                        onTap: (index) {
                          setState(() {
                            widget.selectIndex = index;
                          });
                        },
                        labelPadding:
                            const EdgeInsets.symmetric(horizontal: 05),
                        indicatorColor: Colors.transparent,
                        tabs: [
                          widget.selectIndex != 0
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
                                      AppString.totalLeads,
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
                                      AppString.totalLeads,
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
                          widget.selectIndex != 1
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
                                      AppString.todaysLeads,
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
                                      AppString.todaysLeads,
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
                          widget.selectIndex != 2
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
                                      AppString.weeklyLeadsCharts,
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
                                      AppString.weeklyLeadsCharts,
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
                          widget.selectIndex != 3
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
                                      AppString.monthlyLeadsCharts,
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
                                      color: srmBlueGreen),
                                  child: Center(
                                    child: Text(
                                      AppString.monthlyLeadsCharts,
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
                          widget.selectIndex != 4
                              ? Container(
                                  width: 140,
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
                                      AppString.untouchedLeads,
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
                                      AppString.untouchedLeads,
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
                          widget.selectIndex != 5
                              ? Container(
                                  width: 140,
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
                                      AppString.othersLeads,
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
                                      AppString.othersLeads,
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
                          if (widget.selectIndex == 0)
                            LeadTotalDetails(
                                searchQuery: searchQuery, getAccess: getAccess),
                          if (widget.selectIndex == 1)
                            LeadTodaysDetails(
                                searchQuery: searchQuery, getAccess: getAccess),
                          if (widget.selectIndex == 2)
                            LeadWeeklyDetails(
                                searchQuery: searchQuery, getAccess: getAccess),
                          if (widget.selectIndex == 3)
                            LeadMonthlyDetails(
                                searchQuery: searchQuery, getAccess: getAccess),
                          if (widget.selectIndex == 4)
                            LeadUntouchedDetails(
                                searchQuery: searchQuery, getAccess: getAccess),
                          if (widget.selectIndex == 5)
                            LeadOthersDetails(
                                searchQuery: searchQuery, getAccess: getAccess),
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
