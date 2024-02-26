import 'package:crm_dashboard/feature/auth/login/presentation/screen/login_ui.dart';
import 'package:crm_dashboard/feature/dashoard/presentation/screen/dashboard.dart';
import 'package:crm_dashboard/feature/splash_screen/ui/splash_screen.dart';
import 'package:crm_dashboard/routes/navigator_services.dart';
import 'package:crm_dashboard/routes/route_path.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case RoutePath.SPLASH_SCREEN:
        return MaterialPageRoute(builder: (_) => SpashScreen());
      case RoutePath.LOGIN_SCREEN:
        // Validation of correct data type
        if (args is List<String>) {
          return MaterialPageRoute(
            builder: (_) => LoginUI(),
          );
        }
      case RoutePath.DASHBOARD_PAGE:
        // Validation of correct data type
        if (args is List<String>) {
          return MaterialPageRoute(
            builder: (_) => Dashboard(),
          );
        }
      /* case RoutePath.TOTAL_LEAD_VIEW_ALL:
        // Validation of correct data type
       // if (args is List<String>) {
        final Map map = settings.arguments as Map<dynamic, dynamic>;
        //int? selectIndex = leadTabIndex;
     //hideappbar: true, getAccess: getAccess
          return MaterialPageRoute(
            builder: (_) => LeadDetailTab(
                selectIndex: leadTabIndex, hideappbar: true, getAccess: getAccess),
                //LeadDetailTab(selectIndex,),
          );
       // }*/
      default:
        return null;
    }
  }

  static Future pushName(String routeName, {Object? arguments}) async {
    return NavigateService.pushNamedRoute(routeName, arguments: arguments);
  }

  static bool canRoutePop() {
    return NavigateService.canPopRoute();
  }

  static Future popRoute<T>({T? result}) {
    return NavigateService.maybePopRoute(result: result);
  }

  static Future pushRouteUtil<T>(String targetRouteName, {T? result}) {
    return NavigateService.pushNamedAndRemoveUtilRoute(targetRouteName,
        result: result);
  }

  static Future popAndPush<T>(String routeName, {Object? arguments}) {
    return NavigateService.navigator!
        .popAndPushNamed(routeName, arguments: arguments);
  }

  static void popRouteUtil<T>(String? targetRouteName, {T? result}) {
    NavigateService.popUtilRoute((Route<dynamic> route) {
      debugPrint("route -> ${route.settings.name}");
      bool resultData = !route.willHandlePopInternally &&
          route is ModalRoute &&
          route.settings.name == targetRouteName;
      if (result != null) {
        // FxAccountGlobal.getInstance().routeData = result;
      }
      return resultData;
    });
  }
  /*static Route<dynamic> _errorRoute() {
   return MaterialPageRoute(builder: (_) {
     return Scaffold(
       appBar: AppBar(
         title: Text('Error'),
       ),
       body: Center(
         child: Text('ERROR'),
       ),
     );
   });
 }*/
}
