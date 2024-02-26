import 'package:auto_size_text/auto_size_text.dart';
import 'package:crm_dashboard/config/responsive/responsive.dart';
import 'package:crm_dashboard/feature/deals_info/data/model/DealsDataModel.dart';
import 'package:crm_dashboard/shared/theme/app_fonts.dart';
import 'package:crm_dashboard/shared/theme/colors.dart';
import 'package:crm_dashboard/shared/util/common_util.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DealsDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  DealsDataSource(BuildContext context,
      {required List<DealsDataModel> crmDealData}) {
    print('employeeData $crmDealData');
    originalContext = context;
    _dealsData = crmDealData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'dealsname', value: e.dealsName),
              DataGridCell<String>(
                  columnName: 'accountname', value: e.accountName),
              DataGridCell<String>(
                  columnName: 'businessunit', value: e.businessUnit),
              DataGridCell<int>(columnName: 'Amount', value: e.amount),
              DataGridCell<String>(
                  columnName: 'dealsowner', value: e.dealsOwner),
              DataGridCell<String>(
                  columnName: 'contactname', value: e.contactName),
              DataGridCell<String>(
                  columnName: 'closingdate',
                  value: getCTPDateTime(e.closingDate)),
              DataGridCell<String>(
                  columnName: 'dealsstage', value: e.dealsStage),
            ]))
        .toList();
  }

  List<DataGridRow> _dealsData = [];

  @override
  List<DataGridRow> get rows => _dealsData;

  BuildContext? originalContext;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: <Widget>[
      Container(
        width: (Responsive.isMobile(originalContext!)) ? 137 : null,
        height: 32,
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 10, right: 0),
        child: Center(
          child: AutoSizeText(
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            maxLines: 2,
            row.getCells()[0].value.toString(),
            style: TextStyle(
                color: black,
                fontFamily: FontName.montserrat,
                fontSize: (Responsive.isDesktop(originalContext!)) ? 13 : 11),
          ),
        ),
      ),
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: AutoSizeText(
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            maxLines: 2,
            row.getCells()[1].value.toString(),
            style: TextStyle(
                color: black,
                fontFamily: FontName.montserrat,
                fontSize: (Responsive.isDesktop(originalContext!)) ? 13 : 11),
          ),
        ),
      ),
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: AutoSizeText(
          row.getCells()[2].value.toString(),
          overflow: TextOverflow.ellipsis,
          minFontSize: 9.8,
          stepGranularity: 9.8,
          maxLines: 4,
          style: TextStyle(
              color: Colors.black,
              fontFamily: FontName.montserrat,
              fontSize: (Responsive.isDesktop(originalContext!)) ? 12 : 11),
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: AutoSizeText(
          row.getCells()[3].value.toString(),
          overflow: TextOverflow.ellipsis,
          minFontSize: 9.8,
          stepGranularity: 9.8,
          maxLines: 4,
          style: TextStyle(
              color: Colors.black,
              fontFamily: FontName.montserrat,
              fontSize: (Responsive.isDesktop(originalContext!)) ? 12 : 11),
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: AutoSizeText(
          row.getCells()[4].value.toString(),
          overflow: TextOverflow.ellipsis,
          minFontSize: 9.8,
          stepGranularity: 9.8,
          maxLines: 4,
          style: TextStyle(
              color: Colors.black,
              fontFamily: FontName.montserrat,
              fontSize: (Responsive.isDesktop(originalContext!)) ? 12 : 11),
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: AutoSizeText(
          row.getCells()[5].value.toString(),
          overflow: TextOverflow.ellipsis,
          minFontSize: 9.8,
          stepGranularity: 9.8,
          maxLines: 4,
          style: TextStyle(
              color: Colors.black,
              fontFamily: FontName.montserrat,
              fontSize: (Responsive.isDesktop(originalContext!)) ? 12 : 11),
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: Center(
          child: AutoSizeText(
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            maxLines: 2,
            row.getCells()[6].value.toString(),
            style: TextStyle(
                color: black,
                fontFamily: FontName.montserrat,
                fontSize: (Responsive.isDesktop(originalContext!)) ? 13 : 11),
          ),
        ),
      ),
      Container(
          alignment: Alignment.center,
          child: Container(
            width: 132,
            height: 32,
            decoration: ShapeDecoration(
              color: getDealsColor(row.getCells()[7].value.toString()),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            child: Center(
              child: AutoSizeText(
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
                maxLines: 2,
                row.getCells()[7].value.toString(),
                style: TextStyle(
                    color:
                        getDealsTextColor(row.getCells()[7].value.toString()),
                    fontFamily: FontName.montserrat,
                    fontSize:
                        (Responsive.isDesktop(originalContext!)) ? 13 : 11),
              ),
            ),
          )
          //Text(row.getCells()[5].value.toString()),
          ),
    ]);
  }
}
