import 'package:crm_dashboard/config/responsive/responsive.dart';
import 'package:crm_dashboard/feature/dashoard/data/model/CrmLeadModel.dart';
import 'package:crm_dashboard/feature/dashoard/presentation/widget/dashbaord_lead_card/dashboard_lead_card_gridview.dart';
import 'package:flutter/material.dart';

class DashboardLeadCard extends StatelessWidget {
  DashboardLeadCard(
      {Key? key, required this.crmLeadlist, required this.getAccess})
      : super(key: key);

  List<CrmLeadModel> crmLeadlist = [];
  String? getAccess;
  List<CrmLeadModel> countList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Responsive(
        smallMobile: DashboardLeadCardGridView(
            crossAxisCount: Responsive.isSmall(context) ? 2 : 4,
            childAspectRatio: Responsive.isSmall(context) ? 1.3 : 1,
            crmLeadlist: crmLeadlist.toList(),
            getAccess: getAccess),
        mobile: DashboardLeadCardGridView(
            crossAxisCount: Responsive.isMobile(context) ? 2 : 4,
            childAspectRatio: Responsive.isMobile(context) ? 2 : 1.5,
            crmLeadlist: crmLeadlist.toList(),
            getAccess: getAccess),
        tablet: DashboardLeadCardGridView(
            crmLeadlist: crmLeadlist.toList(), getAccess: getAccess),
        desktop: DashboardLeadCardGridView(
            childAspectRatio: Responsive.isDesktop(context) ? 1.5 : 2.1,
            crmLeadlist: crmLeadlist.toList(),
            getAccess: getAccess),
      ),
    );
  }
}
