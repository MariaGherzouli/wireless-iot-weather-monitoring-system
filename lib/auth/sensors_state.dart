import 'package:flutter/cupertino.dart';

class SensorsState with ChangeNotifier {
  bool _isTemperatureSensorActive = false;
  bool _isHumiditySensorActive = false;

  bool get isTemperatureSensorActive => _isTemperatureSensorActive;
  bool get isHumiditySensorActive => _isHumiditySensorActive;

  void toggleTemperatureSensor(bool value) {
    _isTemperatureSensorActive = value;
    notifyListeners();
  }

  void toggleHumiditySensor(bool value) {
    _isHumiditySensorActive = value;
    notifyListeners();
  }
}
