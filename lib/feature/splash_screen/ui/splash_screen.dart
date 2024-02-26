import 'dart:async';

import 'package:crm_dashboard/feature/auth/login/data/model/auth_data_model.dart';
import 'package:crm_dashboard/feature/auth/login/presentation/screen/login_ui.dart';
import 'package:crm_dashboard/feature/dashoard/presentation/screen/dashboard.dart';
import 'package:crm_dashboard/shared/data_sources/local/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SpashScreen extends ConsumerStatefulWidget {
  final String? title;

  SpashScreen({this.title}) : super();

  @override
  ConsumerState<SpashScreen> createState() => _SpashScreenState();
}

class _SpashScreenState extends ConsumerState<SpashScreen> {
  List<AuthDataModel>? users;
  final SharedPrefsService _sharedPrefsService = SharedPrefsService();
  bool loginStatus = false;

  void _initCheck() async {
    _sharedPrefsService.getLoginStatus().then((value) async {
      if (value.toString().trim() == 'true') {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Dashboard();
            },
          ),
          (route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) {
              return LoginUI();
              //return Dashboard();
            },
          ),
          (route) => false,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () async {
      FlutterNativeSplash.remove();
      _initCheck();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
