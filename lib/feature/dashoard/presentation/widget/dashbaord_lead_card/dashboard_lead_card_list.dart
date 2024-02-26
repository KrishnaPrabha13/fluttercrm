import 'package:crm_dashboard/feature/dashoard/presentation/widget/dashboard_card_list.dart';
import 'package:crm_dashboard/shared/theme/colors.dart';
import 'package:crm_dashboard/shared/util/app_ennum_const_util.dart';
import 'package:crm_dashboard/shared/util/app_string.dart';
import 'package:crm_dashboard/shared/util/image_util.dart';
import 'package:flutter/cupertino.dart';

List getDashboardLeadCard(BuildContext context) {
  return [
    DashboardCardView(
      title: AppString.totalLeads,
      counts: totalLeads,
      svgSrc: profile,
      "",
      color: primaryColor,
      percentage: 60,
    ),
    DashboardCardView(
      title: AppString.todaysLeads,
      counts: todaysLeads,
      svgSrc: profile,
      "",
      color: primaryColor,
      percentage: 60,
    ),
    DashboardCardView(
      title: AppString.thisWeekLeads,
      counts: weeklyLeads,
      svgSrc: week,
      "",
      color: purple,
      percentage: 30,
    ),
    DashboardCardView(
      title: AppString.thisMonthLeads,
      counts: monthlyLeads,
      svgSrc: month,
      "",
      color: AppColors.blue,
      percentage: 80,
    ),
    DashboardCardView(
      title: AppString.untouchedLeads,
      counts: unTouchedLeads,
      svgSrc: untouchedLeads,
      "",
      color: orange,
      percentage: 0,
    ),
  ];
}
