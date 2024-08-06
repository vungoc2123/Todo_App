import 'package:todo/application/constants/app_animation.dart';
import 'package:todo/application/enums/storages_key.dart';
import 'package:todo/data/data_sources/storages/shared_preferences/shared_preferences_helper.dart';
import 'package:todo/di.dart';

class AnimationFocusConfig {
  static String currentAnimationPath = AppAnimations.animations[0];

  static final sharePreferences = getIt<SharedPreferencesHelper>();

  static Future getCurrentAnimation() async {
    final path = await sharePreferences.getStringValue(StoragesKey.animation);
    if (path != "") {
      currentAnimationPath = AppAnimations.animations
          .firstWhere((element) => element == path);
    }
  }

  static Future<void> setCurrentIconLoading(String path) async {
    await sharePreferences.setStringValue(StoragesKey.animation, path);
  }
}