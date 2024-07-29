import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:todo/data/data_sources/storages/shared_preferences/shared_preferences_helper.dart';
import 'di.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureDependencies() {
  getIt.init();

  // shared preferences
  getIt.registerLazySingleton<SharedPreferencesHelper>(() => SharedPreferencesHelper());
  //dependence

  //repository

  //bloc

}
