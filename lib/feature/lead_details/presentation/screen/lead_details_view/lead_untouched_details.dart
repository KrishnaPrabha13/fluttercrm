import 'package:auto_size_text/auto_size_text.dart';
import 'package:crm_dashboard/config/responsive/responsive.dart';
import 'package:crm_dashboard/feature/dashoard/data/model/CrmLeadModel.dart';
import 'package:crm_dashboard/feature/lead_details/domain/repositiries/LeadlDataSource.dart';
import 'package:crm_dashboard/shared/data_sources/remote/firebase_lead_services.dart';
import 'package:crm_dashboard/shared/theme/app_fonts.dart';
import 'package:crm_dashboard/shared/theme/colors.dart';
import 'package:crm_dashboard/shared/util/app_ennum_const_util.dart';
import 'package:crm_dashboard/shared/util/app_string.dart';
import 'package:crm_dashboard/shared/util/common_util.dart';
import 'package:crm_dashboard/shared/util/image_util.dart';
import 'package:flutter/material.dart';

/// Core import
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../shared/common_widgets/common_widgets.dart';
import 'getleadsColumn.dart';

class LeadUntouchedDetails extends StatefulWidget {
  final String searchQuery;
  String? getAccess;

  LeadUntouchedDetails(
      {Key? key, required this.searchQuery, required this.getAccess})
      : super(key: key);
  @override
  State<LeadUntouchedDetails> createState() => LeadUntouchedDetailsState();
}

class LeadUntouchedDetailsState extends State<LeadUntouchedDetails> {
  final FirebaseLeadServices _firebaseLeadServices = FirebaseLeadServices();
  List<GridColumn>? columns;
  LeadDataSource? leadDataSource;
  @override
  void initState() {
    leadTabIndex = 4;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    columns = getleadsColumns(context);
    leadDataSource?.sortedColumns.add(const SortColumnDetails(
        name: 'name', sortDirection: DataGridSortDirection.ascending));
    leadDataSource?.sort();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FutureBuilder<List<CrmLeadModel>>(
        future: _firebaseLeadServices.getUntouchedLeads(
            context, widget.searchQuery, getAccess),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<CrmLeadModel>? data = snapshot.data;
            if (data!.isEmpty) {
              return Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: getNodatafoundImage(
                          context, nodatafound, srmDoveGrey),
                    ),
                    Text(
                      AppString.noDatasFound,
                      style: TextStyle(
                          color: srmDoveGrey,
                          fontFamily: FontName.montserrat,
                          fontSize: (Responsive.isDesktop(context)) ? 16 : 11),
                    ),
                  ],
                ),
              );
            }
            //return getListView(data);
            leadDataSource =
                LeadDataSource(context, crmLeadData: data.toList());
            return SfDataGridTheme(
              data: SfDataGridThemeData(
                  headerColor: AppColors.gOffWhite,
                  headerHoverColor: AppColors.secondary,
                  //sortIconColor: black,
                  rowHoverColor: AppColors.secondaryBg,
                  columnResizeIndicatorColor: Colors.black),
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Container(
                  decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 1, color: Color(0xFFE0E0E0)),
                        borderRadius: BorderRadius.circular(10),
                      )),
                  child: SfDataGrid(
                    source: leadDataSource!,
                    columns: columns!,
                    allowSorting: true,
                    allowMultiColumnSorting: false,
                    allowTriStateSorting: false,
                    showSortNumbers: false,
                    // gridLinesVisibility: GridLinesVisibility.both,
                    //headerGridLinesVisibility: GridLinesVisibility.both,
                    columnWidthMode: Responsive.isDesktop(context) ||
                            Responsive.isMobile(context) ||
                            Responsive.isTablet(context)
                        ? ColumnWidthMode.fill
                        : ColumnWidthMode.none,
                    onCellTap: ((details) {
                      if (details.rowColumnIndex.rowIndex != 0) {
                        int selectedRowIndex =
                            details.rowColumnIndex.rowIndex - 1;
                        var row = leadDataSource!.effectiveRows
                            .elementAt(selectedRowIndex);
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32.0)),
                                  ),
                                  content: SizedBox(
                                    height: 140,
                                    width: (Responsive.isDesktop(context))
                                        ? 1000
                                        : 400,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top:10),
                                          child: Table(
                                            border: TableBorder.all(),
                                            children: [
                                              buildRow([
                                                '${AppString.leadOwner}',
                                                '${AppString.company}',
                                                '${AppString.businessunit}',
                                                '${AppString.leadbysource}',
                                                '${AppString.probability}',
                                                '${AppString.datetime}',
                                                '${AppString.country}',
                                                '${AppString.leadlookingfor}',
                                                '${AppString.probabilityleadcloser}',
                                                '${AppString.leadstatus}',
                                              ], isHeader:true
                                              ),
                                              buildRow([
                                                '${row.getCells()[0].value.toString()}',
                                                '${row.getCells()[1].value.toString()}',
                                                '${row.getCells()[2].value.toString()}',
                                                '${row.getCells()[3].value.toString()}',
                                                '${"${row.getCells()[4].value}%"}',
                                                '${getCTPDateTime(row.getCells()[5].value.toString())!}',
                                                '${row.getCells()[6].value.toString()}',
                                                '${row.getCells()[7].value.toString()}',
                                                '${row.getCells()[8].value.toString()}',
                                                '${row.getCells()[9].value.toString()}',



                                              ])
                                            ],
                                          ),
                                        ),
                                        // Text(
                                        //   AppString.leadOwner +
                                        //       '  : ${row.getCells()[0].value.toString()}',
                                        //   style: TextStyle(
                                        //       color: black,
                                        //       fontFamily: FontName.montserrat,
                                        //       fontSize: (Responsive.isDesktop(
                                        //               context))
                                        //           ? 15
                                        //           : 13),
                                        // ),
                                        // Text(
                                        //   AppString.company +
                                        //       '  : ${row.getCells()[1].value.toString()}',
                                        //   style: TextStyle(
                                        //       color: black,
                                        //       fontFamily: FontName.montserrat,
                                        //       fontSize: (Responsive.isDesktop(
                                        //               context))
                                        //           ? 15
                                        //           : 13),
                                        // ),
                                        // Text(
                                        //   AppString.businessunit +
                                        //       '  : ${row.getCells()[2].value.toString()}',
                                        //   style: TextStyle(
                                        //       color: black,
                                        //       fontFamily: FontName.montserrat,
                                        //       fontSize: (Responsive.isDesktop(
                                        //               context))
                                        //           ? 15
                                        //           : 13),
                                        // ),
                                        // Text(
                                        //   AppString.leadbysource +
                                        //       '  : ${row.getCells()[3].value.toString()}',
                                        //   style: TextStyle(
                                        //       color: black,
                                        //       fontFamily: FontName.montserrat,
                                        //       fontSize: (Responsive.isDesktop(
                                        //               context))
                                        //           ? 15
                                        //           : 13),
                                        // ),
                                        // Text(
                                        //   AppString.probability +
                                        //       '  : ${row.getCells()[4].value.toString()} %',
                                        //   style: TextStyle(
                                        //       color: black,
                                        //       fontFamily: FontName.montserrat,
                                        //       fontSize: (Responsive.isDesktop(
                                        //               context))
                                        //           ? 15
                                        //           : 13),
                                        // ),
                                        // Text(
                                        //   AppString.datetime +
                                        //       '  : ${getCTPDateTime(row.getCells()[5].value.toString())!}',
                                        //   style: TextStyle(
                                        //       color: black,
                                        //       fontFamily: FontName.montserrat,
                                        //       fontSize: (Responsive.isDesktop(
                                        //               context))
                                        //           ? 15
                                        //           : 13),
                                        // ),
                                        // Text(
                                        //   AppString.country +
                                        //       '  : ${row.getCells()[6].value.toString()}',
                                        //   style: TextStyle(
                                        //       color: black,
                                        //       fontFamily: FontName.montserrat,
                                        //       fontSize: (Responsive.isDesktop(
                                        //               context))
                                        //           ? 15
                                        //           : 13),
                                        // ),
                                        // Text(
                                        //   AppString.leadlookingfor +
                                        //       '  : ${row.getCells()[7].value.toString()}',
                                        //   style: TextStyle(
                                        //       color: black,
                                        //       fontFamily: FontName.montserrat,
                                        //       fontSize: (Responsive.isDesktop(
                                        //               context))
                                        //           ? 15
                                        //           : 13),
                                        // ),
                                        // Row(
                                        //   children: [
                                        //     Text(
                                        //       AppString.probabilityleadcloser +
                                        //           '  :  ',
                                        //       style: TextStyle(
                                        //           color: black,
                                        //           fontFamily:
                                        //               FontName.montserrat,
                                        //           fontSize:
                                        //               (Responsive.isDesktop(
                                        //                       context))
                                        //                   ? 15
                                        //                   : 13),
                                        //     ),
                                        //     Container(
                                        //         alignment: Alignment.center,
                                        //         child: Container(
                                        //           width: 132,
                                        //           height: 32,
                                        //           decoration: ShapeDecoration(
                                        //             color: getDealsColor(row
                                        //                 .getCells()[7]
                                        //                 .value
                                        //                 .toString()),
                                        //             shape:
                                        //                 RoundedRectangleBorder(
                                        //               borderRadius:
                                        //                   BorderRadius.circular(
                                        //                       2),
                                        //             ),
                                        //           ),
                                        //           child: Center(
                                        //             child: AutoSizeText(
                                        //               overflow:
                                        //                   TextOverflow.visible,
                                        //               textAlign:
                                        //                   TextAlign.center,
                                        //               maxLines: 2,
                                        //               row
                                        //                   .getCells()[8]
                                        //                   .value
                                        //                   .toString(),
                                        //               style: TextStyle(
                                        //                   color: getDealsTextColor(
                                        //                       row
                                        //                           .getCells()[7]
                                        //                           .value
                                        //                           .toString()),
                                        //                   fontFamily: FontName
                                        //                       .montserrat,
                                        //                   fontSize: (Responsive
                                        //                           .isDesktop(
                                        //                               context))
                                        //                       ? 15
                                        //                       : 13),
                                        //             ),
                                        //           ),
                                        //         )),
                                        //   ],
                                        // ),
                                        // Row(
                                        //   children: [
                                        //     Text(
                                        //       AppString.leadstatus + '  :  ',
                                        //       style: TextStyle(
                                        //           color: black,
                                        //           fontFamily:
                                        //               FontName.montserrat,
                                        //           fontSize:
                                        //               (Responsive.isDesktop(
                                        //                       context))
                                        //                   ? 15
                                        //                   : 13),
                                        //     ),
                                        //     Container(
                                        //         alignment: Alignment.center,
                                        //         child: Container(
                                        //           width: 132,
                                        //           height: 32,
                                        //           decoration: ShapeDecoration(
                                        //             color: getLeadColor(row
                                        //                 .getCells()[9]
                                        //                 .value
                                        //                 .toString()),
                                        //             shape:
                                        //                 RoundedRectangleBorder(
                                        //               borderRadius:
                                        //                   BorderRadius.circular(
                                        //                       2),
                                        //             ),
                                        //           ),
                                        //           child: Center(
                                        //             child: AutoSizeText(
                                        //               overflow:
                                        //                   TextOverflow.visible,
                                        //               textAlign:
                                        //                   TextAlign.center,
                                        //               maxLines: 2,
                                        //               row
                                        //                   .getCells()[9]
                                        //                   .value
                                        //                   .toString(),
                                        //               style: TextStyle(
                                        //                   color: getTextColor(
                                        //                       row
                                        //                           .getCells()[7]
                                        //                           .value
                                        //                           .toString()),
                                        //                   fontFamily: FontName
                                        //                       .montserrat,
                                        //                   fontSize: (Responsive
                                        //                           .isDesktop(
                                        //                               context))
                                        //                       ? 15
                                        //                       : 13),
                                        //             ),
                                        //           ),
                                        //         )
                                        //         //Text(row.getCells()[5].value.toString()),
                                        //         ),
                                        //   ],
                                        // ),
                                        (Responsive.isMobile(context))
                                            ? SizedBox(
                                                width: 200,
                                                child: ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("Close")))
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                ));
                      }
                    }),
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
  TableRow buildRow(List<String> cells, {bool isHeader = false}) => TableRow(
    children: cells.map((cell) {
      final style = TextStyle(
          color: isHeader? black : srmGulfBlue,
          fontFamily: FontName.montserrat,
          fontSize: isHeader? 12: 12,
          fontWeight: isHeader? FontWeight.bold: FontWeight.normal
      );
      return Padding(
        padding: EdgeInsets.all(10),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            cell,
            style: style,
          ),
        ),
      );
    }).toList(),
  );
}
