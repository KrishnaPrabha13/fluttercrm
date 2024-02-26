import 'dart:async';

import 'package:crm_dashboard/config/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CircularProgressBar extends StatefulWidget {

  CircularProgressBar({Key? key, required this.percentage}) : super(key: key);
  int ? percentage;
  @override
  State<CircularProgressBar> createState() => _CircularProgressBarState();
}

class _CircularProgressBarState extends State<CircularProgressBar> {
  double progressValue = 0;

  late Timer _timer;
  @override
  void initState() {
    super.initState();
    if (mounted) {
      _timer = Timer.periodic(const Duration(milliseconds: 30), (Timer timer) {
        setState(() {
          progressValue++;
          if (progressValue == widget.percentage) {
            _timer.cancel();
          }
        });
      });
    }
  }
  @override
  Widget build(BuildContext context) {

    return SizedBox(
        height:Responsive.isDesktop(context) ? 70 : 60,
        width: Responsive.isDesktop(context) ? 70 : 60,
        child: SfRadialGauge(axes: <RadialAxis>[
          RadialAxis(
              showLabels: false,
              showTicks: false,
              startAngle: 270,
              endAngle: 270,
              radiusFactor: 0.8,
              axisLineStyle: const AxisLineStyle(
                thickness: 0.1,
                color: Color.fromARGB(30, 0, 169, 181),
                thicknessUnit: GaugeSizeUnit.factor,
                cornerStyle: CornerStyle.startCurve,
              ),
              pointers: <GaugePointer>[
                RangePointer(
                    value: progressValue,
                    width: 0.1,
                    sizeUnit: GaugeSizeUnit.factor,
                    enableAnimation: true,
                    animationDuration: 30,
                    animationType: AnimationType.linear,
                    cornerStyle: CornerStyle.startCurve,
                    gradient: const SweepGradient(
                        colors: <Color>[Color(0xFF00a9b5), Color(0xFFa4edeb)],
                        stops: <double>[0.25, 0.75])),
                MarkerPointer(
                  value: progressValue,
                  markerType: MarkerType.image,
                  imageUrl: 'images/uparrow.png',
                  markerWidth: Responsive.isDesktop(context) ? 15 : 15,
                  markerHeight: Responsive.isDesktop(context) ? 15 : 15,
                  enableAnimation: true,
                  animationDuration: 30,
                  animationType: AnimationType.linear,
                  color: const Color(0xFF87e8e8),
                )
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                    positionFactor: 0.1,
                    widget: Text(progressValue.toStringAsFixed(0) + '%'))
              ]),
        ]));
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
