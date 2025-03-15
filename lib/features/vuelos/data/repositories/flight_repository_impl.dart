import '../../domain/entities/flight_entity.dart';
import '../../domain/repositories/flight_repository.dart';
import '../datasources/flight_remote_datasource.dart';

class FlightRepositoryImpl implements FlightRepository {
  final FlightRemoteDataSource remoteDataSource;

  FlightRepositoryImpl(this.remoteDataSource);

  @override
  Future<FlightEntity> getFlights({
    required String adultos,
    required String ninos,
    required String bebes,
    required String origen,
    required String destino,
    required String fechaIda,
    required String fechaVuelta,
    required String tipoVuelo,
  }) async {
    final flightModels = await remoteDataSource.getFlightsFromApi(
      adultos: adultos,
      ninos: ninos,
      bebes: bebes,
      origen: origen,
      destino: destino,
      fechaIda: fechaIda,
      fechaVuelta: fechaVuelta,
      tipoVuelo: tipoVuelo,
    );
    return flightModels; // Retorna lista de FlightEntity
  }
}
