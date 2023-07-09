import 'package:flutter_application_1/app/routes/navigation_manager.dart';
import 'package:get_it/get_it.dart';

import '../data/network/local/local_network.dart';


final getIt = GetIt.instance;
void setUp() {
  getIt.registerLazySingleton<NavigationManager>(() => NavigationManager());

  getIt.registerLazySingleton<SharedPrefController>(
      () => SharedPrefController());
}
