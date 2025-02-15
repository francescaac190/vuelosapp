import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/aeropuerto_model.dart';

abstract class AeropuertosLocalDataSource {
  Future<List<AeropuertoModel>> getAeropuertos();
}

class AeropuertosLocalDataSourceImpl implements AeropuertosLocalDataSource {
  @override
  Future<List<AeropuertoModel>> getAeropuertos() async {
    try {
      final String response =
          await rootBundle.loadString('assets/data/aeropuertos.json');
      final Map<String, dynamic> jsonData = json.decode(response);

      if (!jsonData.containsKey("datos")) {
        throw Exception("El JSON no contiene la clave 'datos'");
      }

      final List<dynamic> aeropuertosJson = jsonData["datos"];
      return aeropuertosJson
          .map((json) => AeropuertoModel.fromJson(json))
          .toList();
    } catch (e) {
      print("Error al cargar JSON de aeropuertos: $e");
      return [];
    }
  }
}
