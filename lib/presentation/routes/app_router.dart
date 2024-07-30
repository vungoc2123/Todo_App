import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/presentation/routes/route_name.dart';
import 'package:todo/presentation/screens/home_tab/home_tab.dart';
import 'package:todo/presentation/screens/login/cubit/login_cubit.dart';
import 'package:todo/presentation/screens/login/login_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    Widget initialWidget = BlocProvider(
      create: (_) => LoginCubit(),
      child: const LoginScreen(),
    );
    Widget routeWidget = initialWidget;
    final arguments = routeSettings.arguments;

    switch (routeSettings.name) {
      case RouteName.homeTab:
        routeWidget = HomeTab(
          arguments: arguments as HomeTabArguments,
        );
        break;
      default:
        routeWidget = initialWidget;
        break;
    }

    return MaterialPageRoute(builder: (_) => routeWidget, settings: routeSettings);
  }
}
