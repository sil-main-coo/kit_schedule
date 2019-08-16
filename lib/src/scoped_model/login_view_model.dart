
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:schedule/src/enums/view_state.dart';
import 'package:schedule/src/models/data.dart';
import 'package:schedule/src/models/lesson.dart';
import 'package:schedule/src/models/schedule.dart';
import 'package:schedule/src/service/web_service.dart';
import 'package:schedule/src/utils/lesson_convert.dart';

import '../../service_locator.dart';
import 'base_model.dart';

class LoginViewModel extends BaseModel {
  WebService _service = locator<WebService>();
  int _notificationViewVisible = -1;
  final storage = new FlutterSecureStorage();
  List<int> _checkValids = new List();

  List<int> get checkValids => _checkValids;

  set checkValids(List<int> value) {
    _checkValids = value;
    notifyListeners();
  }

  int get notificationViewVisible => _notificationViewVisible;

  set notificationViewVisible(int value) {
    _notificationViewVisible = value;
    notifyListeners();
  }

  WebService get service => _service;

  set service(WebService value) {
    _service = value;
    notifyListeners();
  }

  Future fetchScheduleData(String account, String password) async {
    setState(ViewState.Busy);
    notificationViewVisible = 0;
    notifyListeners();
    var data = await service.fetchSchudeleData(account, password);
    notificationViewVisible = data;
    if (notificationViewVisible == -1) {
      setState(ViewState.NoDataAvailable);
    } else if (notificationViewVisible == 0) {
      setState(ViewState.Error);
    } else {
      setState(ViewState.Success);
    }

  }

  bool checkValidationForm(String account, String password) {
    checkValids.clear();
    bool flag = true;
    if(account.isEmpty || account.length != 8) {
      checkValids.add(1);
      flag = false;

    } else {
      Pattern pattern = '([a-zA-Z]{2})([0-9]{6})';
      RegExp regex = new RegExp(pattern);
      if (!regex.hasMatch(account)){
        checkValids.add(1);
        flag = false;
      }
    }
    if (password.isEmpty) {
      checkValids.add(2);
      flag = false;
    }
    notifyListeners();
    return flag;
  }

}