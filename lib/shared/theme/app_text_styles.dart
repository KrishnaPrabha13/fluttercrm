import 'package:crm_dashboard/shared/theme/app_fonts.dart';
import 'package:crm_dashboard/shared/theme/app_fontsize.dart';
import 'package:crm_dashboard/shared/theme/colors.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle titleStyle = const TextStyle(
    fontSize: FONT_14,
    color: black,
    fontFamily: FontName.montserrat,
  );
  static TextStyle titleStyleTablet = const TextStyle(
    fontSize: FONT_13,
    color: black,
    fontFamily: FontName.montserrat,
  );
  static TextStyle titleStyleMobile = const TextStyle(
    fontSize: FONT_12,
    color: black,
    fontFamily: FontName.montserrat,
  );
  static TextStyle subtitleStyle = const TextStyle(
      fontSize: FONT_14, color: black, fontFamily: FontName.montserrat);
  static TextStyle subtitlesrmCadiumOrangeColorStyle = const TextStyle(
      fontSize: FONT_13,
      color: srmCadiumOrange,
      fontFamily: FontName.montserrat);
  static TextStyle subtitleStyleTablet = const TextStyle(
      fontSize: FONT_13, color: black, fontFamily: FontName.montserrat);
  static TextStyle subtitleStyleMobile = const TextStyle(
      fontSize: FONT_12, color: black, fontFamily: FontName.montserrat);

  static TextStyle subtitleStylesrmDoveGrey = const TextStyle(
      fontSize: FONT_12, color: srmDoveGrey, fontFamily: FontName.montserrat);
  static TextStyle subtitleStylesrmDoveGreyTablet = const TextStyle(
      fontSize: FONT_11, color: srmDoveGrey, fontFamily: FontName.montserrat);
  static TextStyle subtitleStylesrmDoveGreyMobile = const TextStyle(
      fontSize: FONT_10, color: srmDoveGrey, fontFamily: FontName.montserrat);
  static TextStyle subtitleTableStyle = const TextStyle(
      fontSize: FONT_11, color: black, fontFamily: FontName.montserrat);
  static TextStyle subtitleTableStyleTablet = const TextStyle(
      fontSize: FONT_10, color: black, fontFamily: FontName.montserrat);
  static TextStyle subtitleTableStyleMobile = const TextStyle(
      fontSize: FONT_10, color: black, fontFamily: FontName.montserrat);
  static TextStyle subtitleWhiteStyle = const TextStyle(
      fontSize: FONT_13,
      color: AppColors.white,
      fontFamily: FontName.montserrat);
  static TextStyle subtitleWhiteStyleTablet = const TextStyle(
      fontSize: FONT_11,
      color: AppColors.white,
      fontFamily: FontName.montserrat);
  static TextStyle subtitleWhiteStyleMobile = const TextStyle(
      fontSize: FONT_10,
      color: AppColors.white,
      fontFamily: FontName.montserrat);
  static TextStyle titleStyle_w200 = const TextStyle(
      fontSize: FONT_14,
      color: black,
      fontWeight: FontWeight.w200,
      fontFamily: FontName.montserrat);
  static TextStyle subtitleStyle_w200 = const TextStyle(
      fontSize: FONT_14,
      color: black,
      fontWeight: FontWeight.w200,
      fontFamily: FontName.montserrat);
  static TextStyle srmDoveGreyStyle_w200 = const TextStyle(
      fontSize: FONT_14,
      color: srmDoveGrey,
      fontWeight: FontWeight.w200,
      fontFamily: FontName.montserrat);
  static TextStyle titleStyle_w300 = const TextStyle(
      fontSize: FONT_16,
      color: black,
      fontWeight: FontWeight.w300,
      fontFamily: FontName.montserrat);
  static TextStyle subtitleStyle_w300 = const TextStyle(
      fontSize: FONT_14,
      color: black,
      fontWeight: FontWeight.w300,
      fontFamily: FontName.montserrat);
}
