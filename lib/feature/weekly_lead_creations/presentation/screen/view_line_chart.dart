import 'package:crm_dashboard/shared/theme/colors.dart';
import 'package:crm_dashboard/shared/util/app_ennum_const_util.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ViewLineChart extends StatefulWidget {
  const ViewLineChart({Key? key}) : super(key: key);

  @override
  _ViewLineChartState createState() => _ViewLineChartState();
}

class _ViewLineChartState extends State<ViewLineChart> {
  List<Color> gradientColors = [
    primaryColor,
    secondaryColor,
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        defaultPadding,
        defaultPadding * 1.5,
        defaultPadding,
        defaultPadding,
      ),
      child: LineChart(LineChartData(
          gridData: FlGridData(
            show: false,
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: SideTitles(
                showTitles: true,
                reservedSize: 22,
                getTextStyles: (value) => const TextStyle(
                      color: black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                getTitles: (value) {
                  switch (value.toInt()) {
                    case 1:
                      return 'Mon';
                    case 4:
                      return 'Tue';
                    case 7:
                      return 'Wed';
                    case 10:
                      return 'Thr';
                    case 13:
                      return 'Fri';
                    case 16:
                      return 'Sat';
                    case 19:
                      return 'Sun';
                  }
                  return '';
                }),
          ),
          borderData: FlBorderData(
            show: false,
          ),
          minX: 0,
          maxX: 20,
          maxY: 0,
          minY: 6,
          lineBarsData: [
            LineChartBarData(
                spots: [
                  FlSpot(0, 3),
                  FlSpot(4, 6),
                  FlSpot(9, 4),
                  FlSpot(12, 3),
                  FlSpot(15, 5),
                  FlSpot(18, 3),
                  FlSpot(20, 4),
                ],
                isCurved: true,
                colors: [primaryColor],
                barWidth: 5,
                isStrokeCapRound: true,
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(
                    show: true,
                    colors:
                        gradientColors.map((e) => e.withOpacity(0.3)).toList(),
                    gradientFrom: const Offset(0, 0),
                    gradientTo: const Offset(0, 1.75)))
          ])),
    );
  }
}
