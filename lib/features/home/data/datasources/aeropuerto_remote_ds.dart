import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/aeropuerto_model.dart';

abstract class AeropuertosRemoteDataSource {
  Future<List<AeropuertoModel>> getAeropuertos();
}

class AeropuertosRemoteDataSourceImpl implements AeropuertosRemoteDataSource {
  final String apiUrl = "https://api.tuaeropuerto.com/aeropuertos";

  @override
  Future<List<AeropuertoModel>> getAeropuertos() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => AeropuertoModel.fromJson(json)).toList();
    } else {
      throw Exception("Error obteniendo aeropuertos");
    }
  }
}
