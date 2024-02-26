

import 'package:crm_dashboard/shared/util/app_string.dart';

enum Flavor { dev, prod, qa}

class AppFlavors {
  static late Flavor appFlavor;

  static String get title {
    switch (appFlavor) {
      case Flavor.prod:
        return AppString.appNameProd;
      case Flavor.qa:
        return AppString.appNameQa;
      case Flavor.dev:
      default:
        return AppString.appNameDev;
    }
  }

  //get my enviroment
  static bool get isDev => appFlavor == Flavor.dev;
  static bool get isProd => appFlavor == Flavor.prod;
  static bool get isQa => appFlavor == Flavor.qa;

  // get base url
  static String get baseUrl {
    switch (appFlavor) {
      case Flavor.prod:
        return 'https://dummyjson.com';
      case Flavor.qa:
        return 'https://api.flutter.flavor-qa.com.br';
      case Flavor.dev:
      default:
        return 'https://api.flutter.flavor-dev.com.br';
    }
  }
}