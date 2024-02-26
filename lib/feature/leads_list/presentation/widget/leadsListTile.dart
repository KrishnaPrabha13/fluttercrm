import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:crm_dashboard/shared/theme/colors.dart';
import 'package:crm_dashboard/shared/theme/style.dart';

class LeadsListTile extends StatelessWidget {
  final String icon;
  final String title;
  final String percentage;
  final String subtitle;

  const LeadsListTile({super.key,
    required this.icon, required this.title,required this.percentage,required this.subtitle
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 0, right: 20),
      visualDensity: VisualDensity.standard,
      leading: Container(
          width: 50,
          padding: const EdgeInsets.symmetric(
              vertical: 15, horizontal: 10),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: SvgPicture.asset(
            icon,
            width: 20,
          )),
      title: PrimaryText(
          text: title,
          size: 14,
          color: AppColors.darkBlue1,
          fontWeight: FontWeight.w500),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PrimaryText(
            text: subtitle,
            size: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.secondary,
          ),
          PrimaryText(
          text: "$percentage %",
          size: 16,
              color: black,
          fontWeight: FontWeight.w600),
        ],
      ),
      onTap: () {
        print('tap');
      },
      selected: true,
    );
  }
}
