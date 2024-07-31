import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:todo/data/data_sources/storages/shared_preferences/shared_preferences_helper.dart';
import 'package:todo/data/repositories/schedule/schedule_repository_impl.dart';
import 'package:todo/domain/repositories/schedule/schedule_repository.dart';
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
  getIt.registerLazySingleton<SharedPreferencesHelper>(
      () => SharedPreferencesHelper());
  //dependence

  //repository
  getIt.registerLazySingleton<ScheduleRepository>(
      () => ScheduleRepositoryImpl());
  //bloc
}
