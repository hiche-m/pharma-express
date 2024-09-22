import 'package:code/Models/pharmacy_object.dart';
import 'package:flutter/material.dart';

class RequestProvider extends ChangeNotifier {
  List<PharmacyObj> _pharmaAcceptList = [];

  List<PharmacyObj> get pharmaAcceptList => _pharmaAcceptList;

  bool _loading = false;

  bool get isLoading => _loading;

  void setLoading(bool state) {
    _loading = state;
    notifyListeners();
  }

  void addPharma(PharmacyObj pharma) {
    _pharmaAcceptList.add(pharma);
    notifyListeners();
  }

  void clearPharmaList() {
    _pharmaAcceptList.clear();
    notifyListeners();
  }
}
