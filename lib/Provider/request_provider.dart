import 'package:code/Models/pharmacy_object.dart';
import 'package:flutter/material.dart';
import 'package:code/Models/itinerary_object.dart';

class RequestProvider extends ChangeNotifier {
  List<PharmacyObj> _pharmaAcceptList = [];
  List<PharmacyObj> get pharmaAcceptList => _pharmaAcceptList;

  String? _perscriptionId;
  String? get perscriptionId => _perscriptionId;

  PharmacyObj? _selectedPharmacy;
  PharmacyObj? get selectedPharmacy => _selectedPharmacy;

  static ItineraryObj? _selectedItinerary;
  ItineraryObj? get getItinerary => _selectedItinerary;

  bool _loading = false;

  bool get isLoading => _loading;

  void setItinerary(ItineraryObj itinerary) {
    _selectedItinerary = itinerary;
    notifyListeners();
  }

  void setPharmacy(PharmacyObj pharma) {
    _selectedPharmacy = pharma;
    notifyListeners();
  }

  void setLoading(bool state) {
    _loading = state;
    notifyListeners();
  }

  void addPharma(PharmacyObj pharma, String pid) {
    _perscriptionId ??= pid;
    _pharmaAcceptList.add(pharma);
    _selectedPharmacy = null;
    notifyListeners();
  }

  void clearPharmaList() {
    _pharmaAcceptList.clear();
    notifyListeners();
  }

  void clearItinerary() {
    _selectedItinerary = null;
    _perscriptionId = null;
    notifyListeners();
  }
}
