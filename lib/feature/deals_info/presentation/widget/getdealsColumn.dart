import 'package:auto_size_text/auto_size_text.dart';
import 'package:crm_dashboard/config/responsive/responsive.dart';
import 'package:crm_dashboard/shared/theme/app_fonts.dart';
import 'package:crm_dashboard/shared/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../shared/util/app_string.dart';

List<GridColumn> getdealsColumns(BuildContext context) {
  return <GridColumn>[
    GridColumn(
      columnName: 'dealsname',
      columnWidthMode: ColumnWidthMode.fill,
      width: !Responsive.isDesktop(context)
          ? 100
          : (Responsive.isDesktop(context) &&
                  Responsive.isTablet(context) &&
                  Responsive.isMobile(context))
              ? 120.0
              : double.nan,
      sortIconPosition: ColumnHeaderIconPosition.end,
      label: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: AutoSizeText(
            AppString.dealsname,
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
        columnName: 'accountname',
        columnWidthMode: !Responsive.isDesktop(context)
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        width: !Responsive.isDesktop(context)
            ? 100
            : (Responsive.isDesktop(context) &&
                    Responsive.isTablet(context) &&
                    Responsive.isMobile(context))
                ? 120.0
                : double.nan,
        label: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: AutoSizeText(
              AppString.accountname,
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
        columnName: 'businessunit',
        columnWidthMode: !Responsive.isDesktop(context)
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        width: !Responsive.isDesktop(context)
            ? 100
            : (Responsive.isDesktop(context) &&
                    Responsive.isTablet(context) &&
                    Responsive.isMobile(context))
                ? 120.0
                : double.nan,
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
        columnName: 'amount',
        columnWidthMode: !Responsive.isDesktop(context)
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        width: !Responsive.isDesktop(context)
            ? 100
            : (Responsive.isDesktop(context) &&
                    Responsive.isTablet(context) &&
                    Responsive.isMobile(context))
                ? 120.0
                : double.nan,
        label: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: AutoSizeText(
              AppString.amount,
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
        columnName: 'dealsowner',
        columnWidthMode: !Responsive.isDesktop(context)
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        width: !Responsive.isDesktop(context)
            ? 100
            : (Responsive.isDesktop(context) &&
                    Responsive.isTablet(context) &&
                    Responsive.isMobile(context))
                ? 120.0
                : double.nan,
        label: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: AutoSizeText(
              AppString.dealsowner,
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
        columnName: 'contactname',
        columnWidthMode: !Responsive.isDesktop(context)
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        width: !Responsive.isDesktop(context)
            ? 100
            : (Responsive.isDesktop(context) &&
                    Responsive.isTablet(context) &&
                    Responsive.isMobile(context))
                ? 120.0
                : double.nan,
        label: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: AutoSizeText(
              AppString.contactname,
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
        columnName: 'closingdate',
        columnWidthMode: !Responsive.isDesktop(context)
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        width: !Responsive.isDesktop(context)
            ? 100
            : (Responsive.isDesktop(context) &&
                    Responsive.isTablet(context) &&
                    Responsive.isMobile(context))
                ? 120.0
                : double.nan,
        label: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: AutoSizeText(
              AppString.closingdate,
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
        columnName: 'dealsstage',
        columnWidthMode: !Responsive.isDesktop(context)
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        width: !Responsive.isDesktop(context)
            ? 100
            : (Responsive.isDesktop(context) &&
                    Responsive.isTablet(context) &&
                    Responsive.isMobile(context))
                ? 120.0
                : double.nan,
        label: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: AutoSizeText(
              AppString.dealsstage,
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
