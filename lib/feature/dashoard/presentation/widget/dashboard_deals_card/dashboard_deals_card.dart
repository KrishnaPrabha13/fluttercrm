import 'package:crm_dashboard/config/responsive/responsive.dart';
import 'package:crm_dashboard/feature/dashoard/presentation/widget/dashboard_deals_card/dashboard_deals_card_gridview.dart';
import 'package:crm_dashboard/feature/deals_info/data/model/DealsDataModel.dart';
import 'package:flutter/material.dart';

class DashboardDealsCard extends StatefulWidget {
  DashboardDealsCard({Key? key, required this.crmDealList}) : super(key: key);

  List<DealsDataModel> crmDealList = [];

  @override
  State<DashboardDealsCard> createState() => _DashboardDealsCardState();
}

class _DashboardDealsCardState extends State<DashboardDealsCard> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
      smallMobile: DashboardDealsCardGridView(
          crossAxisCount: Responsive.isSmall(context) ? 2 : 4,
          childAspectRatio: Responsive.isSmall(context) ? 1.3 : 1,
          crmDealList: widget.crmDealList.toList()),
      mobile: DashboardDealsCardGridView(
          crossAxisCount: Responsive.isMobile(context) ? 2 : 4,
          childAspectRatio: Responsive.isMobile(context) ? 2 : 1.5,
          crmDealList: widget.crmDealList.toList()),
      tablet:
          DashboardDealsCardGridView(crmDealList: widget.crmDealList.toList()),
      desktop: DashboardDealsCardGridView(
          childAspectRatio: Responsive.isDesktop(context) ? 1.5 : 2.1,
          crmDealList: widget.crmDealList.toList()),
    );
  }
}
