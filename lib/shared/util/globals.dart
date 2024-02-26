import 'dart:io';

import 'package:flutter/material.dart';

final kTestMode = Platform.environment.containsKey('FLUTTER_TEST');
const String APP_THEME_STORAGE_KEY = 'AppTheme';
const String USER_LOCAL_STORAGE_KEY = 'user';
const String GLOBAL_KEY = 'srm_unified';
const int PRODUCTS_PER_PAGE = 20;
bool isCardView = true;

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

/*
class Global {
  static Global? _instance;

  //privatised Constructor
   Global._internal(){
     print('PRIVATE Global CONSTRUCTOR');
   }
   static Global getInstance(){
     _instance ??= Global._internal();
     return _instance!;
   }
}*/
