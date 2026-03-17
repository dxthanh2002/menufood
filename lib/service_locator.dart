import 'package:get_it/get_it.dart';
import 'services/api_service.dart';
import 'services/app_service.dart';
import 'repositories/auth_repository.dart';

final locator = GetIt.instance;

void setupLocator() {
  // Services
  locator.registerLazySingleton(() => ApiService());
  locator.registerLazySingleton(() => AppService());

  // Repositories
  locator.registerLazySingleton(() => AuthRepository());
}
