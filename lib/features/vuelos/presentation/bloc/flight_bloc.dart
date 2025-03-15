import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/flight_entity.dart';
import '../../domain/usecases/get_flights.dart';

/// ---------------------
/// Eventos
/// ---------------------
abstract class FlightEvent extends Equatable {
  const FlightEvent();
  @override
  List<Object?> get props => [];
}

class FetchFlightsEvent extends FlightEvent {
  final String adultos;
  final String bebes;
  final String ninos;
  final String origen;
  final String destino;
  final String fechaIda;
  final String fechaVuelta;
  final String tipoVuelo;

  const FetchFlightsEvent({
    required this.adultos,
    required this.bebes,
    required this.ninos,
    required this.origen,
    required this.destino,
    required this.fechaIda,
    required this.fechaVuelta,
    required this.tipoVuelo,
  });

  @override
  List<Object?> get props => [
        adultos,
        bebes,
        ninos,
        origen,
        destino,
        fechaIda,
        fechaVuelta,
        tipoVuelo
      ];
}

/// ---------------------
/// Estados
/// ---------------------
abstract class FlightState extends Equatable {
  const FlightState();
  @override
  List<Object?> get props => [];
}

class FlightInitial extends FlightState {}

class FlightLoading extends FlightState {}

class FlightLoaded extends FlightState {
  final FlightEntity flightEntity;

  const FlightLoaded(this.flightEntity);
}

class FlightError extends FlightState {
  final String errorMessage;

  const FlightError(this.errorMessage);
}

/// ---------------------
/// Bloc
/// ---------------------
class FlightBloc extends Bloc<FlightEvent, FlightState> {
  final GetFlights getFlightsUseCase;

  FlightBloc(this.getFlightsUseCase) : super(FlightInitial()) {
    on<FetchFlightsEvent>((event, emit) async {
      emit(FlightLoading());

      try {
        final flightEntity = await getFlightsUseCase(
          adultos: event.adultos,
          ninos: event.ninos,
          bebes: event.bebes,
          origen: event.origen,
          destino: event.destino,
          fechaIda: event.fechaIda,
          fechaVuelta: event.fechaVuelta,
          tipoVuelo: event.tipoVuelo,
        );
        emit(FlightLoaded(flightEntity));
      } catch (e) {
        emit(FlightError(e.toString()));
      }
    });
  }
}
