import 'package:flutter/material.dart';
import '../../domain/entities/aeropuerto.dart';
import '../../domain/usercases/get_aeropuertos.dart';

class AeropuertosProvider extends ChangeNotifier {
  final GetAeropuertos getAeropuertos;
  List<Aeropuerto> aeropuertos = [];
  bool isLoading = false;

  AeropuertosProvider(this.getAeropuertos) {
    fetchAeropuertos(); // Llamar automáticamente al cargar el Provider
  }

  Future<void> fetchAeropuertos() async {
    isLoading = true;
    notifyListeners();

    try {
      aeropuertos = await getAeropuertos();
      print("Aeropuertos cargados: ${aeropuertos.length}");
    } catch (e) {
      print("Error al cargar aeropuertos: $e");
    }

    isLoading = false;
    notifyListeners();
  }
}
