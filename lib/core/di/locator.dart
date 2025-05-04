import 'package:flutterapp/core/network/api_services.dart';
import 'package:flutterapp/domain/repositories/auth_repository.dart';
import 'package:get_it/get_it.dart';


final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => ApiService());
  locator.registerLazySingleton(() => AuthRepository(locator()));
}
