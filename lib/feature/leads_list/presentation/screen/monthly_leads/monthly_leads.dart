import 'package:crm_dashboard/feature/dashoard/data/model/CrmLeadModel.dart';
import 'package:crm_dashboard/feature/leads_list/presentation/widget/lead_info_details.dart';
import 'package:crm_dashboard/shared/theme/app_text_styles.dart';
import 'package:crm_dashboard/shared/theme/colors.dart';
import 'package:crm_dashboard/shared/util/app_ennum_const_util.dart';
import 'package:crm_dashboard/shared/util/app_string.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthlyLeads extends StatelessWidget {
  MonthlyLeads({
    Key? key,
    required this.crmLeadlist
  }) : super(key: key);

  List<CrmLeadModel> crmLeadlist ;

  List<CrmLeadModel> monthlyList = [];

  @override
  Widget build(BuildContext context) {

    monthlyList = crmLeadlist.where((element) => (element.createdTime.toString().
    contains(DateFormat(DateFormat.ABBR_MONTH).format(DateTime.now())))&&
        (element.createdTime.toString().contains(DateFormat(DateFormat.YEAR).format(DateTime.now()))) ).toList();

    return Container(
      height: 350,
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppString.monthlyLeadsCharts,
          style: AppTextStyles.titleStyle),
              Text(
                'View All',
                  style: AppTextStyles.titleStyle),
            ],
          ),
          SizedBox(
            height: defaultPadding,
          ),
          Expanded(
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: monthlyList.length,
              itemBuilder: (context, index) => LeadsInfoDetail(info: monthlyList[index]),
            ),
          )
        ],
      ),
    );
  }
}
