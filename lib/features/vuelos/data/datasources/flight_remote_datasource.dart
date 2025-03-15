// data/datasources/flight_remote_data_source.dart
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../../core/config/app_config.dart';
import '../models/flight_model.dart';

abstract class FlightRemoteDataSource {
  Future<FlightModel> getFlightsFromApi({
    required String adultos,
    required String ninos,
    required String bebes,
    required String origen,
    required String destino,
    required String fechaIda,
    required String fechaVuelta,
    required String tipoVuelo,
  });
}

class FlightRemoteDataSourceImpl implements FlightRemoteDataSource {
  @override
  Future<FlightModel> getFlightsFromApi({
    required String adultos,
    required String ninos,
    required String bebes,
    required String origen,
    required String destino,
    required String fechaIda,
    required String fechaVuelta,
    required String tipoVuelo,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('apiToken');

    Map requestBody = {
      "adultos": adultos,
      "senior": ninos,
      "infante": bebes,
      "menor": "0",
      "origen": origen,
      "destino": destino,
      "fecha_ida": fechaIda,
      "fecha_vuelta": fechaVuelta,
      "tipo_busqueda": tipoVuelo,
      "fechaFexible": "0",
      "vuelos_directos": "0",
      "vuelos_incluyenequipaje": "0",
      "tipo_cabina": "",
      "aerolinea": "",
      "hora_salida": "",
      "hora_regreso": "",
      "id_session": ""
    };

    final response = await http.post(
      Uri.parse('${AppConfig.baseurl}get-disponibilida_v3'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(requestBody),
    );
    // print(requestBody);
    // print(response.body);

    if (response.statusCode == 200) {
      final decoded = FlightModel.fromJson(jsonDecode(response.body));
      if (decoded.datos!.isEmpty) {
        log(decoded.datos!.first.gds);
      }
      return decoded;
    } else {
      log('hay algo mal');

      throw Exception('Error al obtener vuelos');
    }
  }
}
