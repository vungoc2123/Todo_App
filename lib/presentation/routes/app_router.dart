import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/presentation/routes/route_name.dart';
import 'package:todo/presentation/screens/home_tab/home_tab.dart';
import 'package:todo/presentation/screens/login/cubit/login_cubit.dart';
import 'package:todo/presentation/screens/login/login_screen.dart';
import 'package:todo/presentation/screens/login_email/bloc/login_email_cubit.dart';
import 'package:todo/presentation/screens/login_email/login_email_screen.dart';
import 'package:todo/presentation/screens/signup/bloc/signup_cubit.dart';
import 'package:todo/presentation/screens/signup/signup.dart';

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
      case RouteName.loginEmail:
        routeWidget = BlocProvider(
          create: (context) => LoginEmailCubit(),
            child: const LoginEmailScreen());
      case RouteName.signup:
        routeWidget = BlocProvider(
          create: (_) => SignUpCubit(),
          child: const SignUpScreen(),
        );
      case RouteName.login:
        routeWidget = BlocProvider(
          create: (_) => LoginCubit(),
          child: const LoginScreen(),
        );
        break;
      default:
        routeWidget = initialWidget;
        break;
    }

    return MaterialPageRoute(builder: (_) => routeWidget, settings: routeSettings);
  }
}
