// domain/repositories/flight_repository.dart

import '../entities/flight_entity.dart';

abstract class FlightRepository {
  Future<FlightEntity> getFlights({
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
