import 'package:crm_dashboard/shared/theme/colors.dart';
import 'package:crm_dashboard/shared/util/image_util.dart';
import 'package:flutter/material.dart';

class DashboardCardView {
  final String? svgSrc, title, info;
  final int? counts, percentage;
  final Color? color;

  const DashboardCardView(
    this.info,{
    this.svgSrc,
    this.title,
    this.counts,
    this.percentage,
    this.color,
  });

}
