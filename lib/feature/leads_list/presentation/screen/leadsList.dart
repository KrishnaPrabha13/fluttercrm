import 'package:crm_dashboard/config/responsive/size_config.dart';
import 'package:crm_dashboard/feature/dashoard/data/model/CrmLeadModel.dart';
import 'package:crm_dashboard/feature/leads_list/presentation/widget/leadsListTile.dart';
import 'package:crm_dashboard/shared/theme/colors.dart';
import 'package:crm_dashboard/shared/theme/style.dart';
import 'package:crm_dashboard/shared/util/app_string.dart';
import 'package:crm_dashboard/shared/util/common_util.dart';
import 'package:crm_dashboard/shared/util/image_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LeadsList extends StatelessWidget {
  List<CrmLeadModel> crmLeadList;
  LeadsList({super.key, required this.crmLeadList});
  List<CrmLeadModel> todaysList = [];
  List<CrmLeadModel> monthlyList = [];
  @override
  Widget build(BuildContext context) {
    todaysList = crmLeadList
        .where((element) => element.createdTime
            .toString()
            .contains(DateFormat('MMM d, yyyy').format(DateTime.now())))
        .toList();

    monthlyList = crmLeadList
        .where((element) =>
            (element.createdTime.toString().contains(
                DateFormat(DateFormat.ABBR_MONTH).format(DateTime.now()))) &&
            (element.createdTime
                .toString()
                .contains(DateFormat(DateFormat.YEAR).format(DateTime.now()))))
        .toList();

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: SizeConfig.blockSizeVertical! * 5,
      ),
      Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(30), boxShadow: [
          BoxShadow(
            color: Colors.grey[400]!,
            blurRadius: 15.0,
            offset: const Offset(
              10.0,
              15.0,
            ),
          )
        ]),
        child: Container(),
        //Image.asset('assets/svg/card.png'),
      ),
      /*SizedBox(
        height: SizeConfig.blockSizeVertical! * 5,
      ),*/
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const PrimaryText(
              text: AppString.todaysLeads,
              size: 17,
              color: AppColors.darkBlue,
              fontWeight: FontWeight.w800),
          PrimaryText(
            text: getCurrentDateTime().toString(),
            size: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.iconGray,
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 2,
          ),
          SizedBox(
              height: 350,
              child: Container(
                child: ListView.builder(
                  itemCount: todaysList.length,
                  itemBuilder: (_, index) => LeadsListTile(
                      icon: profile,
                      title: todaysList[index].company!,
                      percentage: todaysList[index].probability!,
                      subtitle: todaysList[index].businessUnit!),
                ),
              )),
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 5,
          ),
          const PrimaryText(
              text: AppString.thisMonthLeads,
              size: 17,
              fontWeight: FontWeight.w800),
          PrimaryText(
            text: getCurrentDateTime().toString(),
            size: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.iconGray,
          ),
          SizedBox(
              height: 350,
              child: Container(
                child: ListView.builder(
                  itemCount: monthlyList.length,
                  itemBuilder: (_, index) => LeadsListTile(
                      icon: profile,
                      title: monthlyList[index].company!,
                      percentage: monthlyList[index].probability!,
                      subtitle: monthlyList[index].businessUnit!),
                ),
              )),
        ],
      )
      /*Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PrimaryText(
              text: AppString.todaysLeads, size: 17, color: AppColors.darkBlue, fontWeight: FontWeight.w800),
          PrimaryText(
            text: getCurrentDateTime().toString(),
            size: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.iconGray,
          ),
        ],
      ),
      SizedBox(
        height: SizeConfig.blockSizeVertical! * 2,
      ),
      Column(
        children: List.generate(
          todaysList.length,
              (index) => LeadsListTile(
              icon: profile,
              title: todaysList[index].company!,
              percentage: todaysList[index].probability!,
              subtitle: todaysList[index].businessUnit!),
        ),
      ),
      SizedBox(
        height: SizeConfig.blockSizeVertical! * 5,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PrimaryText(
              text: AppString.thisMonthLeads, size: 17, fontWeight: FontWeight.w800),
          PrimaryText(
            text: getCurrentDateTime().toString(),
            size: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.iconGray,
          ),
        ],
      ),
      SizedBox(
        height: SizeConfig.blockSizeVertical! * 2,
      ),
      Column(
        children: List.generate(
          monthlyList.length,
              (index) => LeadsListTile(
              icon: profile,
              title: monthlyList[index].company!,
              percentage: monthlyList[index].probability!,
              subtitle: monthlyList[index].businessUnit!),
        ),
      ),*/
    ]);
  }
}
