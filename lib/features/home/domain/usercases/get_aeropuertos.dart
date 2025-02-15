import '../entities/aeropuerto.dart';
import '../repositories/aeropuerto_repositories.dart';

class GetAeropuertos {
  final AeropuertosRepository repository;

  GetAeropuertos(this.repository);

  Future<List<Aeropuerto>> call() async {
    return await repository.getAeropuertos();
  }
}
