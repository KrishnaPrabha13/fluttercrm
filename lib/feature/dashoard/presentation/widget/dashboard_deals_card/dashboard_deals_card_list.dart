import 'package:crm_dashboard/feature/dashoard/presentation/widget/dashboard_card_list.dart';
import 'package:crm_dashboard/shared/theme/colors.dart';
import 'package:crm_dashboard/shared/util/app_ennum_const_util.dart';
import 'package:crm_dashboard/shared/util/app_string.dart';
import 'package:crm_dashboard/shared/util/image_util.dart';
import 'package:flutter/material.dart';

List getDashboardDealsCard(BuildContext context) {
  return [
    DashboardCardView(
      title: AppString.othersLeads,
      counts: othersLeads,
      svgSrc: untouchedLeads,
      "",
      color: orange,
      percentage: 0,
    ),
    DashboardCardView(
      title: AppString.totalDeals,
      counts: totalDeals,
      svgSrc: deals,
      "",
      color: green,
      percentage: 0,
    ),
    DashboardCardView(
      title: AppString.dealsCreatedThisMonth,
      counts: monthlyDeals,
      svgSrc: deals,
      "",
      color: green,
      percentage: 0,
    ),
    DashboardCardView(
      title: AppString.dealsPipeline,
      counts: dealsInPipeline,
      svgSrc: pipeline,
      "",
      color: AppColors.yellow,
      percentage: 0,
    ),
    DashboardCardView(
      title: AppString.revenueThisMonth,
      counts: revenueThisMonth,
      svgSrc: revenue,
      "",
      color: AppColors.pink,
      percentage: 0,
    ),
    DashboardCardView(
      title: AppString.revenueLostThisMonth,
      counts: revenueLostThisMonth,
      svgSrc: revenueLoss,
      "",
      color: AppColors.lightBlue,
      percentage: 0,
    ),
  ];
}
