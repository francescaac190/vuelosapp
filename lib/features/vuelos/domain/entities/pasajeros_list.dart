class Pasajero {
  final int id;
  final String surname;
  final String name;
  final String foidType;
  final String foidId;
  final DateTime dateOfBirth;

  Pasajero({
    required this.id,
    required this.surname,
    required this.name,
    required this.foidType,
    required this.foidId,
    required this.dateOfBirth,
  });
  factory Pasajero.fromJson(Map<String, dynamic> json) {
    return Pasajero(
      id: json['id'] ?? '',
      surname: json['surname'] ?? '',
      name: json['name'] ?? '',
      foidType: json['foid_type'] ?? '',
      foidId: json['foid_id'] ?? '',
      dateOfBirth: DateTime.parse(json['date_of_birth']),
    );
  }
  // Método para convertir un objeto Pasajero a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'surname': surname,
      'name': name,
      'foid_type': foidType,
      'foid_id': foidId,
      'date_of_birth': dateOfBirth.toIso8601String(),
    };
  }
}

class Reserva {
  final List<Pasajero> adultos;
  final List<Pasajero> menores;
  final List<Pasajero> bebes;

  Reserva({
    required this.adultos,
    required this.menores,
    required this.bebes,
  });
  factory Reserva.fromJson(Map<String, dynamic> json) {
    return Reserva(
      adultos: (json['adultos'] as List<dynamic>)
          .map((item) => Pasajero.fromJson(item))
          .toList(),
      menores: (json['menores'] as List<dynamic>)
          .map((item) => Pasajero.fromJson(item))
          .toList(),
      bebes: (json['bebes'] as List<dynamic>)
          .map((item) => Pasajero.fromJson(item))
          .toList(),
    );
  }
  // Método para convertir un objeto Reserva a JSON
  Map<String, dynamic> toJson() {
    return {
      'adultos': adultos.map((e) => e.toJson()).toList(),
      'menores': menores.map((e) => e.toJson()).toList(),
      'bebes': bebes.map((e) => e.toJson()).toList(),
    };
  }
}
