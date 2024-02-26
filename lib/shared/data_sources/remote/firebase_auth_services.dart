import 'dart:convert';

import 'package:crm_dashboard/feature/auth/login/data/model/auth_data_model.dart';
import 'package:crm_dashboard/shared/data_sources/local/shared_preference.dart';
import 'package:crm_dashboard/shared/data_sources/remote/firebase_databse.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class FirebaseAuthServices {
  final ref = FirebaseDatabase.instance.ref();
  final auth_ref = FirebaseDatabase.instance.ref(FIREBASE_AUTH_DB);
  List<Map<dynamic, dynamic>> lists = [];
  List<AuthDataModel> userNameList = [];
  final SharedPrefsService _sharedPrefsService = SharedPrefsService();
  Future<bool> getUserDetails(BuildContext context, String UserName) async {
    print('PhoneNumber ${UserName}');
    final snapshot = await ref.child(FIREBASE_AUTH_DB).get();
    var myAuthData = <AuthDataModel>[];
    if (snapshot.exists) {
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      lists.clear();
      values.forEach((key, values) {
        lists.add(values);
      });
      String jsonLead = jsonEncode(lists);
      final crmAuthData = json.decode(jsonLead);
      var authlist = crmAuthData as List<dynamic>;
      myAuthData.clear();
      userNameList.clear();
      for (var jsonMatch in authlist) {
        AuthDataModel match = AuthDataModel.fromJson(jsonMatch);
        myAuthData.add(match);
        userNameList = myAuthData
            .where((item) => item.mobileNo.toString().contains(UserName))
            .toList();
        print('UserNameData ${userNameList.toString()}');
      }
      for (int k = 0; k < userNameList.length; k++) {
        var empId = userNameList[k].empId;
        var access = userNameList[k].access;
        var businessUnit = userNameList[k].businessUnit;
        var email = userNameList[k].emailId;
        var mob = userNameList[k].mobileNo;
        var userName = userNameList[k].fullName;
        print('firebaseServiceAuth empId ${empId}');
        print('firebaseServiceAuth access ${access}');
        print('firebaseServiceAuth businessUnit ${businessUnit}');
        print('firebaseServiceAuth userName ${userName}');
        print('firebaseServiceAuth email ${email}');
        print('firebaseServiceAuth mob ${mob}');

        _sharedPrefsService.setUserdata(
            empId, access, businessUnit, userName, email, mob.toString());
      }

      //return true;
    } else {
      return false;
      print('No data available.');
    }
    return true;
  }

  /*savePref(String? empId, String? access, String? businessUnit, String? name,
      String? email, String? mob) async {
    _preferences = await SharedPreferences.getInstance();
    _preferences.setBool('login-status', true);
    _preferences.setString('empId', empId!);
    _preferences.setString('access', access!);
    _preferences.setString('businessUnit', businessUnit!);
    _preferences.setString('name', businessUnit!);
    _preferences.setString('email', email!);
    _preferences.setString('mob', mob!);
    _preferences.commit();
    print('_preferences savedata ${_preferences.toString().length}');
  }*/

  Future<bool> getValidUserName(BuildContext context, String UserName) async {
    final snapshot = await ref.child(FIREBASE_AUTH_DB).get();
    var myAuthData = <AuthDataModel>[];
    if (snapshot.exists) {
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      lists.clear();
      values.forEach((key, values) {
        lists.add(values);
      });
      String jsonLead = jsonEncode(lists);
      final crmAuthData = json.decode(jsonLead);
      var authlist = crmAuthData as List<dynamic>;
      myAuthData.clear();
      userNameList.clear();
      for (var jsonMatch in authlist) {
        AuthDataModel match = AuthDataModel.fromJson(jsonMatch);
        myAuthData.add(match);
        userNameList = myAuthData
            .where((item) => item.mobileNo.toString().contains(UserName))
            .toList();
      }
      print('userNameList length ${userNameList.length.toString()}');
      if (userNameList.length == 0) {
        print('false.');
        return false;
      } else {
        print('true.');
        return true;
      }
    } else {
      print('No data available.');
    }
    if (userNameList.length == 0) {
      print('No false.');
      return false;
    } else {
      print('No true.');
      return true;
    }
  }
}
