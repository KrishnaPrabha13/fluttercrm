import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:crm_dashboard/config/responsive/responsive.dart';
import 'package:crm_dashboard/feature/deals_info/data/model/DealsDataModel.dart';
import 'package:crm_dashboard/feature/deals_pipeline/data/deal_by_stages.dart';
import 'package:crm_dashboard/feature/deals_pipeline/data/dealby_sourcemodel.dart';
import 'package:crm_dashboard/shared/data_sources/remote/firebase_deal_services.dart';
import 'package:crm_dashboard/shared/theme/app_fonts.dart';
import 'package:crm_dashboard/shared/util/app_ennum_const_util.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../shared/util/common_util.dart';
import '../../../../shared/util/globals.dart';

class DealsChartData extends StatefulWidget {
  DealsChartData({Key? key, required this.getAccess}) : super(key: key);
  String? getAccess;
  @override
  State<StatefulWidget> createState() {
// TODO: implement createState
    return DealsChartDataState();
  }
}

class DealsChartDataState extends State<DealsChartData> {
  late ChartDataLabelPosition _selectedLabelPosition;
  late LabelIntersectAction _intersectAction;
  late OverflowMode _overflowMode;
  final FirebaseDealsServices _firebaseDealsServices = FirebaseDealsServices();
  List<Map<dynamic, dynamic>> lists = [];
  List<DealsDataModel> crmDealList = [];
  List<DealsDataModel> countList = [];
  List<String> DealSourceList = [];
  String? dealSource_data;
  int? orderbystatus;
  List<DealbystageModel> dealbystagemodel = [];
  final FirebaseDealsServices _firebaseDealServices = FirebaseDealsServices();
  late double gapRatio;
  late int neckWidth;
  late int neckHeight;
  late bool explode;
  @override
  void initState() {
    _selectedLabelPosition = ChartDataLabelPosition.inside;
    _intersectAction = LabelIntersectAction.shift;
    _overflowMode = OverflowMode.none;
    gapRatio = 0;
    neckWidth = 20;
    neckHeight = 20;
    explode = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
// TODO: implement build
    return FutureBuilder<List<DealsDataModel>>(
      future:
          _firebaseDealServices.getDealsInPipelineChart(context, getAccess!),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<DealsDataModel>? data = snapshot.data;
          String jsonDeal = jsonEncode(data);
          final crmDealData = json.decode(jsonDeal);
          var deallist = crmDealData as List<dynamic>;
          crmDealList = [];
          crmDealList.clear();
          crmDealList =
              deallist.map((e) => DealsDataModel.fromJson(e)).toList();
          _getDealByPipeline();
          return _buildFunnelSmartLabelChart();
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  ///Get the funnel chart with smart data label
  SfFunnelChart _buildFunnelSmartLabelChart() {
    return SfFunnelChart(
      tooltipBehavior: TooltipBehavior(
        enable: true,
      ),
      series: _getFunnelSeries(),
    );
  }

  ///Get the funnel series with smart data label
  FunnelSeries<DealbystageModel, String> _getFunnelSeries() {
    gapRatio = gapRatio;
    neckWidth = neckWidth;
    neckHeight = neckHeight;
    explode = explode;
    return FunnelSeries<DealbystageModel, String>(
        width: Responsive.isDesktop(context)
            ? '75%'
            : Responsive.isTablet(context)
                ? '75%'
                : '75%',
        height: Responsive.isDesktop(context)
            ? '75%'
            : Responsive.isTablet(context)
                ? '75%'
                : '80%',
        dataSource: dealbystagemodel,
        xValueMapper: (DealbystageModel dealbystage, _) =>
            dealbystage.dealbystage as String,
        yValueMapper: (DealbystageModel dealbystage, _) => dealbystage.count,
        pointColorMapper: (DealbystageModel dealbystage, _) =>
            getDealsColor(dealbystage.dealbystage),
        explode: isCardView ? false : explode,
        gapRatio: isCardView ? 0 : gapRatio,
        neckHeight: isCardView ? '20%' : neckHeight.toString() + '%',
        neckWidth: isCardView ? '20%' : neckWidth.toString() + '%',

        /// To enable the data label for funnel chart.
        dataLabelSettings: DataLabelSettings(
            isVisible: true,
            labelPosition: ChartDataLabelPosition.outside,
            alignment: ChartAlignment.center,
            textStyle: TextStyle(fontFamily: FontName.montserrat),
            labelIntersectAction: _intersectAction,
            overflowMode: _overflowMode,
            useSeriesColor: true));
  }

  void _getDealByPipeline() {
    var groupByDealSource = groupBy(
      crmDealList,
      (obj) => obj.dealsStage.toString(),
    );
    DealSourceList.clear();
    dealSource_data = '';
    groupByDealSource.forEach((dealSource, list) {
      dealSource_data = dealSource;

      countList = crmDealList
          .where((element) => element.dealsStage
              .toString()
              .contains(dealSource_data.toString()))
          .toList();
      getDealsStageStatus(dealSource_data);
      DealByStages dealByStages = DealByStages(
          dealSource_data.toString(), countList.length, orderbystatus!);

      String jsonUser = jsonEncode(dealByStages);
      DealSourceList.add(jsonUser.toString());
    });

    final dynamic jsonResponse = json.decode(DealSourceList.toString());
    dealbystagemodel.clear();
    for (Map<String, dynamic> i in jsonResponse) {
      dealbystagemodel.add(DealbystageModel.fromJson(i));
    }
    dealbystagemodel.sort((b, a) {
      return a.orderbystatus!.toInt().compareTo(b.orderbystatus!.toInt());
    });
  }

  getDealsStageStatus(String? stages) {
    switch (stages) {
      case 'Qualification':
        orderbystatus = 1;
        break;
      case 'Needs Analysis':
        orderbystatus = 2;
        break;
      case 'Value Proposition':
        orderbystatus = 3;
        break;
      case 'Identify Decision Mak':
        orderbystatus = 4;
        break;
      case 'Proposal/Price Quote':
        orderbystatus = 5;
        break;
      case 'Negotiation/Review':
        orderbystatus = 6;
        break;
      case 'Closed Won':
        orderbystatus = 7;
        break;
      case 'Closed Lost':
        orderbystatus = 8;
        break;
      default:
        orderbystatus = 9;
        break;
    }
  }

  @override
  void dispose() {
    dealbystagemodel.clear();
    super.dispose();
  }
}
