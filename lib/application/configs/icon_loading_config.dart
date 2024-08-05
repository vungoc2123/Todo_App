import 'package:todo/application/constants/app_icon_loading.dart';
import 'package:todo/application/enums/storages_key.dart';
import 'package:todo/data/data_sources/storages/shared_preferences/shared_preferences_helper.dart';
import 'package:todo/di.dart';

class IconLoadingConfig {
  static AppIconLoadingModel currentIconLoading= MyAppIconLoading.appIconLoadings[0];

  static final sharePreferences = getIt<SharedPreferencesHelper>();

  static Future getCurrentIconLoading() async {
    final iconTitle = await sharePreferences.getStringValue(StoragesKey.iconLoading);
    if (iconTitle != "") {
      currentIconLoading = MyAppIconLoading.appIconLoadings
          .firstWhere((element) => element.title == iconTitle);
    }
  }

  static Future<void> setCurrentIconLoading(AppIconLoadingModel icon) async {
    await sharePreferences.setStringValue(StoragesKey.iconLoading, icon.title);
  }
}
