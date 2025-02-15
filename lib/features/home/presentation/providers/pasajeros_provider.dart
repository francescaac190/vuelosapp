import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PasajerosProvider extends ChangeNotifier {
  int _adultos = 1;
  int _ninos = 0;
  int _bebes = 0;
  static const int maxPasajeros = 9;

  // Getters
  int get adultos => _adultos;
  int get ninos => _ninos;
  int get bebes => _bebes;
  int get totalPasajeros => _adultos + _ninos + _bebes;
  int get remainingSeats => maxPasajeros - totalPasajeros;

  // Cargar datos desde SharedPreferences
  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _adultos = prefs.getInt("Adultos") ?? 1;
    _ninos = prefs.getInt("Infantes") ?? 0;
    _bebes = prefs.getInt("Bebes") ?? 0;
    notifyListeners();
  }

  // Guardar datos en SharedPreferences
  Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("Adultos", _adultos);
    prefs.setInt("Infantes", _ninos);
    prefs.setInt("Bebes", _bebes);
  }

  // Métodos para cambiar valores
  void setAdultos(int value) {
    if (totalPasajeros < maxPasajeros || value < _adultos) {
      _adultos = value;
      saveData();
      notifyListeners();
    }
  }

  void setNinos(int value) {
    if (totalPasajeros < maxPasajeros || value < _ninos) {
      _ninos = value;
      saveData();
      notifyListeners();
    }
  }

  void setBebes(int value) {
    if (totalPasajeros < maxPasajeros || value < _bebes) {
      _bebes = value;
      saveData();
      notifyListeners();
    }
  }

  int getTotalPassengers() {
    return _adultos + _ninos + _bebes;
  }

  int getRemainingSeats() {
    return 9 - getTotalPassengers();
  }
}
