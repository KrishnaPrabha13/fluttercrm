import 'dart:convert';

import 'package:crm_dashboard/feature/dashoard/data/model/CrmLeadModel.dart';
import 'package:crm_dashboard/feature/lead_details/data/model/WeeklyLeadListModel.dart';
import 'package:crm_dashboard/feature/lead_details/data/model/weekly_data_detail.dart';
import 'package:crm_dashboard/shared/data_sources/remote/firebase_databse.dart';
import 'package:crm_dashboard/shared/util/common_util.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FirebaseLeadServices {
  final ref = FirebaseDatabase.instance.ref();
  final lead_ref = FirebaseDatabase.instance.ref(FIREBASE_LEADS_DB);

  List<Map<dynamic, dynamic>> lists = [];
  List<CrmLeadModel> crmLeadList = [];
  List<CrmLeadModel> todaysList = [];
  List<CrmLeadModel> WeeklyLeadList = [];
  List<CrmLeadModel> monthlyList = [];
  List<CrmLeadModel> unTouchedLeadList = [];
  List<CrmLeadModel> FilterLeadList = [];
  var LeadList = <CrmLeadModel>[];
  var OthersLeadList = <CrmLeadModel>[];
  Future<List<CrmLeadModel>> getFilterLeads(
      BuildContext context, String? businessUnit) async {
    //
    final snapshot = await ref.child(FIREBASE_LEADS_DB).get();

    if (snapshot.exists) {
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      lists.clear();
      values.forEach((key, values) {
        lists.add(values);
      });
      String jsonLead = jsonEncode(lists);
      final crmLeadData = json.decode(jsonLead);
      var leadlist = crmLeadData as List<dynamic>;
      var myData = <CrmLeadModel>[];
      FilterLeadList.clear();
      for (var jsonMatch in leadlist) {
        CrmLeadModel match = CrmLeadModel.fromJson(jsonMatch);
        myData.add(match);
        if (businessUnit != 'All') {
          FilterLeadList = myData
              .where((element) => element.businessUnit == businessUnit)
              .toList();
        } else {
          FilterLeadList = myData;
        }
      }
      return FilterLeadList;
    } else {
      print('No data available.');
    }
    return FilterLeadList;
  }

  Future<List<CrmLeadModel>> getTotalLeads(
      BuildContext context, String searchQuery, String? businessUnit) async {
    var myData = <CrmLeadModel>[];
    final snapshot = await ref.child(FIREBASE_LEADS_DB).get();

    if (snapshot.exists) {
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      lists.clear();
      values.forEach((key, values) {
        lists.add(values);
      });
      String jsonLead = jsonEncode(lists);
      final crmLeadData = json.decode(jsonLead);
      var leadlist = crmLeadData as List<dynamic>;
      var myData = <CrmLeadModel>[];

      for (var jsonMatch in leadlist) {
        CrmLeadModel match = CrmLeadModel.fromJson(jsonMatch);
        myData.add(match);
        if (businessUnit != 'All') {
          myData = myData
              .where((element) => element.businessUnit == businessUnit)
              .toList();
        } else {
          myData;
        }
        if (searchQuery.isNotEmpty) {
          myData = myData
              .where((item) =>
                  item.leadSource
                      .toString()
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()) ||
                  item.leadSource
                      .toString()
                      .toUpperCase()
                      .contains(searchQuery.toUpperCase()) ||
                  item.businessUnit
                      .toString()
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()) ||
                  item.businessUnit
                      .toString()
                      .toUpperCase()
                      .contains(searchQuery.toUpperCase()) ||
                  item.company
                      .toString()
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()) ||
                  item.company
                      .toString()
                      .toUpperCase()
                      .contains(searchQuery.toUpperCase()) ||
                  item.leadStatus
                      .toString()
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()) ||
                  item.leadStatus
                      .toString()
                      .toUpperCase()
                      .contains(searchQuery.toUpperCase()) ||
                  getCTPDateTime(item.createdTime.toString())!
                      .toString()
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()) ||
                  getCTPDateTime(item.createdTime.toString())!
                      .toString()
                      .toUpperCase()
                      .contains(searchQuery.toUpperCase()) ||
                  item.probability
                      .toString()
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()) ||
                  item.probability
                      .toString()
                      .toUpperCase()
                      .contains(searchQuery.toUpperCase()))
              .toList();
        }
      }
      myData.sort((b, a) {
        return a.createdTime!.compareTo(b.createdTime!);
      });
      return myData;
    } else {
      //print('No data available.');
    }

    return myData;
  }

  Future<List<CrmLeadModel>> getLeadBySource(
      BuildContext context, String searchQuery, String? businessUnit) async {
    var myData = <CrmLeadModel>[];
    final snapshot = await ref.child(FIREBASE_LEADS_DB).get();

    if (snapshot.exists) {
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      lists.clear();
      values.forEach((key, values) {
        lists.add(values);
      });
      String jsonLead = jsonEncode(lists);
      final crmLeadData = json.decode(jsonLead);
      var leadlist = crmLeadData as List<dynamic>;
      var myData = <CrmLeadModel>[];

      for (var jsonMatch in leadlist) {
        CrmLeadModel match = CrmLeadModel.fromJson(jsonMatch);
        myData.add(match);
        if (businessUnit != 'All') {
          myData = myData
              .where((element) => element.businessUnit == businessUnit)
              .toList();
        } else {
          myData;
        }

        /*LeadList = myData
            .where((element) =>
                element.leadStatus == 'Contacted' ||
                element.leadStatus == 'Not Contacted')
            .toList();*/
        if (searchQuery.isNotEmpty) {
          myData = myData
              .where((item) =>
                  item.leadSource
                      .toString()
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()) ||
                  item.leadSource
                      .toString()
                      .toUpperCase()
                      .contains(searchQuery.toUpperCase()) ||
                  item.businessUnit
                      .toString()
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()) ||
                  item.businessUnit
                      .toString()
                      .toUpperCase()
                      .contains(searchQuery.toUpperCase()) ||
                  item.company
                      .toString()
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()) ||
                  item.company
                      .toString()
                      .toUpperCase()
                      .contains(searchQuery.toUpperCase()) ||
                  item.leadStatus
                      .toString()
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()) ||
                  item.leadStatus
                      .toString()
                      .toUpperCase()
                      .contains(searchQuery.toUpperCase()) ||
                  getCTPDateTime(item.createdTime.toString())!
                      .toString()
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()) ||
                  getCTPDateTime(item.createdTime.toString())!
                      .toString()
                      .toUpperCase()
                      .contains(searchQuery.toUpperCase()) ||
                  item.probability
                      .toString()
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()) ||
                  item.probability
                      .toString()
                      .toUpperCase()
                      .contains(searchQuery.toUpperCase()))
              .toList();
        }
      }
      myData.sort((b, a) {
        return a.createdTime!.compareTo(b.createdTime!);
      });
      return myData;
    } else {
      //print('No data available.');
    }

    return myData;
  }

  Future<List<CrmLeadModel>> getTodayLeads(
      BuildContext context, String searchQuery, String? businessUnit) async {
    final snapshot = await ref.child(FIREBASE_LEADS_DB).get();

    if (snapshot.exists) {
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      lists.clear();
      values.forEach((key, values) {
        lists.add(values);
      });
      String jsonLead = jsonEncode(lists);
      final crmLeadData = json.decode(jsonLead);
      var leadlist = crmLeadData as List<dynamic>;
      var myData = <CrmLeadModel>[];

      for (var jsonMatch in leadlist) {
        CrmLeadModel match = CrmLeadModel.fromJson(jsonMatch);
        myData.add(match);
        if (businessUnit != 'All') {
          myData = myData
              .where((element) => element.businessUnit == businessUnit)
              .toList();
        } else {
          myData;
        }
        todaysList = myData
            .where((element) => getCTPDateTime(element.createdTime.toString())!
                .toString()
                .contains(getCurrentDateTime().toString()))
            .toList();
        if (todaysList.length != 0 || todaysList != null) {
          if (searchQuery.isNotEmpty) {
            todaysList = todaysList
                .where((item) =>
                    item.leadSource
                        .toString()
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase()) ||
                    item.leadSource
                        .toString()
                        .toUpperCase()
                        .contains(searchQuery.toUpperCase()) ||
                    item.businessUnit
                        .toString()
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase()) ||
                    item.businessUnit
                        .toString()
                        .toUpperCase()
                        .contains(searchQuery.toUpperCase()) ||
                    item.company
                        .toString()
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase()) ||
                    item.company
                        .toString()
                        .toUpperCase()
                        .contains(searchQuery.toUpperCase()) ||
                    item.leadStatus
                        .toString()
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase()) ||
                    item.leadStatus
                        .toString()
                        .toUpperCase()
                        .contains(searchQuery.toUpperCase()) ||
                    getCTPDateTime(item.createdTime.toString())!
                        .toString()
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase()) ||
                    getCTPDateTime(item.createdTime.toString())!
                        .toString()
                        .toUpperCase()
                        .contains(searchQuery.toUpperCase()) ||
                    item.probability
                        .toString()
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase()) ||
                    item.probability
                        .toString()
                        .toUpperCase()
                        .contains(searchQuery.toUpperCase()))
                .toList();
          }
        } else {
          print('No data available');
        }
      }
      todaysList.sort((b, a) {
        return a.createdTime!.compareTo(b.createdTime!);
      });
      return todaysList;
    } else {
      print('No data available.');
    }
    return todaysList;
  }

  Future<List<WeeklyLeadListModel>> getWeeklyLeads(
      BuildContext context, String searchQuery, String? businessUnit) async {
    final snapshot = await ref.child(FIREBASE_LEADS_DB).get();
    var myData = <CrmLeadModel>[];
    var myData1 = <WeeklyLeadListModel>[];
    var dateList = [];
    List<DateTime> FinalDateList = [];
    List<CrmLeadModel> weeklyList = [];
    List<String> _weekList = [];
    List<WeeklyLeadListModel> weeklyLeadListModel = [];
    if (snapshot.exists) {
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      lists.clear();
      values.forEach((key, values) {
        lists.add(values);
      });

      String jsonLead = jsonEncode(lists);
      final crmLeadData = json.decode(jsonLead);
      var leadlist = crmLeadData as List<dynamic>;

      for (var jsonMatch in leadlist) {
        CrmLeadModel match = CrmLeadModel.fromJson(jsonMatch);
        myData.add(match);
        if (businessUnit != 'All') {
          myData = myData
              .where((element) => element.businessUnit == businessUnit)
              .toList();
        } else {
          myData;
        }
      }

      DateTime now = DateTime.now();
      int currentDay = now.weekday;
      DateTime firstDayOfWeek = now.subtract(Duration(days: currentDay - 1));
      String sdate =
          DateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(firstDayOfWeek);
      DateTime today = DateTime.now();
      String cdate = DateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(today);
      DateTime CurrentDate = DateTime.parse(cdate);
      DateTime StartDate = DateTime.parse(sdate);

      FinalDateList = getDaysInBetween(StartDate, CurrentDate);
      dateList.clear();
      FinalDateList.forEach((day) {
        String DateList = DateFormat('MMM d, yyyy').format(day);
        dateList.add(DateList);
      });

      _weekList.clear();
      weeklyList.clear();
      for (int i = 0; i < dateList.length; i++) {
        weeklyList = myData
            .where((element) => getCTPDateTime(element.createdTime.toString())!
                .contains(dateList[i].toString()))
            .toList();
        //print('weeklyLeadslist3 ${weeklyList}');
        if (weeklyList != null) {
          for (int k = 0; k < weeklyList.length; k++) {
            var c = weeklyList[k].company;
            var d = weeklyList[k].createdTime;
            var p = weeklyList[k].probability;
            var b = weeklyList[k].businessUnit;
            var l = weeklyList[k].leadSource;
            var ls = weeklyList[k].leadStatus;
            var lownwer = weeklyList[k].leadOwner;
            var lf = weeklyList[k].lookingFor;
            var procloser = weeklyList[k].probabilityofLeadClosure;
            var country = weeklyList[k].country;

            WeeklyDataDetail weeklyDataDetail = WeeklyDataDetail(
                d.toString(),
                c.toString(),
                p.toString(),
                b.toString(),
                l.toString(),
                ls.toString(),
                lownwer.toString(),
                lf.toString(),
                procloser.toString(),
                country.toString());
            String jsonUser = jsonEncode(weeklyDataDetail);
            _weekList.add(jsonUser.toString());
          }
        }
        //print('weeklyLeadslist2 ${_weekList}');
        dynamic jsonResponse1 = json.decode(_weekList.toString());
        weeklyLeadListModel.clear();
        myData1.clear();
        //print('weeklyLeadslist1 ${jsonResponse1}');
        for (var jsonMatch in jsonResponse1) {
          WeeklyLeadListModel match = WeeklyLeadListModel.fromJson(jsonMatch);
          myData1.add(match);
          weeklyLeadListModel = myData1;
          print('weeklyLeadslist ${weeklyLeadListModel}');
          if (searchQuery.isNotEmpty) {
            weeklyLeadListModel = myData1
                .where((item) =>
                    item.leadSource
                        .toString()
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase()) ||
                    item.leadSource
                        .toString()
                        .toUpperCase()
                        .contains(searchQuery.toUpperCase()) ||
                    item.businessUnit
                        .toString()
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase()) ||
                    item.businessUnit
                        .toString()
                        .toUpperCase()
                        .contains(searchQuery.toUpperCase()) ||
                    item.company
                        .toString()
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase()) ||
                    item.company
                        .toString()
                        .toUpperCase()
                        .contains(searchQuery.toUpperCase()) ||
                    item.leadStatus
                        .toString()
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase()) ||
                    item.leadStatus
                        .toString()
                        .toUpperCase()
                        .contains(searchQuery.toUpperCase()) ||
                    getCTPDateTime(item.dayName.toString())!
                        .toString()
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase()) ||
                    getCTPDateTime(item.dayName.toString())!
                        .toString()
                        .toUpperCase()
                        .contains(searchQuery.toUpperCase()) ||
                    item.probability
                        .toString()
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase()) ||
                    item.probability
                        .toString()
                        .toUpperCase()
                        .contains(searchQuery.toUpperCase()))
                .toList();
          }
        }
      }
      weeklyLeadListModel.sort((b, a) {
        return a.dayName!.compareTo(b.dayName!);
      });
      return weeklyLeadListModel;
    } else {
      // print('No data available.');
    }
    return weeklyLeadListModel;
  }

  Future<List<CrmLeadModel>> getMonthlyLeads(
      BuildContext context, String searchQuery, String? businessUnit) async {
    final snapshot = await ref.child(FIREBASE_LEADS_DB).get();

    if (snapshot.exists) {
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      lists.clear();
      values.forEach((key, values) {
        lists.add(values);
      });
      String jsonLead = jsonEncode(lists);
      final crmLeadData = json.decode(jsonLead);
      var leadlist = crmLeadData as List<dynamic>;
      var myData = <CrmLeadModel>[];
      myData.clear();
      for (var jsonMatch in leadlist) {
        CrmLeadModel match = CrmLeadModel.fromJson(jsonMatch);
        myData.add(match);
        if (businessUnit != 'All') {
          myData = myData
              .where((element) => element.businessUnit == businessUnit)
              .toList();
        } else {
          myData;
        }
        monthlyList = myData
            .where((element) =>
                (getCTPDateTime(element.createdTime.toString())!.contains(
                    DateFormat(DateFormat.ABBR_MONTH)
                        .format(DateTime.now()))) &&
                (getCTPDateTime(element.createdTime.toString())!.contains(
                    DateFormat(DateFormat.YEAR).format(DateTime.now()))))
            .toList();
        if (searchQuery.isNotEmpty) {
          monthlyList = monthlyList
              .where((item) =>
                  item.leadSource
                      .toString()
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()) ||
                  item.leadSource
                      .toString()
                      .toUpperCase()
                      .contains(searchQuery.toUpperCase()) ||
                  item.businessUnit
                      .toString()
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()) ||
                  item.businessUnit
                      .toString()
                      .toUpperCase()
                      .contains(searchQuery.toUpperCase()) ||
                  item.company
                      .toString()
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()) ||
                  item.company
                      .toString()
                      .toUpperCase()
                      .contains(searchQuery.toUpperCase()) ||
                  item.leadStatus
                      .toString()
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()) ||
                  item.leadStatus
                      .toString()
                      .toUpperCase()
                      .contains(searchQuery.toUpperCase()) ||
                  getCTPDateTime(item.createdTime.toString())!
                      .toString()
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()) ||
                  getCTPDateTime(item.createdTime.toString())!
                      .toString()
                      .toUpperCase()
                      .contains(searchQuery.toUpperCase()) ||
                  item.probability
                      .toString()
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()) ||
                  item.probability
                      .toString()
                      .toUpperCase()
                      .contains(searchQuery.toUpperCase()))
              .toList();
        }
      }
      monthlyList.sort((b, a) {
        return a.createdTime!.compareTo(b.createdTime!);
      });
      return monthlyList;
    } else {
      print('No data available.');
    }
    return monthlyList;
  }

  Future<List<CrmLeadModel>> getUntouchedLeads(
      BuildContext context, String searchQuery, String? businessUnit) async {
    final snapshot = await ref.child(FIREBASE_LEADS_DB).get();

    if (snapshot.exists) {
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      lists.clear();
      values.forEach((key, values) {
        lists.add(values);
      });
      String jsonLead = jsonEncode(lists);
      final crmLeadData = json.decode(jsonLead);
      var leadlist = crmLeadData as List<dynamic>;
      var myData = <CrmLeadModel>[];
      myData.clear();
      for (var jsonMatch in leadlist) {
        CrmLeadModel match = CrmLeadModel.fromJson(jsonMatch);
        myData.add(match);
        if (businessUnit != 'All') {
          myData = myData
              .where((element) => element.businessUnit == businessUnit)
              .toList();
        } else {
          myData;
        }
        unTouchedLeadList = myData
            .where((element) => element.leadStatus == 'Not Contacted')
            .toList();
        if (searchQuery.isNotEmpty) {
          unTouchedLeadList = unTouchedLeadList
              .where((item) =>
                  item.leadSource
                      .toString()
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()) ||
                  item.leadSource
                      .toString()
                      .toUpperCase()
                      .contains(searchQuery.toUpperCase()) ||
                  item.businessUnit
                      .toString()
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()) ||
                  item.businessUnit
                      .toString()
                      .toUpperCase()
                      .contains(searchQuery.toUpperCase()) ||
                  item.company
                      .toString()
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()) ||
                  item.company
                      .toString()
                      .toUpperCase()
                      .contains(searchQuery.toUpperCase()) ||
                  item.leadStatus
                      .toString()
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()) ||
                  item.leadStatus
                      .toString()
                      .toUpperCase()
                      .contains(searchQuery.toUpperCase()) ||
                  getCTPDateTime(item.createdTime.toString())!
                      .toString()
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()) ||
                  getCTPDateTime(item.createdTime.toString())!
                      .toString()
                      .toUpperCase()
                      .contains(searchQuery.toUpperCase()) ||
                  item.probability
                      .toString()
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()) ||
                  item.probability
                      .toString()
                      .toUpperCase()
                      .contains(searchQuery.toUpperCase()))
              .toList();
        }
      }
      unTouchedLeadList.sort((b, a) {
        return a.createdTime!.compareTo(b.createdTime!);
      });
      return unTouchedLeadList;
    } else {
      // print('No data available.');
    }
    return unTouchedLeadList;
  }

  Future<List<CrmLeadModel>> getOthersLeads(
      BuildContext context, String searchQuery, String? businessUnit) async {
    var myData = <CrmLeadModel>[];
    final snapshot = await ref.child(FIREBASE_LEADS_DB).get();

    if (snapshot.exists) {
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      lists.clear();
      values.forEach((key, values) {
        lists.add(values);
      });
      String jsonLead = jsonEncode(lists);
      final crmLeadData = json.decode(jsonLead);
      var leadlist = crmLeadData as List<dynamic>;
      var myData = <CrmLeadModel>[];

      for (var jsonMatch in leadlist) {
        CrmLeadModel match = CrmLeadModel.fromJson(jsonMatch);
        myData.add(match);
        if (businessUnit != 'All') {
          myData = myData
              .where((element) => element.businessUnit == businessUnit)
              .toList();
        } else {
          myData;
        }
        OthersLeadList = myData
            .where((element) => element.leadStatus != 'Not Contacted')
            .toList();

        if (searchQuery.isNotEmpty) {
          OthersLeadList = OthersLeadList.where((item) =>
              item.leadSource
                  .toString()
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()) ||
              item.leadSource
                  .toString()
                  .toUpperCase()
                  .contains(searchQuery.toUpperCase()) ||
              item.businessUnit
                  .toString()
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()) ||
              item.businessUnit
                  .toString()
                  .toUpperCase()
                  .contains(searchQuery.toUpperCase()) ||
              item.company
                  .toString()
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()) ||
              item.company
                  .toString()
                  .toUpperCase()
                  .contains(searchQuery.toUpperCase()) ||
              item.leadStatus
                  .toString()
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()) ||
              item.leadStatus
                  .toString()
                  .toUpperCase()
                  .contains(searchQuery.toUpperCase()) ||
              getCTPDateTime(item.createdTime.toString())!
                  .toString()
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()) ||
              getCTPDateTime(item.createdTime.toString())!
                  .toString()
                  .toUpperCase()
                  .contains(searchQuery.toUpperCase()) ||
              item.probability
                  .toString()
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()) ||
              item.probability
                  .toString()
                  .toUpperCase()
                  .contains(searchQuery.toUpperCase())).toList();
        }
      }
      OthersLeadList.sort((b, a) {
        return a.createdTime!.compareTo(b.createdTime!);
      });
      return OthersLeadList;
    } else {
      //print('No data available.');
    }

    return OthersLeadList;
  }
}
