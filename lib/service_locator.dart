// service_locator.dart
import 'package:get_it/get_it.dart';

import 'features/vuelos/data/datasources/flight_remote_datasource.dart';
import 'features/vuelos/data/repositories/flight_repository_impl.dart';
import 'features/vuelos/domain/usecases/get_flights.dart';
import 'features/vuelos/presentation/bloc/flight_bloc.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  // Registra el cliente HTTP

  // Registra el DataSource remoto
  sl.registerLazySingleton<FlightRemoteDataSourceImpl>(
    () => FlightRemoteDataSourceImpl(),
  );

  // Registra el repositorio
  sl.registerLazySingleton<FlightRepositoryImpl>(
    () => FlightRepositoryImpl(sl<FlightRemoteDataSourceImpl>()),
  );

  // Registra el caso de uso GetFlights
  sl.registerLazySingleton<GetFlights>(
    () => GetFlights(sl<FlightRepositoryImpl>()),
  );

  // Registra el Bloc, usando registerFactory para obtener una nueva instancia cada vez
  sl.registerFactory<FlightBloc>(
    () => FlightBloc(sl<GetFlights>()),
  );

  // Puedes registrar aquí otras dependencias de tu proyecto...
}
