import 'package:schedule/src/enums/view_state.dart';
import 'package:schedule/src/service/web_service.dart';

import 'base_model.dart';

class DrawerMenuModel extends BaseModel {
  bool _switchOn = false;

  bool get switchOn => _switchOn;

  set switchOn(bool value) {
    _switchOn = value;
    notifyListeners();
  }

  Future checkSwitchOn() async {
    setState(ViewState.Busy);
    WebService service = new WebService();
    String notification = await service.retrieveData("notification");
    if (notification == "true")
      switchOn = true;
    else
      switchOn = false;
    setState(ViewState.Success);
  }
}