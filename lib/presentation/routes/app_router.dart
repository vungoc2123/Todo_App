import 'package:flutter/material.dart';
import 'package:todo/presentation/screens/home_tab/home_tab.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    Widget initialWidget = HomeTab(arguments: HomeTabArguments(index: 0));
    Widget routeWidget = initialWidget;
    final arguments = routeSettings.arguments;

    switch (routeSettings.name) {
      default:
        routeWidget = initialWidget;
        break;
    }

    return MaterialPageRoute(builder: (_) => routeWidget, settings: routeSettings);
  }
}
