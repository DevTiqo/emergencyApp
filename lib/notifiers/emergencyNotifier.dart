import 'dart:collection';
import 'package:emergencyApp/models/emergency.dart';
import 'package:flutter/cupertino.dart';

class EmergencyNotifier with ChangeNotifier {
  List<Emergency> _emergencyList = [];
  Emergency? _currentEmergency;

  UnmodifiableListView<Emergency> get emergencyList =>
      UnmodifiableListView(_emergencyList);

  Emergency get currentEmergency => _currentEmergency!;

  set emergencyList(List<Emergency> emergencyList) {
    _emergencyList = emergencyList;
    notifyListeners();
  }

  set currentEmergency(Emergency emergency) {
    _currentEmergency = emergency;
    notifyListeners();
  }

  addEmergency(Emergency emergency) {
    _emergencyList.insert(0, emergency);
    notifyListeners();
  }

  deleteEmergency(Emergency emergency) {
    _emergencyList.removeWhere((_emergency) => _emergency.id == emergency.id);
    notifyListeners();
  }
}
