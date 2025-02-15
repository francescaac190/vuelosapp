import '../../domain/entities/aeropuerto.dart';
import '../../domain/repositories/aeropuerto_repositories.dart';
import '../datasources/aeropuerto_local_ds.dart';

class AeropuertosRepositoryImpl implements AeropuertosRepository {
  final AeropuertosLocalDataSource localDataSource;

  AeropuertosRepositoryImpl(this.localDataSource);

  @override
  Future<List<Aeropuerto>> getAeropuertos() async {
    return await localDataSource.getAeropuertos();
  }
}
