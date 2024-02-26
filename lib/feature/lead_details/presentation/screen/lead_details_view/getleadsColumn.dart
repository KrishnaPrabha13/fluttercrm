import 'package:auto_size_text/auto_size_text.dart';
import 'package:crm_dashboard/config/responsive/responsive.dart';
import 'package:crm_dashboard/shared/theme/app_fonts.dart';
import 'package:crm_dashboard/shared/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../shared/util/app_string.dart';

List<GridColumn> getleadsColumns(BuildContext context) {
  return <GridColumn>[
    GridColumn(
      columnName: 'company',
      columnWidthMode: ColumnWidthMode.fill,
      width: Responsive.isDesktop(context)
          ? 240
          : Responsive.isTablet(context)
              ? 220
              : 220,
      sortIconPosition: ColumnHeaderIconPosition.end,
      label: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: AutoSizeText(
            AppString.company,
            overflow: TextOverflow.ellipsis,
            minFontSize: 10,
            stepGranularity: 10,
            maxLines: 4,
            style: TextStyle(
              color: black,
              fontFamily: FontName.montserrat,
              fontSize: (Responsive.isDesktop(context)) ? 13 : 11,
              fontWeight: FontWeight.w700,
            ),
          )),
    ),
    GridColumn(
        columnName: 'businessunit',
        columnWidthMode: !Responsive.isDesktop(context)
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        width: Responsive.isDesktop(context)
            ? 240
            : Responsive.isTablet(context)
                ? 220
                : 170,
        label: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: AutoSizeText(
              AppString.businessunit,
              overflow: TextOverflow.ellipsis,
              minFontSize: 10,
              stepGranularity: 10,
              maxLines: 2,
              style: TextStyle(
                color: black,
                fontFamily: FontName.montserrat,
                fontSize: (Responsive.isDesktop(context)) ? 13 : 11,
                fontWeight: FontWeight.w700,
              ),
            ))),
    GridColumn(
        columnName: 'leadbysource',
        columnWidthMode: !Responsive.isDesktop(context)
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        width: Responsive.isDesktop(context)
            ? double.nan
            : Responsive.isTablet(context)
                ? 220
                : 170,
        label: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: AutoSizeText(
              AppString.leadbysource,
              overflow: TextOverflow.ellipsis,
              minFontSize: 10,
              stepGranularity: 10,
              maxLines: 2,
              style: TextStyle(
                color: black,
                fontFamily: FontName.montserrat,
                fontSize: (Responsive.isDesktop(context)) ? 13 : 11,
                fontWeight: FontWeight.w700,
              ),
            ))),
    GridColumn(
        columnName: 'probability',
        columnWidthMode: !Responsive.isDesktop(context)
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        width: Responsive.isDesktop(context)
            ? double.nan
            : Responsive.isTablet(context)
                ? 220
                : 140,
        label: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: AutoSizeText(
              AppString.probability,
              overflow: TextOverflow.ellipsis,
              minFontSize: 10,
              stepGranularity: 10,
              maxLines: 2,
              style: TextStyle(
                color: black,
                fontFamily: FontName.montserrat,
                fontSize: (Responsive.isDesktop(context)) ? 13 : 11,
                fontWeight: FontWeight.w700,
              ),
            ))),
    GridColumn(
        columnName: 'date&time',
        columnWidthMode: !Responsive.isDesktop(context)
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        width: Responsive.isDesktop(context)
            ? double.nan
            : Responsive.isTablet(context)
                ? 220
                : 170,
        label: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: AutoSizeText(
              AppString.datetime,
              overflow: TextOverflow.ellipsis,
              minFontSize: 10,
              stepGranularity: 10,
              maxLines: 2,
              style: TextStyle(
                color: black,
                fontFamily: FontName.montserrat,
                fontSize: (Responsive.isDesktop(context)) ? 13 : 11,
                fontWeight: FontWeight.w700,
              ),
            ))),
    GridColumn(
        columnName: 'leadstatus',
        columnWidthMode: !Responsive.isDesktop(context)
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        width: Responsive.isDesktop(context)
            ? double.nan
            : Responsive.isTablet(context)
                ? 220
                : double.nan,
        label: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: AutoSizeText(
              AppString.leadstatus,
              overflow: TextOverflow.ellipsis,
              minFontSize: 10,
              stepGranularity: 10,
              maxLines: 2,
              style: TextStyle(
                color: black,
                fontFamily: FontName.montserrat,
                fontSize: (Responsive.isDesktop(context)) ? 13 : 11,
                fontWeight: FontWeight.w700,
              ),
            ))),
  ];
}
