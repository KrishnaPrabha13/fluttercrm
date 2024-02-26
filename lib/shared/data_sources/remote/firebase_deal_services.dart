import 'dart:convert';

import 'package:crm_dashboard/feature/deals_info/data/model/DealsDataModel.dart';
import 'package:crm_dashboard/shared/data_sources/remote/firebase_databse.dart';
import 'package:crm_dashboard/shared/util/common_util.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FirebaseDealsServices {
  final ref = FirebaseDatabase.instance.ref();
  final deals_ref = FirebaseDatabase.instance.ref(FIREBASE_DEALS_DB);
  List<Map<dynamic, dynamic>> lists = [];
  List<DealsDataModel> monthlyList = [];
  List<DealsDataModel> FilterDealsList = [];
  List<DealsDataModel> DealsinPipelineList = [];

  Future<List<DealsDataModel>> getTotalDeals(
      BuildContext context, String? businessUnit) async {
    final snapshot = await ref.child(FIREBASE_DEALS_DB).get();
    if (snapshot.exists) {
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      lists.clear();
      values.forEach((key, values) {
        lists.add(values);
      });
      print('deals ${lists}');
      String jsonLead = jsonEncode(lists);
      final crmLeadData = json.decode(jsonLead);
      var leadlist = crmLeadData as List<dynamic>;
      var myData = <DealsDataModel>[];
      //print('mydata 57 $businessUnit');
      for (var jsonMatch in leadlist) {
        DealsDataModel match = DealsDataModel.fromJson(jsonMatch);
        myData.add(match);

        if (businessUnit != 'All') {
          FilterDealsList = myData
              .where((element) => element.businessUnit == businessUnit)
              .toList();
        } else {
          FilterDealsList = myData;
        }
      }
      FilterDealsList.sort((b, a) {
        return a.closingDate!.compareTo(b.closingDate!);
      });
      return FilterDealsList;
    } else {
      print('No data available.');
    }
    return FilterDealsList;
  }

  Future<List<DealsDataModel>> getDealsInPipelineChart(
      BuildContext context, String? businessUnit) async {
    final snapshot = await ref.child(FIREBASE_DEALS_DB).get();
    if (snapshot.exists) {
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      lists.clear();
      values.forEach((key, values) {
        lists.add(values);
      });
      print('deals ${lists}');
      String jsonLead = jsonEncode(lists);
      final crmLeadData = json.decode(jsonLead);
      var leadlist = crmLeadData as List<dynamic>;
      var myData = <DealsDataModel>[];

      for (var jsonMatch in leadlist) {
        DealsDataModel match = DealsDataModel.fromJson(jsonMatch);
        myData.add(match);
        if (businessUnit != 'All') {
          FilterDealsList = myData
              .where((element) => element.businessUnit == businessUnit)
              .toList();
        } else {
          FilterDealsList = myData;
          //print('listdata70 ${FilterDealsList.toList().length}');
        }
      }
      FilterDealsList.sort((b, a) {
        return a.closingDate!.compareTo(b.closingDate!);
      });
      return FilterDealsList;
    } else {
      print('No data available.');
    }
    return FilterDealsList;
  }

  Future<List<DealsDataModel>> getMonthlyDeals(
      BuildContext context, String? businessUnit) async {
    var myData = <DealsDataModel>[];
    final snapshot = await ref.child(FIREBASE_DEALS_DB).get();

    if (snapshot.exists) {
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      lists.clear();
      values.forEach((key, values) {
        lists.add(values);
      });
      String jsonLead = jsonEncode(lists);
      final crmLeadData = json.decode(jsonLead);
      var leadlist = crmLeadData as List<dynamic>;
      var myData = <DealsDataModel>[];

      for (var jsonMatch in leadlist) {
        DealsDataModel match = DealsDataModel.fromJson(jsonMatch);
        myData.add(match);
        if (businessUnit != 'All') {
          FilterDealsList = myData
              .where((element) => element.businessUnit == businessUnit)
              .toList();
        } else {
          FilterDealsList = myData;
        }
        monthlyList = FilterDealsList.where((element) =>
            (getCTPDateTime(element.closingDate.toString())!.contains(
                DateFormat(DateFormat.ABBR_MONTH).format(DateTime.now()))) &&
            (getCTPDateTime(element.closingDate.toString())!.contains(
                DateFormat(DateFormat.YEAR).format(DateTime.now())))).toList();
      }
      monthlyList.sort((b, a) {
        return a.closingDate!.compareTo(b.closingDate!);
      });
      return monthlyList;
    } else {
      print('No data available.');
    }
    return monthlyList;
  }

  Future<List<DealsDataModel>> getDealsInPipeline(
      BuildContext context, String? businessUnit) async {
    final snapshot = await ref.child(FIREBASE_DEALS_DB).get();
    if (snapshot.exists) {
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      lists.clear();
      values.forEach((key, values) {
        lists.add(values);
      });
      //print('deals ${lists}');
      String jsonLead = jsonEncode(lists);
      final crmLeadData = json.decode(jsonLead);
      var leadlist = crmLeadData as List<dynamic>;
      var myData = <DealsDataModel>[];
      for (var jsonMatch in leadlist) {
        DealsDataModel match = DealsDataModel.fromJson(jsonMatch);
        myData.add(match);

        if (businessUnit != 'All') {
          FilterDealsList = myData
              .where((element) => element.businessUnit == businessUnit)
              .toList();
          DealsinPipelineList = FilterDealsList.where((element) =>
              element.dealsStage != 'Closed Lost' &&
              element.dealsStage != 'Closed Won').toList();
        } else {
          FilterDealsList = myData;
          DealsinPipelineList = FilterDealsList.where((element) =>
              element.dealsStage != 'Closed Lost' &&
              element.dealsStage != 'Closed Won').toList();
        }
      }
      DealsinPipelineList.sort((b, a) {
        return a.closingDate!.compareTo(b.closingDate!);
      });
      return DealsinPipelineList;
    } else {
      print('No data available.');
    }
    return DealsinPipelineList;
  }

  Future<List<DealsDataModel>> getRevenueThisMonth(
      BuildContext context, String? businessUnit) async {
    final snapshot = await ref.child(FIREBASE_DEALS_DB).get();
    if (snapshot.exists) {
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      lists.clear();
      values.forEach((key, values) {
        lists.add(values);
      });
      //print('deals ${lists}');
      String jsonLead = jsonEncode(lists);
      final crmLeadData = json.decode(jsonLead);
      var leadlist = crmLeadData as List<dynamic>;
      var myData = <DealsDataModel>[];
      for (var jsonMatch in leadlist) {
        DealsDataModel match = DealsDataModel.fromJson(jsonMatch);
        myData.add(match);

        if (businessUnit != 'All') {
          FilterDealsList = myData
              .where((element) => element.businessUnit == businessUnit)
              .toList();
          DealsinPipelineList = FilterDealsList.where(
              (element) => element.dealsStage == 'Closed Won').toList();

          monthlyList = DealsinPipelineList.where((element) =>
              (getCTPDateTime(element.closingDate.toString())!.contains(
                  DateFormat(DateFormat.ABBR_MONTH).format(DateTime.now()))) &&
              (getCTPDateTime(element.closingDate.toString())!.contains(
                  DateFormat(DateFormat.YEAR)
                      .format(DateTime.now())))).toList();
        } else {
          FilterDealsList = myData;
          DealsinPipelineList = FilterDealsList.where(
              (element) => element.dealsStage == 'Closed Won').toList();
          monthlyList = DealsinPipelineList.where((element) =>
              (getCTPDateTime(element.closingDate.toString())!.contains(
                  DateFormat(DateFormat.ABBR_MONTH).format(DateTime.now()))) &&
              (getCTPDateTime(element.closingDate.toString())!.contains(
                  DateFormat(DateFormat.YEAR)
                      .format(DateTime.now())))).toList();
        }
      }
      monthlyList.sort((b, a) {
        return a.closingDate!.compareTo(b.closingDate!);
      });
      return monthlyList;
    } else {
      print('No data available.');
    }
    return monthlyList;
  }

  Future<List<DealsDataModel>> getRevenueLostThisMonth(
      BuildContext context, String? businessUnit) async {
    final snapshot = await ref.child(FIREBASE_DEALS_DB).get();
    if (snapshot.exists) {
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      lists.clear();
      values.forEach((key, values) {
        lists.add(values);
      });
      //print('deals ${lists}');
      String jsonLead = jsonEncode(lists);
      final crmLeadData = json.decode(jsonLead);
      var leadlist = crmLeadData as List<dynamic>;
      var myData = <DealsDataModel>[];
      for (var jsonMatch in leadlist) {
        DealsDataModel match = DealsDataModel.fromJson(jsonMatch);
        myData.add(match);

        if (businessUnit != 'All') {
          FilterDealsList = myData
              .where((element) => element.businessUnit == businessUnit)
              .toList();
          DealsinPipelineList = FilterDealsList.where(
              (element) => element.dealsStage == 'Closed Lost').toList();

          monthlyList = DealsinPipelineList.where((element) =>
              (getCTPDateTime(element.closingDate.toString())!.contains(
                  DateFormat(DateFormat.ABBR_MONTH).format(DateTime.now()))) &&
              (getCTPDateTime(element.closingDate.toString())!.contains(
                  DateFormat(DateFormat.YEAR)
                      .format(DateTime.now())))).toList();
        } else {
          FilterDealsList = myData;
          DealsinPipelineList = FilterDealsList.where(
              (element) => element.dealsStage == 'Closed Lost').toList();
          monthlyList = DealsinPipelineList.where((element) =>
              (getCTPDateTime(element.closingDate.toString())!.contains(
                  DateFormat(DateFormat.ABBR_MONTH).format(DateTime.now()))) &&
              (getCTPDateTime(element.closingDate.toString())!.contains(
                  DateFormat(DateFormat.YEAR)
                      .format(DateTime.now())))).toList();
        }
      }
      monthlyList.sort((b, a) {
        return a.closingDate!.compareTo(b.closingDate!);
      });
      return monthlyList;
    } else {
      print('No data available.');
    }
    return monthlyList;
  }
}
