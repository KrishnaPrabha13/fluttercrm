// Flutter imports:
import 'package:flutter/material.dart';

class NavigateService {
  static GlobalKey<NavigatorState> key =
  GlobalKey(debugLabel: 'unified_navigate_key');

  static NavigatorState? get navigator => key.currentState;

  static BuildContext get context => navigator!.overlay!.context;

  static Future pushNamedRoute(String routeName,
      {BuildContext? context, Object? arguments}) async {
    return (context != null ? Navigator.of(context) : navigator)!
        .pushNamed(routeName, arguments: arguments);
  }

  static bool canPopRoute({BuildContext? context}) =>
      (context != null ? Navigator.of(context) : navigator)!.canPop();

  static Future maybePopRoute<T>({BuildContext? context, T? result}) {
    return (context != null ? Navigator.of(context) : navigator)!
        .maybePop(result);
  }

  static Future pushNamedAndRemoveUtilRoute<T>(String targetRouteName,
      {BuildContext? context, T? result}) {
    return (context != null ? Navigator.of(context) : navigator)!
        .pushNamedAndRemoveUntil(
        targetRouteName, (Route<dynamic> route) => false,
        arguments: result);
  }

  static Future pushReplacementNamed<T>(String targetRouteName,
      {BuildContext? context, T? arguments}) {
    return (context != null ? Navigator.of(context) : navigator)!
        .pushReplacementNamed(targetRouteName, arguments: arguments);
  }

  static void popUtilRoute<T>(RoutePredicate routePredicate,
      {BuildContext? context}) {
    (context != null ? Navigator.of(context) : navigator)!
        .popUntil(routePredicate);
  }
}
