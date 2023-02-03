import 'package:jbaza/jbaza.dart';
import 'package:wisdom/core/db/db_helper.dart';
import 'package:wisdom/core/db/preference_helper.dart';
import 'package:wisdom/core/services/custom_client.dart';
import 'package:wisdom/core/services/local_notification_service.dart';
import 'package:wisdom/core/utils/word_mapper.dart';
import 'package:wisdom/data/repositories/category_repository_impl.dart';
import 'package:wisdom/data/repositories/home_repository_impl.dart';
import 'package:wisdom/data/repositories/search_repository_impl.dart';
import 'package:wisdom/data/repositories/word_entity_repository_impl.dart';
import 'package:wisdom/data/viewmodel/local_viewmodel.dart';
import 'package:wisdom/domain/repositories/category_repository.dart';
import 'package:wisdom/domain/repositories/home_repository.dart';
import 'package:wisdom/domain/repositories/search_repository.dart';
import 'package:wisdom/domain/repositories/word_entity_repository.dart';

final locator = JbazaLocator.instance;

void setupLocator() {
  locator.registerSingleton<CustomClient>(CustomClient());
  locator.registerSingleton<NetWorkChecker>(NetWorkChecker());
  locator.registerSingleton<WordMapper>(WordMapper());
  locator.registerSingleton<LocalNotificationService>(LocalNotificationService());
  locator.registerSingleton<DBHelper>(DBHelper(locator.get()));
  locator.registerSingleton<SharedPreferenceHelper>(SharedPreferenceHelper());
  locator.registerSingleton<LocalViewModel>(LocalViewModel(context: null, preferenceHelper: locator.get()));
  locator.registerLazySingleton<WordEntityRepository>(
      () => WordEntityRepositoryImpl(client: locator.get(), dbHelper: locator.get()));
  locator.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(locator.get()));
  locator.registerLazySingleton<CategoryRepository>(() => CategoryRepositoryImpl(locator.get()));
  locator.registerLazySingleton<SearchRepository>(() => SearchRepositoryImpl(locator.get(), locator.get()));
}
