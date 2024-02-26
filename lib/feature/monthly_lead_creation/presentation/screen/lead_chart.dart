import 'package:crm_dashboard/config/responsive/responsive.dart';
import 'package:crm_dashboard/feature/dashoard/data/model/CrmLeadModel.dart';
import 'package:crm_dashboard/feature/monthly_lead_creation/presentation/widget/lead_barchart.dart';
import 'package:crm_dashboard/shared/theme/app_text_styles.dart';
import 'package:crm_dashboard/shared/theme/colors.dart';
import 'package:crm_dashboard/shared/util/app_ennum_const_util.dart';
import 'package:crm_dashboard/shared/util/app_string.dart';
import 'package:flutter/material.dart';

class LeadBarChart extends StatelessWidget {
  LeadBarChart({Key? key, required this.crmLeadlist, required this.getAccess})
      : super(key: key);

  List<CrmLeadModel> crmLeadlist = [];
  String? getAccess;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Responsive.isDesktop(context) ? 300 : 300,
      width: Responsive.isDesktop(context)
          ? 550
          : Responsive.isTablet(context)
              ? double.infinity
              : double.infinity,
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(AppString.monthlyLeadCreation, style: AppTextStyles.titleStyle),
          Expanded(
            child: LeadBarchart(getAccess: getAccess),
          )
        ],
      ),
    );
  }
}
