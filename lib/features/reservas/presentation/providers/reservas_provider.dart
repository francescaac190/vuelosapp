import 'package:flutter/material.dart';

class ReservasProvider extends ChangeNotifier {
  int _indexSegmentSelected = 0; // 0 = Emitidos, 1 = Reservas
  bool _isLoading = true;
  List<dynamic> _tickets = [];
  List<dynamic> _reservas = [];

  int get indexSegmentSelected => _indexSegmentSelected;
  bool get isLoading => _isLoading;
  List<dynamic> get tickets => _tickets;
  List<dynamic> get reservas => _reservas;

  void setSegmentIndex(int index) {
    _indexSegmentSelected = index;
    _fetchData();
    notifyListeners();
  }

  Future<void> _fetchData() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(
        const Duration(seconds: 2)); // Simula la carga de datos

    if (_indexSegmentSelected == 0) {
      _tickets = ["Ticket 1", "Ticket 2", "Ticket 3"];
    } else {
      _reservas = ["Reserva 1", "Reserva 2", "Reserva 3"];
    }

    _isLoading = false;
    notifyListeners();
  }
}
