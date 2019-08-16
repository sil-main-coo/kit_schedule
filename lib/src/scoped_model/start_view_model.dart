import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:schedule/src/enums/view_state.dart';
import 'package:schedule/src/service/web_service.dart';

import '../../service_locator.dart';
import 'base_model.dart';
import 'login_view_model.dart';

class StartViewModel extends LoginViewModel {
  WebService _service = locator<WebService>();
  final storage = new FlutterSecureStorage();
  String _account;
  String _password;

  String get password => _password;

  set password(String value) {
    _password = value;
    notifyListeners();
  }

  String get account => _account;

  set account(String value) {
    _account = value;
    notifyListeners();
  }

  WebService get service => _service;

  set service(WebService value) {
    _service = value;
    notifyListeners();
  }

  Future<bool> checkStorage() async {
    setState(ViewState.Busy);
    notificationViewVisible = 0;
    account = await storage.read(key: 'account');
    password = await storage.read(key: 'password');
    if (account == null || password ==  null) {
      setState(ViewState.NoDataAvailable);
      notificationViewVisible = 2;
      return false;
    }
    bool checkConnect = await fetchScheduleData(account, password);
    if (checkConnect == false) {
      notificationViewVisible = 1;
      setState(ViewState.Error);
      return false;
    }
    setState(ViewState.DataFetched);
    notificationViewVisible = -1;
    return true;
  }

}