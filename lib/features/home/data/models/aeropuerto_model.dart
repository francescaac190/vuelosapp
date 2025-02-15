import '../../domain/entities/aeropuerto.dart';

class AeropuertoModel extends Aeropuerto {
  AeropuertoModel({
    required int id,
    required String nombre,
    required String iata,
    required int idCiudad,
    required String concatenacion,
  }) : super(
          id: id,
          nombre: nombre,
          iata: iata,
          idCiudad: idCiudad,
          concatenacion: concatenacion,
        );

  factory AeropuertoModel.fromJson(Map<String, dynamic> json) {
    return AeropuertoModel(
      id: json["id"],
      nombre: json["nombre"],
      iata: json["iata"],
      idCiudad: json["id_ciudad"],
      concatenacion: json["concatenacion"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nombre": nombre,
      "iata": iata,
      "id_ciudad": idCiudad,
      "concatenacion": concatenacion,
    };
  }
}
