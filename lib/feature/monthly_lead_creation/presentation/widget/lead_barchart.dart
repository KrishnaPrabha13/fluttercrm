import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:crm_dashboard/config/responsive/responsive.dart';
import 'package:crm_dashboard/feature/dashoard/data/model/CrmLeadModel.dart';
import 'package:crm_dashboard/feature/monthly_lead_creation/data/model/lead_bar_chart_model.dart';
import 'package:crm_dashboard/feature/monthly_lead_creation/data/model/yearly_data.dart';
import 'package:crm_dashboard/shared/data_sources/remote/firebase_lead_services.dart';
import 'package:crm_dashboard/shared/theme/app_fonts.dart';
import 'package:crm_dashboard/shared/theme/colors.dart';
import 'package:crm_dashboard/shared/util/app_ennum_const_util.dart';
import 'package:crm_dashboard/shared/util/common_util.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LeadBarchart extends StatefulWidget {
  LeadBarchart({Key? key, required this.getAccess}) : super(key: key);
  List<CrmLeadModel> crmLeadlist = [];
  String? getAccess;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LeadBarchartState();
  }
}

class LeadBarchartState extends State<LeadBarchart> {
  TooltipBehavior? _tooltipBehavior;
  String? dataTimems;
  List<CrmLeadModel> countList = [];
  List<CrmLeadModel> yearList = [];
  List<String> MonthlyList = [];
  List<LeadBarchartModel> learbarchartModel = [];
  List<CrmLeadModel> crmLeadList = [];
  final FirebaseLeadServices _firebaseLeadServices = FirebaseLeadServices();
  List<Map<dynamic, dynamic>> lists = [];
  @override
  void initState() {
    super.initState();
    _initCheck();
    _tooltipBehavior =
        TooltipBehavior(enable: true, header: '', canShowMarker: false);
  }

  void _initCheck() async {
    setState(() {
      // _sharedPrefsService.getAccess().then((value) {
      userAccess = getAccess;
      // print('userAccess53 ${userAccess.toString()}');
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CrmLeadModel>?>(
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
          crmLeadList.sort((a, b) {
            return a.createdTime!.compareTo(b.createdTime!);
          });
          _getLeadMonthlydata();
          return _buildDefaultCategoryAxisChart();
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  /// Returns the column chart with default category x-axis.
  SfCartesianChart _buildDefaultCategoryAxisChart() {
    return SfCartesianChart(
      borderWidth: 0,
      plotAreaBorderWidth: Responsive.isDesktop(context) ? 1 : 0.5,

      /// X axis as category axis placed here.
      primaryXAxis: CategoryAxis(
        labelStyle: const TextStyle(
          color: black,
        ),
        majorGridLines:
            MajorGridLines(width: Responsive.isDesktop(context) ? 2 : 1),
      ),
      primaryYAxis: NumericAxis(
          labelStyle:
              const TextStyle(color: black, fontFamily: FontName.montserrat),
          labelFormat: '{value}',
          minimum: 0,
          maximum: 30,
          isVisible: true,
          plotBands: [
            PlotBand(
                isVisible: true,
                // provided the same y-value to start and end property in order to render the plotline for that y-value.
                start: 15,
                end: 15,
                borderWidth: Responsive.isDesktop(context) ? 1 : 0.7,
                borderColor: lightTextColor,
                // provided dash array to render the line in dashed format.
                dashArray: Responsive.isDesktop(context)
                    ? <double>[7, 5]
                    : <double>[9, 7])
          ],
          majorGridLines:
              MajorGridLines(width: Responsive.isDesktop(context) ? 1 : 0.5),
          minorGridLines:
              MinorGridLines(width: Responsive.isDesktop(context) ? 10 : 5)),
      series: _getBarChart(),
      enableAxisAnimation: false,
      tooltipBehavior: _tooltipBehavior,
    );
  }

  /// Returns the list of chart series which need to render on the column chart.
  List<ColumnSeries<LeadBarchartModel, String>> _getBarChart() {
    return <ColumnSeries<LeadBarchartModel, String>>[
      ColumnSeries<LeadBarchartModel, String>(
          // Binding the chartData to the dataSource of the column series.
          dataSource: learbarchartModel,
          xValueMapper: (LeadBarchartModel year, _) => year.months,
          yValueMapper: (LeadBarchartModel year, _) => year.count,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          pointColorMapper: (LeadBarchartModel year, _) =>
              _getBarColor(year.months, year.count),
          borderRadius: BorderRadius.circular(2),
          // Width of the bars
          width: Responsive.isDesktop(context) ? 0.5 : 0.4,
          // Spacing between the bars
          spacing: 0.2),
    ];
  }

  Color? _getBarColor(String? month, int? count) {
    Color? _color;
    switch (month) {
      case 'Jan':
        if (count != null) {
          if (count == (1 <= 6)) {
            _color = srmBlueGreen;
          } else if (count == (7 < 15)) {
            _color = srmBlueGreen.withOpacity(0.7);
          } else {
            _color = srmBlueGreen;
          }
        }
        break;
      case 'Feb':
        if (count != null) {
          if (count == (1 <= 6)) {
            _color = srmBlueGreen;
          } else if (count == (7 < 15)) {
            _color = srmBlueGreen.withOpacity(0.7);
          } else {
            _color = srmBlueGreen;
          }
        }
        break;
      case 'Mar':
        if (count != null) {
          if (count > 15) {
            _color = srmBlueGreen;
          } else if (count == (7 < 15)) {
            _color = srmBlueGreen.withOpacity(0.7);
          } else {
            _color = srmBlueGreen.withOpacity(0.3);
          }
        }
        break;
      case 'Apr':
        if (count != null) {
          if (count > 15) {
            _color = srmBlueGreen;
          } else if (count == (15 >= 6)) {
            _color = srmBlueGreen.withOpacity(0.8);
          } else {
            _color = srmBlueGreen.withOpacity(0.3);
          }
        }
        break;
      case 'May':
        if (count != null) {
          if (count > 15) {
            _color = srmBlueGreen;
          } else if (count == (7 < 15)) {
            _color = srmBlueGreen.withOpacity(0.7);
          } else {
            _color = srmBlueGreen.withOpacity(0.3);
          }
        }
        break;
      case 'Jun':
        if (count != null) {
          if (count > 15) {
            _color = srmBlueGreen;
          } else if (count == (7 < 15)) {
            _color = srmBlueGreen.withOpacity(0.7);
          } else {
            _color = srmBlueGreen.withOpacity(0.3);
          }
        }
        break;
      case 'Jul':
        if (count != null) {
          if (count > 15) {
            _color = srmBlueGreen;
          } else if (count == (7 < 15)) {
            _color = srmBlueGreen.withOpacity(0.7);
          } else {
            _color = srmBlueGreen.withOpacity(0.3);
          }
        }
        break;
      case 'Aug':
        if (count != null) {
          if (count > 15) {
            _color = srmBlueGreen;
          } else if (count == (7 < 15)) {
            _color = srmBlueGreen.withOpacity(0.7);
          } else {
            _color = srmBlueGreen.withOpacity(0.3);
          }
        }
        break;
      case 'Sep':
        if (count != null) {
          if (count > 15) {
            _color = srmBlueGreen;
          } else if (count == (7 < 15)) {
            _color = srmBlueGreen.withOpacity(0.7);
          } else {
            _color = srmBlueGreen.withOpacity(0.3);
          }
        }
        break;
      case 'Oct':
        if (count != null) {
          if (count > 15) {
            _color = srmBlueGreen;
          } else if (count == (7 < 15)) {
            _color = srmBlueGreen.withOpacity(0.7);
          } else {
            _color = srmBlueGreen.withOpacity(0.3);
          }
        }
        break;
      case 'Nov':
        if (count != null) {
          if (count > 15) {
            _color = srmBlueGreen;
          } else if (count == (7 < 15)) {
            _color = srmBlueGreen.withOpacity(0.7);
          } else {
            _color = srmBlueGreen.withOpacity(0.3);
          }
        }
        break;
      default:
        if (count != null) {
          if (count > 15) {
            _color = srmBlueGreen;
          } else if (count == (7 < 15)) {
            _color = srmBlueGreen.withOpacity(0.7);
          } else {
            _color = srmBlueGreen.withOpacity(0.3);
          }
        }
        break;
    }
    return _color;
  }

  void _getLeadMonthlydata() {
    /*var groupBydate1 = groupBy(
        crmLeadList, (obj) => getCTPDateTime(obj.createdTime.toString())!);

    groupBydate1.forEach((date, list) {
      print('jsonResponseChart1 yearList ${date}');
    });*/
    var groupBydate = groupBy(
        crmLeadList,
        (obj) =>
            getCTPDateTime(obj.createdTime.toString())!.substring(0, 3).trim());
    MonthlyList.clear();
    groupBydate.forEach((date, list) {
      dataTimems = date;
      // print('jsonResponseChart dataTimems ${dataTimems}');
      countList = crmLeadList
          .where((element) => getCTPDateTime(element.createdTime.toString())!
              .contains(date.toString()))
          .toList();
      var yearList = crmLeadList
          .where((element) => getCTPDateTime(element.createdTime.toString())!
              .contains(date.toString()))
          .toList();
      // print('jsonResponseChart yearList ${yearList}');
      YearlyData yearlydata = YearlyData(
          dataTimems.toString(), countList.length, yearList.toString());

      String jsonUser = jsonEncode(yearlydata);

      MonthlyList.add(jsonUser.toString());

      // print('jsonResponseChart MonthlyList $MonthlyList');
      //}
    });

    final dynamic jsonResponse = json.decode(MonthlyList.toString());
    //print('jsonResponseChart $jsonResponse');
    learbarchartModel.clear();
    for (Map<String, dynamic> i in jsonResponse) {
      learbarchartModel.add(LeadBarchartModel.fromJson(i));
    }
  }

  @override
  void dispose() {
    learbarchartModel.clear();
    super.dispose();
  }
}
