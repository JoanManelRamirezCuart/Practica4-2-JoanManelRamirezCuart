import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show MapType;

class TipeMapProvider extends ChangeNotifier {
  MapType _tipusmapa = MapType.satellite;

  MapType get tipusmapas {
    return this._tipusmapa;
  }

  set tipusmapas(MapType index) {
    this._tipusmapa = index;
    notifyListeners();
  }
}
