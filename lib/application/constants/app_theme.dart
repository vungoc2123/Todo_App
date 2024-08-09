import 'package:flutter/material.dart';
import 'package:todo/application/constants/app_colors.dart';

class AppThemeModel {
  final String title;
  final ThemeData themeData;

  const AppThemeModel({required this.title, required this.themeData});

}

class MyAppTheme {
  static final theme1 = ThemeData(
    primaryColor: Colors.blue,
    indicatorColor: Colors.red,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(
      primary: Colors.blue,
      secondary: Colors.amber,
    ),
  );

  static final theme2 = ThemeData(
    primaryColor: Colors.red,
    indicatorColor: Colors.green,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(
      primary: Colors.red,
      secondary: Colors.green,
    ),
  );

  // Thêm các theme khác ở đây
  static final theme3 = ThemeData(
    primaryColor: Colors.purple,
    indicatorColor: Colors.orange,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(
      primary: Colors.purple,
      secondary: Colors.orange,
    ),
  );

  static final theme4 = ThemeData(
    primaryColor: AppColors.yellow,
    indicatorColor: Colors.blueAccent,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(
      primary: Colors.purple,
      secondary: Colors.orange,
    ),
  );

  static final theme5 = ThemeData(
    primaryColor: Colors.green,
    indicatorColor: Colors.red,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(
      primary: Colors.purple,
      secondary: Colors.orange,
    ),
  );

  static final theme6 = ThemeData(
    primaryColor: AppColors.greenA5,
    indicatorColor: Colors.deepOrangeAccent,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(
      primary: Colors.purple,
      secondary: Colors.orange,
    ),
  );

  static final theme7 = ThemeData(
    primaryColor: AppColors.orange,
    indicatorColor: Colors.redAccent,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(
      primary: Colors.purple,
      secondary: Colors.orange,
    ),
  );

  static final themes = [
    AppThemeModel(title: 'Default', themeData: theme1),
    AppThemeModel(title: 'Red', themeData: theme2),
    AppThemeModel(title: 'Purple', themeData: theme3),
    AppThemeModel(title: 'Yellow', themeData: theme4),
    AppThemeModel(title: 'Green', themeData: theme5),
    AppThemeModel(title: 'GreenLight', themeData: theme6),
    AppThemeModel(title: 'Orange', themeData: theme7),
  ];
}
