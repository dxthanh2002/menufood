import 'package:get_it/get_it.dart';
import 'features/bottom_navigation/navigation_viewmodel.dart';
import 'services/api_service.dart';
import 'services/app_service.dart';
import 'repositories/auth_repository.dart';

final locator = GetIt.instance;

void setupLocator() {
  // ViewModels
  locator.registerFactory(() => NavigationViewModel());

  // Services
  locator.registerLazySingleton(() => ApiService());
  locator.registerLazySingleton(() => AppService());

  // Repositories
  locator.registerLazySingleton(() => AuthRepository());
}
