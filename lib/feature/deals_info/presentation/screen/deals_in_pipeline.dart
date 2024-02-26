import 'package:crm_dashboard/config/responsive/responsive.dart';
import 'package:crm_dashboard/feature/deals_info/data/model/DealsDataModel.dart';
import 'package:crm_dashboard/feature/deals_info/domain/repositories/DealDataSource.dart';
import 'package:crm_dashboard/feature/deals_info/presentation/widget/getdealsColumn.dart';
import 'package:crm_dashboard/shared/data_sources/remote/firebase_deal_services.dart';
import 'package:crm_dashboard/shared/theme/app_fonts.dart';
import 'package:crm_dashboard/shared/theme/colors.dart';
import 'package:crm_dashboard/shared/util/app_ennum_const_util.dart';
import 'package:crm_dashboard/shared/util/app_string.dart';
import 'package:crm_dashboard/shared/util/image_util.dart';
import 'package:flutter/material.dart';

/// Core import
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../shared/common_widgets/common_widgets.dart';

class DealsInPipeline extends StatefulWidget {
  DealsInPipeline({Key? key, this.selectIndex, this.hideappbar, this.getAccess})
      : super(key: key);

  int? selectIndex;
  bool? hideappbar;
  String? getAccess;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DealsInPipelineState();
  }
}

class DealsInPipelineState extends State<DealsInPipeline> {
  /// Collection of GridColumn and it required for SfDataGrid
  List<GridColumn>? columns;

  DealsDataSource? dealsDataSource;
  FirebaseDealsServices _firebaseDealsServices = FirebaseDealsServices();
  @override
  void initState() {
    dealsTabIndex = 3;
    (widget.selectIndex != null) ? widget.selectIndex : widget.selectIndex = 3;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    columns = getdealsColumns(context);
    dealsDataSource?.sortedColumns.add(const SortColumnDetails(
        name: 'name', sortDirection: DataGridSortDirection.ascending));
    dealsDataSource?.sort();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: FutureBuilder<List<DealsDataModel>>(
          future: _firebaseDealsServices.getDealsInPipeline(
              context, widget.getAccess),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<DealsDataModel> data = snapshot.data;
              if (data.isEmpty) {
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
                            fontSize:
                                (Responsive.isDesktop(context)) ? 16 : 11),
                      ),
                    ],
                  ),
                );
              }
              dealsDataSource =
                  DealsDataSource(context, crmDealData: data.toList());
              return SfDataGridTheme(
                data: SfDataGridThemeData(
                    headerColor: AppColors.gOffWhite,
                    headerHoverColor: AppColors.secondary,
                    sortIconColor: black,
                    rowHoverColor: AppColors.secondaryBg,
                    columnResizeIndicatorColor: Colors.black),
                child: Container(
                  decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 1, color: Color(0xFFE0E0E0)),
                        borderRadius: BorderRadius.circular(10),
                      )),
                  child: SfDataGrid(
                    source: dealsDataSource!,
                    columns: columns!,
                    allowSorting: true,
                    allowMultiColumnSorting: false,
                    allowTriStateSorting: false,
                    showSortNumbers: false,
                    gridLinesVisibility: GridLinesVisibility.both,
                    headerGridLinesVisibility: GridLinesVisibility.both,
                    columnWidthMode: Responsive.isDesktop(context) ||
                            Responsive.isMobile(context) ||
                            Responsive.isTablet(context)
                        ? ColumnWidthMode.fill
                        : ColumnWidthMode.none,
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
