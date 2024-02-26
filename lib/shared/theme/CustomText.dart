import 'package:flutter/material.dart';
import 'package:crm_dashboard/shared/theme/colors.dart';

class CustomText extends StatelessWidget {
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final String text;
  final double height;
  TextOverflow? overflow;

  CustomText({
    required this.text,
    required this.fontWeight,
    required this.color ,
    required this.fontSize,
    this.height = 1.3,
    this.overflow
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
      style: TextStyle(
        color: color,
        height: height,
        fontFamily: 'Roboto',
        fontSize: fontSize,
        fontWeight: fontWeight,
        overflow: overflow
      ),);
  }
}
