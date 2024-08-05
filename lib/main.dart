import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:todo/application/configs/icon_loading_config.dart';
import 'package:todo/application/configs/theme_config.dart';
import 'package:todo/di.dart';
import 'package:todo/presentation/screens/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  configureDependencies(); // init DI
  await EasyLocalization.ensureInitialized(); // init localization

  await ThemeConfig.getCurrentTheme();
  await IconLoadingConfig.getCurrentIconLoading();
  // await EnvConfigs.init();
  // ApiClientProvider.init(); // init api client

  runApp(EasyLocalization(
    supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
    path: 'assets/translations',
    fallbackLocale: const Locale('vi', 'VN'),
    startLocale: const Locale('vi', 'VN'),
    child: const MyApp(),
  ));
}