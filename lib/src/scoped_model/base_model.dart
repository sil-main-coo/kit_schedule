import 'package:schedule/src/enums/view_state.dart';
import 'package:scoped_model/scoped_model.dart';

class BaseModel extends Model {
  ViewState _state;

  ViewState get state => _state;

  void setState(ViewState newState) {
    _state = newState;

    // Notify listeners will only update listeners of state.
    notifyListeners();
  }
}
