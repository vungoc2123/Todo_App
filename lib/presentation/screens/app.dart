import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/application/configs/theme_config.dart';
import 'package:todo/application/utils/app_utils.dart';
import 'package:todo/application/utils/navigation_utils.dart';
import 'package:todo/presentation/routes/app_router.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(375, 812),
      builder: (_, child) => AdaptiveTheme(
        light: ThemeConfig.currentTheme.themeData,
        dark: ThemeData.dark(useMaterial3: true),
        initial: AdaptiveThemeMode.light,
        builder:(theme, darkTheme)=> MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorObservers: [NavigatorUtils.navigatorObserver],
          navigatorKey: NavigatorUtils.navigatorKey,
          // set property
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          builder: (BuildContext context, Widget? child) => GestureDetector(
            onTap: () {
              AppUtils.dismissKeyboard();
            },
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
              child: child!,
            ),
          ),
          locale: context.locale,
          title: 'Flutter base',
          onGenerateRoute: AppRouter().onGenerateRoute,
        ),
      ),
    );
  }
}