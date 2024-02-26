import 'package:crm_dashboard/config/responsive/responsive.dart';
import 'package:crm_dashboard/feature/dashoard/presentation/widget/dashboard_card_list.dart';
import 'package:crm_dashboard/shared/theme/app_text_styles.dart';
import 'package:crm_dashboard/shared/theme/colors.dart';
import 'package:crm_dashboard/shared/util/app_ennum_const_util.dart';
import 'package:flutter/material.dart';

class DashboardCardListInfo extends StatelessWidget {
  DashboardCardListInfo({
    Key? key,
    required this.dashboardCardView,
  }) : super(key: key);

  final DashboardCardView dashboardCardView;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
          color: secondaryColor, borderRadius: BorderRadius.circular(6)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${dashboardCardView.counts}",
                  style: Responsive.isDesktop(context)
                      ? AppTextStyles.titleStyle
                      : AppTextStyles.titleStyleTablet)
            ],
          ),
          Text(dashboardCardView.title!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Responsive.isDesktop(context)
                  ? AppTextStyles.titleStyle
                  : AppTextStyles.titleStyleTablet),
        ],
      ),
    );
  }
}
