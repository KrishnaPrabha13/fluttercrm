import 'package:crm_dashboard/config/responsive/responsive.dart';
import 'package:crm_dashboard/feature/dashoard/data/model/CrmLeadModel.dart';
import 'package:crm_dashboard/feature/dashoard/presentation/widget/dashbaord_lead_card/dashboard_lead_card.dart';
import 'package:crm_dashboard/feature/deals_pipeline/presentation/screen/deals_chart.dart';
import 'package:crm_dashboard/feature/lead_by_source/presentation/screen/lead_by_source.dart';
import 'package:crm_dashboard/feature/leads_list/presentation/screen/today_leads/total_lead_info_dashboard.dart';
import 'package:crm_dashboard/feature/monthly_lead_creation/presentation/screen/lead_chart.dart';
import 'package:crm_dashboard/feature/weekly_lead_creations/presentation/screen/line_chart.dart';
import 'package:crm_dashboard/shared/util/app_ennum_const_util.dart';
import 'package:flutter/material.dart';

class DashboardContent extends StatelessWidget {
  DashboardContent(
      {Key? key, required this.crmLeadlist, required this.getAccess})
      : super(key: key);

  List<CrmLeadModel> crmLeadlist = [];
  String? getAccess;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          const SizedBox(
            height: defaultPadding,
          ),
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DashboardLeadCard(
                            crmLeadlist: crmLeadlist.toList(),
                            getAccess: getAccess),
                        const SizedBox(
                          height: defaultPadding,
                        ),
                        if (Responsive.isMobile(context) ||
                            Responsive.isTablet(context))
                          LeadBarChart(
                              crmLeadlist: crmLeadlist.toList(),
                              getAccess: getAccess),
                        if (Responsive.isTablet(context))
                          const SizedBox(
                            height: defaultPadding,
                          ),
                        if (Responsive.isTablet(context))
                          LeadBySource(getAccess: getAccess),
                        if (Responsive.isDesktop(context))
                          Row(
                            children: [
                              LeadBarChart(
                                  crmLeadlist: crmLeadlist.toList(),
                                  getAccess: getAccess),
                              if (Responsive.isDesktop(context))
                                const SizedBox(
                                  width: defaultPadding,
                                ),
                              Expanded(
                                flex: 1,
                                child: LeadBySource(getAccess: getAccess),
                              ),
                            ],
                          ),
                        if (!Responsive.isMobile(context))
                          const SizedBox(
                            height: defaultPadding,
                          ),
                        if (Responsive.isDesktop(context))
                          Row(
                            children: [
                              DealsChart(getAccess: getAccess),
                              if (Responsive.isDesktop(context))
                                const SizedBox(
                                  width: defaultPadding,
                                ),
                              Expanded(
                                flex: 3,
                                child: LineChart(getAccess: getAccess),
                              ),
                            ],
                          ),
                        if (Responsive.isMobile(context))
                          const SizedBox(
                            height: defaultPadding,
                          ),
                        if (Responsive.isMobile(context))
                          TotalLeadInfoDashboard(
                            crmLeadlist: crmLeadlist.toList(),
                          ),
                        if (Responsive.isMobile(context))
                          const SizedBox(
                            height: defaultPadding,
                          ),
                        if (Responsive.isTablet(context))
                          DealsChart(getAccess: getAccess),
                        if (Responsive.isMobile(context))
                          LeadBySource(getAccess: getAccess),
                      ],
                    ),
                  ),
                  if (!Responsive.isMobile(context))
                    const SizedBox(
                      width: defaultPadding,
                    ),
                  if (!Responsive.isMobile(context))
                    Expanded(
                      flex: 2,
                      child: TotalLeadInfoDashboard(
                        crmLeadlist: crmLeadlist.toList(),
                      ),
                    ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        if (Responsive.isMobile(context) ||
                            Responsive.isTablet(context))
                          const SizedBox(
                            height: defaultPadding,
                          ),
                        if (Responsive.isMobile(context))
                          DealsChart(getAccess: getAccess),
                        if (Responsive.isMobile(context))
                          const SizedBox(
                            height: defaultPadding,
                          ),
                        if (!Responsive.isDesktop(context))
                          LineChart(getAccess: getAccess),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
