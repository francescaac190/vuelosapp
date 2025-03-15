// domain/usecases/get_flights.dart
import '../entities/flight_entity.dart';
import '../repositories/flight_repository.dart';

class GetFlights {
  final FlightRepository repository;

  GetFlights(this.repository);

  Future<FlightEntity> call({
    required String adultos,
    required String ninos,
    required String bebes,
    required String origen,
    required String destino,
    required String fechaIda,
    required String fechaVuelta,
    required String tipoVuelo,
  }) {
    return repository.getFlights(
      adultos: adultos,
      ninos: ninos,
      bebes: bebes,
      origen: origen,
      destino: destino,
      fechaIda: fechaIda,
      fechaVuelta: fechaVuelta,
      tipoVuelo: tipoVuelo,
    );
  }
}
