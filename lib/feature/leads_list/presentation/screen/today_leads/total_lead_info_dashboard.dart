import 'dart:convert';

import 'package:crm_dashboard/feature/dashoard/data/model/CrmLeadModel.dart';
import 'package:crm_dashboard/feature/dashoard/presentation/widget/dashboard_deals_card/dashboard_deals_card.dart';
import 'package:crm_dashboard/feature/deals_info/data/model/DealsDataModel.dart';
import 'package:crm_dashboard/feature/lead_details/presentation/screen/tabview/lead_detail_tab.dart';
import 'package:crm_dashboard/feature/leads_list/presentation/widget/lead_info_details.dart';
import 'package:crm_dashboard/shared/data_sources/local/shared_preference.dart';
import 'package:crm_dashboard/shared/data_sources/remote/firebase_deal_services.dart';
import 'package:crm_dashboard/shared/theme/app_text_styles.dart';
import 'package:crm_dashboard/shared/theme/colors.dart';
import 'package:crm_dashboard/shared/util/app_ennum_const_util.dart';
import 'package:crm_dashboard/shared/util/app_string.dart';
import 'package:flutter/material.dart';

class TotalLeadInfoDashboard extends StatefulWidget {
  TotalLeadInfoDashboard({
    Key? key,
    required this.crmLeadlist,
  }) : super(key: key);

  List<CrmLeadModel> crmLeadlist;

  List<DealsDataModel> crmDealList = [];

  @override
  State<TotalLeadInfoDashboard> createState() => _TotalLeadInfoDashboardState();
}

class _TotalLeadInfoDashboardState extends State<TotalLeadInfoDashboard> {
  List<CrmLeadModel> overAllList = [];
  final FirebaseDealsServices _firebaseDealsServices = FirebaseDealsServices();
  List<Map<dynamic, dynamic>> lists = [];
  List<DealsDataModel> dealsDataModelList = [];
  final SharedPrefsService _sharedPrefsService = SharedPrefsService();
  void _initCheck() async {
    setState(() {
      _sharedPrefsService.getAccess().then((value) {
        userAccess = value;
        print('userAccess ${userAccess.toString()}');
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _initCheck();
  }

  @override
  Widget build(BuildContext context) {
    userAccess.toString() == 'All'
        ? (selectedText == 'Select Business Unit')
            ? getAccess = 'All'
            : getAccess = selectedText
        : getAccess = userAccess.toString();
    print('listdata getAccess ${getAccess!}');
    overAllList = widget.crmLeadlist
        .where((element) =>
            element.recordId.toString().contains(element.recordId.toString()))
        .toList();

    return Column(
      children: [
        FutureBuilder<List<DealsDataModel>>(
          future: _firebaseDealsServices.getTotalDeals(context, getAccess),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<DealsDataModel>? data = snapshot.data;
              //print('listdata72 ${data!}');
              String jsonDeal = jsonEncode(data);
              final crmDealsData = json.decode(jsonDeal);
              var deallist = crmDealsData as List<dynamic>;
              dealsDataModelList = [];
              dealsDataModelList.clear();
              dealsDataModelList =
                  deallist.map((e) => DealsDataModel.fromJson(e)).toList();
              //print('listdata80 ${dealsDataModelList.toList().length}');
              return DashboardDealsCard(
                  crmDealList: dealsDataModelList.toList());
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        Container(
          height: 500,
          padding: const EdgeInsets.all(defaultPadding),
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: defaultPadding,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppString.totalLeads, style: AppTextStyles.titleStyle),
                  InkWell(
                      child: Text(AppString.viewAll,
                          style: AppTextStyles.titleStyle),
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LeadDetailTab(
                                  selectIndex: 0,
                                  hideappbar: false,
                                  getAccess: getAccess);
                            },
                          ),
                          (route) => false,
                        );
                      }),
                ],
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              Expanded(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: overAllList.length,
                  itemBuilder: (context, index) =>
                      LeadsInfoDetail(info: overAllList[index]),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
