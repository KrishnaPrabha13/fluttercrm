import 'package:crm_dashboard/config/responsive/responsive.dart';
import 'package:crm_dashboard/feature/weekly_lead_creations/presentation/screen/weekly_chart.dart';
import 'package:crm_dashboard/shared/theme/app_text_styles.dart';
import 'package:crm_dashboard/shared/theme/colors.dart';
import 'package:crm_dashboard/shared/util/app_ennum_const_util.dart';
import 'package:crm_dashboard/shared/util/app_string.dart';
import 'package:flutter/material.dart';

class LineChart extends StatelessWidget {
  LineChart({Key? key, required this.getAccess}) : super(key: key);
  String? getAccess;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Responsive.isDesktop(context) ? 480 : 300,
      width: Responsive.isDesktop(context) ? 400 : double.infinity,
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppString.weeklyLeadsCharts, style: AppTextStyles.titleStyle),
          Expanded(
            child: WeeklyChart(getAccess: getAccess),
            //ViewLineChart(),
          )
        ],
      ),
    );
  }
}
