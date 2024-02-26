import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:crm_dashboard/feature/dashoard/data/model/CrmLeadModel.dart';
import 'package:crm_dashboard/feature/lead_by_source/data/model/lead_by_source.dart';
import 'package:crm_dashboard/feature/lead_by_source/data/model/leadbysource_model.dart';
import 'package:crm_dashboard/shared/data_sources/local/shared_preference.dart';
import 'package:crm_dashboard/shared/data_sources/remote/firebase_lead_services.dart';
import 'package:crm_dashboard/shared/theme/colors.dart';
import 'package:crm_dashboard/shared/util/app_ennum_const_util.dart';
import 'package:crm_dashboard/shared/util/image_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LeadBySourcePieChart extends StatefulWidget {
  LeadBySourcePieChart({Key? key, required this.getAccess}) : super(key: key);
  String? getAccess;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LeadBySourcePieChartState();
  }
}

class LeadBySourcePieChartState extends State<LeadBySourcePieChart> {
  late GlobalKey<SfCircularChartState> _circularChartKey;
  var sourceList = [];
  List<String> LeadBySourceList = [];
  var dayList = [];
  List<CrmLeadModel> countList = [];
  List<int> LeadBySourceCount = [];
  List<String> SourceList = [];
  List<LeadbysourceModel> leadbysourcemodel = [];
  List<CrmLeadModel> crmLeadList = [];
  late int? LeadBySource;
  List<DateTime> FinalDateList = [];
  String? leadSource_data;
  final FirebaseLeadServices _firebaseLeadServices = FirebaseLeadServices();
  List<Map<dynamic, dynamic>> lists = [];
  final SharedPrefsService _sharedPrefsService = SharedPrefsService();
  num totalValue = 0;
  int? percent;
  @override
  void initState() {
    _circularChartKey = GlobalKey();
    _initCheck();
    super.initState();
  }

  void _initCheck() async {
    setState(() {
      userAccess = getAccess;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CrmLeadModel>>(
      future: _firebaseLeadServices.getLeadBySource(context, '', getAccess!),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<CrmLeadModel>? data = snapshot.data;
          String jsonLead = jsonEncode(data);
          final crmLeadData = json.decode(jsonLead);
          var leadlist = crmLeadData as List<dynamic>;
          crmLeadList = [];
          crmLeadList.clear();
          crmLeadList = leadlist.map((e) => CrmLeadModel.fromJson(e)).toList();
          _getLeadSourcedata();
          return _buildCircularChart();
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  /// Get default circular chart
  SfCircularChart _buildCircularChart() {
    return SfCircularChart(
      key: _circularChartKey,
      legend: const Legend(
        isVisible: true,
        position: LegendPosition.bottom,
        overflowMode: LegendItemOverflowMode.wrap,
        iconBorderWidth: 1,
        iconBorderColor: srmDoveGrey,
      ),
      annotations: <CircularChartAnnotation>[
        CircularChartAnnotation(
            height: '30%',
            width: '30%',
            widget: SizedBox(
              height: 20,
              width: 20,
              child: SvgPicture.asset(
                profile,
                color: srmDoveGrey,
              ),
            ))
      ],
      series: _getDefaultCircularSeries(),
    );
  }

  /// Get default circular series
  List<CircularSeries<LeadbysourceModel, String>> _getDefaultCircularSeries() {
    return <CircularSeries<LeadbysourceModel, String>>[
      DoughnutSeries<LeadbysourceModel, String>(
          dataSource: leadbysourcemodel,
          xValueMapper: (LeadbysourceModel leadbysource, _) =>
              leadbysource.leadbysource as String,
          yValueMapper: (LeadbysourceModel leadbysource, _) =>
              leadbysource.count,
          radius: "75",
          strokeColor: srmGulfBlue,
          pointColorMapper: (LeadbysourceModel leadbysource, _) =>
              _getColor(leadbysource.leadbysource),
          explode: true,
          strokeWidth: 0.5,
          legendIconType: LegendIconType.rectangle,
          dataLabelMapper: (LeadbysourceModel leadBySource, _) =>
              //getPercentage(100 * (leadBySource.count! / totalLeads!)),
              // "${(100 * (leadBySource.count! / totalLeads!)).round()} %",

              "${leadBySource.count!} %",
          //"${double.parse((100 * (leadBySource.count! / totalLeads!)).toStringAsFixed(1))} %",
          dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              color: AppColors.barBg,
              labelPosition: ChartDataLabelPosition.outside))
    ];
  }

  Color? _getColor(String? source) {
    Color? _color;
    switch (source) {
      case 'Cold Calling':
        _color = lightBlue;
        break;
      case 'WebSite Visit':
        _color = darkBlue1;
        break;
      case 'Referrals':
        _color = lightPurple;
        break;
      case 'Chat':
        _color = lightRed;
        break;
    }
    return _color;
  }

  void _getLeadSourcedata() {
    var groupByleadSource =
        groupBy(crmLeadList, (obj) => obj.leadSource.toString());
    SourceList.clear();
    leadSource_data = '';
    countList.clear();
    groupByleadSource.forEach((leadSource, list) {
      leadSource_data = leadSource;
      countList = crmLeadList
          .where((element) => element.leadSource
              .toString()
              .contains(leadSource_data.toString()))
          .toList();

      /* var percent = 100 * countList.length / totalLeads!;
      debugPrint('Percentage ${percent.round().toString()}');*/
      double percentage = countList.length.toDouble();
      double dd = ((percentage / totalLeads!) * 100);
      double countlist = double.parse(dd.toStringAsFixed(1));

      /*percent =
          int.tryParse(countlist.toString().split('.')[0].substring(0, 1));
      double cnt;
      if (percent! > 5) {
        percent = countlist.round();
        print('cntt true ${percent}');
      } else {
        print('cntt false ${int.tryParse(countlist.toString().split('.')[1])}');
        // percent = int.parse(countlist.toString());
      }
    */
      LeadBySourceData leadbysourcedata =
          LeadBySourceData(leadSource_data.toString(), countlist);

      String jsonUser = jsonEncode(leadbysourcedata);
      SourceList.add(jsonUser.toString());
    });
    final dynamic jsonResponse = json.decode(SourceList.toString());
    leadbysourcemodel.clear();
    for (Map<String, dynamic> i in jsonResponse) {
      leadbysourcemodel.add(LeadbysourceModel.fromJson(i));
    }
  }

  @override
  void dispose() {
    leadbysourcemodel.clear();
    super.dispose();
  }
}
