class FlightEntity {
  int? estado;
  String? message;
  List<Dato>? datos;

  FlightEntity({
    this.estado,
    this.message,
    this.datos,
  });
}

class Dato {
  final List<Vuelos> ida;
  final List<Vuelos>? vuelta;
  final String totalAmount;
  var totalAmountFee;
  final String? totalCurrency;
  final int? fee;
  final String identificador;
  final String gds;
  final String puntos;
  var factor;
  final int? estado;
  var idUsuarioInterno;
  final int? sucursal;
  var fm;

  Dato({
    required this.ida,
    required this.vuelta,
    required this.totalAmount,
    required this.totalAmountFee,
    required this.fee,
    required this.identificador,
    required this.totalCurrency,
    required this.gds,
    required this.puntos,
    required this.factor,
    required this.estado,
    required this.idUsuarioInterno,
    required this.sucursal,
    required this.fm,
  });
}

class Vuelos {
  final int segment;
  final int leg;
  final String arrivalAirport;
  final String arrivalCiudad;
  final String arrivalAeropuerto;
  final String arrivalChangeDayIndicator;
  final String arrivalDate;
  final String arrivalTime;
  final String mesArrival;
  final String arrivalDateOfWeekName;
  final String carrierReferenceId;
  final String logoCarrier;
  final String nameCarrier;
  final String departureAirport;
  final String departureCiudad;
  final String? departureAeropuerto;
  final String departureDate;
  final String mesDeparture;
  final String departureDateOfWeekName;
  final String departureTime;
  final String flightNumber;
  final String flightStops;
  final String flightTime;
  final String flightType;
  final int order;
  final String equipment;
  final String vuelosClass;
  final String lugresDisponibles;
  final String equipaje;
  final String? aeropuertoOrigenAeropuertoV;

  Vuelos({
    required this.segment,
    required this.leg,
    required this.arrivalAirport,
    required this.arrivalCiudad,
    required this.arrivalAeropuerto,
    required this.arrivalChangeDayIndicator,
    required this.arrivalDate,
    required this.arrivalTime,
    required this.mesArrival,
    required this.arrivalDateOfWeekName,
    required this.carrierReferenceId,
    required this.logoCarrier,
    required this.nameCarrier,
    required this.departureAirport,
    required this.departureCiudad,
    this.departureAeropuerto,
    required this.departureDate,
    required this.mesDeparture,
    required this.departureDateOfWeekName,
    required this.departureTime,
    required this.flightNumber,
    required this.flightStops,
    required this.flightTime,
    required this.flightType,
    required this.order,
    required this.equipment,
    required this.vuelosClass,
    required this.lugresDisponibles,
    required this.equipaje,
    this.aeropuertoOrigenAeropuertoV,
  });
}
