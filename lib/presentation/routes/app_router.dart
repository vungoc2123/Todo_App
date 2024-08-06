import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/models/arguments/update_user_arguments.dart';
import 'package:todo/domain/models/response/schedule/event_response.dart';
import 'package:todo/domain/models/arguments/list_task_arguments.dart';
import 'package:todo/presentation/routes/route_name.dart';
import 'package:todo/presentation/screens/create_edit_schedule/create_edit_schedule_cubit.dart';
import 'package:todo/presentation/screens/create_edit_schedule/create_edit_schedule_screen.dart';
import 'package:todo/presentation/screens/home_tab/home_tab.dart';
import 'package:todo/presentation/screens/list_task/bloc/list_task_cubit.dart';
import 'package:todo/presentation/screens/list_task/list_task_screen.dart';
import 'package:todo/presentation/screens/login/cubit/login_cubit.dart';
import 'package:todo/presentation/screens/login/login_screen.dart';
import 'package:todo/presentation/screens/login_email/bloc/login_email_cubit.dart';
import 'package:todo/presentation/screens/login_email/login_email_screen.dart';
import 'package:todo/presentation/screens/setting_general/setting_general_screen.dart';
import 'package:todo/presentation/screens/signup/bloc/signup_cubit.dart';
import 'package:todo/presentation/screens/signup/signup.dart';
import 'package:todo/presentation/screens/update_user/bloc/update_user_cubit.dart';
import 'package:todo/presentation/screens/update_user/update_user_screen.dart';

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
      case RouteName.createEditSchedule:
        routeWidget = BlocProvider(
          create: (_) => CreateEditScheduleCubit(),
          child: EditSchedule(
            event: arguments != null ? arguments as EventResponse : null,
          ),
        );
      case RouteName.updateUser:
        routeWidget = BlocProvider(
          create: (_) => UpdateUserCubit(),
          child: UpdateUserScreen(
            argument: arguments as UserArguments,
          ),
        );
        break;
      case RouteName.login:
        routeWidget = BlocProvider(
          create: (_) => LoginCubit(),
          child: const LoginScreen(),
        );
        break;
      case RouteName.listTask:
        routeWidget = BlocProvider(
            create: (context) => ListTaskCubit(),
            child: ListTaskScreen(
              argument: arguments as ListTaskArguments,
            ));
        break;
      case RouteName.settingGeneral:
        routeWidget = const SettingGeneralScreen();
        break;
      default:
        routeWidget = initialWidget;
        break;
    }

    return MaterialPageRoute(
        builder: (_) => routeWidget, settings: routeSettings);
  }
}
