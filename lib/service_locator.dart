import 'package:get_it/get_it.dart';
import 'package:schedule/src/scoped_model/drawer_menu_model.dart';
import 'package:schedule/src/scoped_model/login_view_model.dart';
import 'package:schedule/src/scoped_model/start_view_model.dart';

import 'src/scoped_model/home_view_model.dart';
import 'src/service/web_service.dart';

GetIt locator = GetIt();

void setupLocator() {
  // register services
  locator.registerLazySingleton<WebService>(() => WebService());

  // register models
  locator.registerFactory<LoginViewModel>(() => LoginViewModel());
  locator.registerFactory<HomeViewModel>(() => HomeViewModel());
  locator.registerFactory<StartViewModel>(() => StartViewModel());
  locator.registerFactory<DrawerMenuModel>(() => DrawerMenuModel());
}