import 'package:crm_dashboard/config/responsive/responsive.dart';
import 'package:crm_dashboard/feature/dashoard/data/model/CrmLeadModel.dart';
import 'package:crm_dashboard/shared/theme/app_fonts.dart';
import 'package:crm_dashboard/shared/theme/app_text_styles.dart';
import 'package:crm_dashboard/shared/util/app_ennum_const_util.dart';
import 'package:crm_dashboard/shared/util/image_util.dart';
import 'package:flutter/material.dart';

class LeadsInfoDetail extends StatelessWidget {
  LeadsInfoDetail({Key? key, required this.info}) : super(key: key);

  CrmLeadModel info;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: defaultPadding),
      padding: EdgeInsets.all(defaultPadding / 2),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Image.asset(
              profileIcon!,
              height: 38,
              width: 38,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    info.company!,
                    style: AppTextStyles.titleStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(info.businessUnit!,
                      style: AppTextStyles.subtitleStyle,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ),
          Text(
            "${info.probability}%",
            style: TextStyle(
                color: Colors.black,
                fontFamily: FontName.montserrat,
                overflow: TextOverflow.ellipsis,
                fontSize: (Responsive.isDesktop(context)) ? 13 : 11),
          ),
        ],
      ),
    );
  }
}
