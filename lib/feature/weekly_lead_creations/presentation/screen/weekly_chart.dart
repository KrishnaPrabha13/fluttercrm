import 'dart:convert';

import 'package:crm_dashboard/feature/dashoard/data/model/CrmLeadModel.dart';
import 'package:crm_dashboard/feature/weekly_lead_creations/data/model/WeeklyLineBarModel.dart';
import 'package:crm_dashboard/feature/weekly_lead_creations/data/model/weekly_data.dart';
import 'package:crm_dashboard/shared/data_sources/remote/firebase_lead_services.dart';
import 'package:crm_dashboard/shared/util/app_ennum_const_util.dart';
import 'package:crm_dashboard/shared/util/common_util.dart';
import 'package:crm_dashboard/shared/util/globals.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WeeklyChart extends StatefulWidget {
  WeeklyChart({Key? key, required this.getAccess}) : super(key: key);

  String? getAccess;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WeeklyChartState();
  }
}

class WeeklyChartState extends State<WeeklyChart> {
  var dateList = [];

  var dayList = [];
  List<CrmLeadModel> countList1 = [];
  List<int> weekCount = [];
  List<String> WeeklyList = [];
  List<WeeklyLineBarModel> weeklyLineBarModel = [];
  List<CrmLeadModel> crmLeadList = [];
  late int? weeklyLeads;
  List<DateTime> FinalDateList = [];

  late ChartDataLabelPosition _labelPositionX, _labelPositionY;
  late TickPosition _tickPositionX, _tickPositionY;
  late LabelAlignment _labelAlignmentX, _labelAlignmentY;
  final FirebaseLeadServices _firebaseLeadServices = FirebaseLeadServices();
  List<Map<dynamic, dynamic>> lists = [];
  @override
  void initState() {
    _initCheck();
    super.initState();
  }

  void _initCheck() async {
    setState(() {
      // _sharedPrefsService.getAccess().then((value) {
      userAccess = getAccess;
      print('userAccess51 ${userAccess.toString()}');
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CrmLeadModel>>(
      future: _firebaseLeadServices.getTotalLeads(context, '', getAccess!),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<CrmLeadModel>? data = snapshot.data;
          String jsonLead = jsonEncode(data);
          final crmLeadData = json.decode(jsonLead);
          var leadlist = crmLeadData as List<dynamic>;
          crmLeadList = [];
          crmLeadList.clear();
          crmLeadList = leadlist.map((e) => CrmLeadModel.fromJson(e)).toList();
          _getWeeklyLeads();
          return _buildLabelCustomizationSample();
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
    /*StreamBuilder<List<CrmLeadModel>>(
        stream: _firebaseLeadServices.lead_ref.onValue,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            lists.clear();
            Map<dynamic, dynamic> values =
                snapshot.data!.snapshot.value as Map<dynamic, dynamic>;

            values.forEach((key, values) {
              lists.add(values);
            });
            String jsonLead = jsonEncode(lists);
            final crmLeadData = json.decode(jsonLead);
            var leadlist = crmLeadData as List<dynamic>;
            crmLeadList = [];
            crmLeadList.clear();
            crmLeadList =
                leadlist.map((e) => CrmLeadModel.fromJson(e)).toList();
            _getWeeklyLeads();
            return _buildLabelCustomizationSample();
          }
        });*/
  }

  void _getWeeklyLeads() {
    DateTime now = DateTime.now();

    int currentDay = now.weekday;

    DateTime firstDayOfWeek = now.subtract(Duration(days: currentDay - 1));
    String sdate = DateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(firstDayOfWeek);
    DateTime today = DateTime.now();

    String cdate = DateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(today);
    DateTime CurrentDate = DateTime.parse(cdate);
    DateTime StartDate = DateTime.parse(sdate);

    FinalDateList = getDaysInBetween(StartDate, CurrentDate);
    dateList.clear();
    FinalDateList.forEach((day) {
      String DateList = DateFormat('MMM d, yyyy').format(day);
      dateList.add(DateList);
    });
    WeeklyList.clear();
    //print('dateList ${dateList.toString()}');
    List dayNamee = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    for (int i = 0; i < dateList.length; i++) {
      countList1 = crmLeadList
          .where((element) => getCTPDateTime(element.createdTime.toString())!
              .contains(dateList[i]))
          .toList();

      final dateName = DateFormat('EEEE')
          .format(DateFormat("MMM d, yyyy").parse(dateList[i]));

      WeeklyData weeklyData =
          WeeklyData(dateName.toString().substring(0, 3), countList1.length);

      String jsonUser = jsonEncode(weeklyData);
      WeeklyList.add(jsonUser.toString());
    }
    final dynamic jsonResponse = json.decode(WeeklyList.toString());
    weeklyLineBarModel.clear();
    for (Map<String, dynamic> i in jsonResponse) {
      weeklyLineBarModel.add(WeeklyLineBarModel.fromJson(i));
    }
  }

  /// Returen the Spline series with axis label position changing.
  SfCartesianChart _buildLabelCustomizationSample() {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          interval: 1,
          labelPosition:
              isCardView ? ChartDataLabelPosition.outside : _labelPositionX,
          labelAlignment: isCardView ? LabelAlignment.center : _labelAlignmentX,
          tickPosition: isCardView ? TickPosition.outside : _tickPositionX,
          majorGridLines: const MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
        edgeLabelPlacement:
            isCardView ? EdgeLabelPlacement.none : EdgeLabelPlacement.shift,
        labelPosition:
            isCardView ? ChartDataLabelPosition.outside : _labelPositionY,
        labelAlignment: isCardView ? LabelAlignment.center : _labelAlignmentY,
        tickPosition: isCardView ? TickPosition.outside : _tickPositionY,
        opposedPosition: false,
        minimum: 0,
        maximum: 10,
        interval: 2,
        labelFormat: '{value}',
      ),
      series: _getSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  /// Return the spline series.
  List<ChartSeries<WeeklyLineBarModel, String>> _getSeries() {
    return <ChartSeries<WeeklyLineBarModel, String>>[
      SplineSeries<WeeklyLineBarModel, String>(
          dataSource: weeklyLineBarModel,
          xValueMapper: (WeeklyLineBarModel days, _) => days.dayName as String,
          yValueMapper: (WeeklyLineBarModel days, _) => days.count,
          markerSettings: const MarkerSettings(isVisible: true),
          name: 'Weekly Lead Creation')
    ];
  }

  @override
  void dispose() {
    weeklyLineBarModel!.clear();
    super.dispose();
  }
}
