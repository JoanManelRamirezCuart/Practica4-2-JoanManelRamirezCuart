import 'package:flutter/cupertino.dart';

class UIProvider extends ChangeNotifier {
  int _slectedMenuOpt = 1;

  int get slectedMenuOpt {
    return this._slectedMenuOpt;
  }

  set slectedMenuOpt(int index) {
    this._slectedMenuOpt = index;
    notifyListeners();
  }
}
