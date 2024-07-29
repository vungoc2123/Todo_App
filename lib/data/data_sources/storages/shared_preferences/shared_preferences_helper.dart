import 'package:todo/application/enums/storages_key.dart';
import 'package:todo/data/data_sources/storages/shared_preferences/base_shared_preferences.dart';

class SharedPreferencesHelper extends BaseSharedPreferences {
  Future<void> setAccessToken(String accessToken) async {
    await super.setStringValue(StoragesKey.accessToken, accessToken);
  }

  Future<String> getAccessToken() async {
    return await super.getStringValue(StoragesKey.accessToken);
  }

  Future<void> removeAccessToken() async {
    await super.removeByKey(StoragesKey.accessToken);
  }
}
