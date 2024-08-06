import 'package:todo/application/constants/app_theme.dart';
import 'package:todo/application/enums/storages_key.dart';
import 'package:todo/data/data_sources/storages/shared_preferences/shared_preferences_helper.dart';
import 'package:todo/di.dart';

class ThemeConfig {
  static AppThemeModel currentTheme = MyAppTheme.themes[0];

  static final sharePreferences = getIt<SharedPreferencesHelper>();

  static Future getCurrentTheme() async {
    final themeTitle = await sharePreferences.getStringValue(StoragesKey.theme);
    if (themeTitle != "") {
      currentTheme = MyAppTheme.themes
          .firstWhere((element) => element.title == themeTitle);
    }
  }

  static Future<void> setCurrentTheme(AppThemeModel theme) async {
    await sharePreferences.setStringValue(StoragesKey.theme, theme.title);
  }
}
