// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';

import 'package:crm_dashboard/feature/auth/login/data/model/auth_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static SharedPreferences? _preferences;
  static const _keyUsers = 'users';
  List<AuthDataModel> UserList = [];
  String? loginUser, user, empid, access, businessUnit, email, mob, Username;
  var value;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static AuthDataModel getUser(String idUser) {
    final json = _preferences?.getString(idUser);

    return AuthDataModel.fromJson(jsonDecode(json!));
  }

  static List<AuthDataModel> getUsers() {
    final idUsers = _preferences?.getStringList(_keyUsers);

    if (idUsers == null) {
      return <AuthDataModel>[];
    } else {
      return idUsers.map<AuthDataModel>(getUser).toList();
    }
  }

  Future<bool?> getLoginStatus() async {
    _preferences = await SharedPreferences.getInstance();
    bool? boolValue = _preferences?.getBool('login-status');
    return boolValue;
  }

  Future<String?> UserName() async {
    _preferences = await SharedPreferences.getInstance();
    Username = _preferences?.getString('name');
    // Username = 'Vignesh A'; //Need to remove this line
    return Username;
  }

  Future<String?> EmpId() async {
    _preferences = await SharedPreferences.getInstance();
    empid = _preferences?.getString('empId');
    //empid = 'A1234'; //Need to remove this line
    return empid;
  }

  Future<String?> BusinessUnit() async {
    _preferences = await SharedPreferences.getInstance();
    businessUnit = _preferences?.getString('businessUnit');
    //businessUnit = 'CIS'; //Need to remove this line
    return businessUnit;
  }

  Future<String?> Email() async {
    _preferences = await SharedPreferences.getInstance();
    email = _preferences?.getString('email');
    //email = 'vignesh@srmtech.com'; //Need to remove this line
    return email;
  }

  Future<String?> Mobile() async {
    _preferences = await SharedPreferences.getInstance();
    mob = _preferences?.getString('mob');
    //mob = '9999999999'; //Need to remove this line
    return mob;
  }

  Future<String?> LoginUser() async {
    _preferences = await SharedPreferences.getInstance();
    loginUser = _preferences?.getString('login-status');
    return loginUser;
  }

  Future<String?> getAccess() async {
    _preferences = await SharedPreferences.getInstance();
    access = _preferences?.getString('access');
    //access = 'All'; //Need to remove this line
    return access;
  }

  Future<bool> setUserdata(String? empId, String? access, String? businessUnit,
      String? name, String? email, String? mob) async {
    _preferences = await SharedPreferences.getInstance();
    _preferences?.setBool('login-status', true);
    _preferences?.setString('empId', empId!);
    _preferences?.setString('access', access!);
    _preferences?.setString('businessUnit', businessUnit!);
    _preferences?.setString('name', name!);
    _preferences?.setString('email', email!);
    _preferences?.setString('mob', mob!);
    _preferences?.commit();
    //print('_preferences savedata ');
    return true;
  }

  Future<bool> removeUserdata() async {
    _preferences = await SharedPreferences.getInstance();
    return await _preferences!.clear();
  }
}
