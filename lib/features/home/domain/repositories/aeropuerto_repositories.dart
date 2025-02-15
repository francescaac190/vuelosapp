import '../entities/aeropuerto.dart';

abstract class AeropuertosRepository {
  Future<List<Aeropuerto>> getAeropuertos();
}
