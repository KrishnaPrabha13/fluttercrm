import 'package:auto_size_text/auto_size_text.dart';
import 'package:crm_dashboard/config/responsive/responsive.dart';
import 'package:crm_dashboard/feature/dashoard/data/model/CrmLeadModel.dart';
import 'package:crm_dashboard/shared/theme/app_fonts.dart';
import 'package:crm_dashboard/shared/theme/colors.dart';
import 'package:crm_dashboard/shared/util/common_util.dart';
import 'package:crm_dashboard/shared/util/image_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';


class LeadDataSource extends DataGridSource {
  LeadDataSource(BuildContext context,
      {required List<CrmLeadModel> crmLeadData}) {
    originalContext = context;
    _leadsData = crmLeadData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'leadowner', value: e.leadOwner),
              DataGridCell<String>(columnName: 'Company', value: e.company),
              DataGridCell<String>(
                  columnName: 'businessunit', value: e.businessUnit),
              DataGridCell<String>(
                  columnName: 'leadbysource', value: e.leadSource),
              DataGridCell<String>(
                  columnName: 'probability', value: e.probability),
              DataGridCell<String>(
                  columnName: 'date&time', value: e.createdTime),
              DataGridCell<String>(columnName: 'country', value: e.country),
              DataGridCell<String>(
                  columnName: 'lookingfor', value: e.lookingFor),
              DataGridCell<String>(
                  columnName: 'probabilityofleadcloser',
                  value: e.probabilityofLeadClosure),
              DataGridCell<String>(
                  columnName: 'leadstatus', value: e.leadStatus),
            ]))
        .toList();
  }

  List<DataGridRow> _leadsData = [];

  @override
  List<DataGridRow> get rows => _leadsData;

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
          child: Row(
            children: [
              getLeadStatusImage(row),
              Expanded(
                child: AutoSizeText(
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  row.getCells()[1].value.toString(),
                  style: TextStyle(
                      color: getTextColor(row.getCells()[0].value.toString()),
                      fontFamily: FontName.montserrat,
                      fontSize:
                          (Responsive.isDesktop(originalContext!)) ? 13 : 11),
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: ((row.getCells()[2].value.toString().trim() == '-') ||
                (row.getCells()[2].value.toString() == ''))
            ? const Text(
                'N/A',
              )
            : Text(row.getCells()[2].value.toString(),
                style: TextStyle(
                    color: srmGulfBlue,
                    fontFamily: FontName.montserrat,
                    fontSize:
                        (Responsive.isDesktop(originalContext!)) ? 12 : 11)),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(row.getCells()[3].value.toString(),
            style: TextStyle(
                color: srmGulfBlue,
                fontFamily: FontName.montserrat,
                fontSize: (Responsive.isDesktop(originalContext!)) ? 12 : 11)),
      ),
      Container(
        alignment: Alignment.center,
        child: Text("${row.getCells()[4].value} %",
            style: TextStyle(
                color: srmGulfBlue,
                fontFamily: FontName.montserrat,
                fontSize: (Responsive.isDesktop(originalContext!)) ? 12 : 11)),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(getCTPDateTime(row.getCells()[5].value.toString())!,
            style: TextStyle(
                color: srmGulfBlue,
                fontFamily: FontName.montserrat,
                fontSize: (Responsive.isDesktop(originalContext!)) ? 12 : 11)),
      ),
      Container(
          alignment: Alignment.center,
          child: Container(
            width: 132,
            height: 32,
            decoration: ShapeDecoration(
              color: getLeadColor(row.getCells()[9].value.toString()),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            child: Center(
              child: Text(
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
                maxLines: 2,
                row.getCells()[9].value.toString(),
                style: TextStyle(
                    color: getTextColor(row.getCells()[9].value.toString()),
                    fontFamily: FontName.montserrat,
                    fontSize:
                        (Responsive.isDesktop(originalContext!)) ? 12 : 11),
              ),
            ),
          )
          //Text(row.getCells()[5].value.toString()),
          ),
    ]);
  }

  Widget getLeadStatusImage(DataGridRow row) {
    return SvgPicture.asset(
      row.getCells()[9].value.toString() == "Contacted"
          ? lead_contacted
          : row.getCells()[9].value.toString() == "Not Contacted"
              ? lead_notcontacted
              : row.getCells()[9].value.toString() == "Pre-Qualified"
                  ? lead_prequalified
                  : row.getCells()[9].value.toString() == "Not Qualified"
                      ? lead_notqualified
                      : row.getCells()[9].value.toString() ==
                              "Attempted to Contact"
                          ? lead_attemptedtocontact
                          : row.getCells()[9].value.toString() == "Lost Lead"
                              ? lead_lostlead
                              : lead_junk,
      height: 30,
      width: 30,
      fit: BoxFit.contain,
    );
  }
}
