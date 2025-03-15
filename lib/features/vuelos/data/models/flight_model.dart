// data/models/flight_model.dart

import '../../domain/entities/flight_entity.dart';

class FlightModel extends FlightEntity {
  FlightModel({
    int? estado,
    String? message,
    List<DatoModel>? datos,
  }) : super(
          estado: estado,
          message: message,
          datos: datos,
        );

  factory FlightModel.fromJson(Map<String, dynamic> json) {
    return FlightModel(
      estado: json['estado'] is int
          ? json['estado']
          : int.tryParse(json['estado']?.toString() ?? ''),
      message: json['message']?.toString(),
      datos: json['datos'] != null
          ? List<DatoModel>.from(
              json['datos'].map((dato) => DatoModel.fromJson(dato)))
          : [],
    );
  }
}

class DatoModel extends Dato {
  DatoModel({
    required List<VuelosModel> ida,
    List<VuelosModel>? vuelta,
    required String totalAmount,
    required dynamic totalAmountFee,
    required int? fee,
    required String identificador,
    required String totalCurrency,
    required String gds,
    required String puntos,
    required dynamic factor,
    required int? estado,
    required dynamic idUsuarioInterno,
    required int? sucursal,
    required dynamic fm,
  }) : super(
          ida: ida,
          vuelta: vuelta,
          totalAmount: totalAmount,
          totalAmountFee: totalAmountFee,
          fee: fee,
          identificador: identificador,
          totalCurrency: totalCurrency,
          gds: gds,
          puntos: puntos,
          factor: factor,
          estado: estado,
          idUsuarioInterno: idUsuarioInterno,
          sucursal: sucursal,
          fm: fm,
        );

  factory DatoModel.fromJson(Map<String, dynamic> json) {
    return DatoModel(
      ida: json['vuelos_ida'] != null
          ? List<VuelosModel>.from(
              json['vuelos_ida'].map((leg) => VuelosModel.fromJson(leg)))
          : [],
      vuelta: json['vuelos_vuelta'] != null
          ? List<VuelosModel>.from(
              json['vuelos_vuelta'].map((leg) => VuelosModel.fromJson(leg)))
          : [],
      totalAmount: json['total_amount'].toString(),
      totalAmountFee: json['total_amount_fee'],
      totalCurrency: json['total_currency']?.toString() ?? '',
      gds: json['gds']?.toString() ?? '',
      puntos: json['puntos']?.toString() ?? '',
      factor: json['factor'] ?? 0,
      estado: json['estado'] ?? 0,
      idUsuarioInterno: json['id_usuario_interno'],
      fee: json["fee"] ?? 0,
      fm: json["fm"] ?? 0,
      identificador: json['identificador']?.toString() ?? '',
      sucursal: json['sucursal'] ?? 0,
    );
  }
}

class VuelosModel extends Vuelos {
  VuelosModel({
    required int segment,
    required int leg,
    required String arrivalAirport,
    required String arrivalCiudad,
    required String arrivalAeropuerto,
    required String arrivalChangeDayIndicator,
    required String arrivalDate,
    required String arrivalTime,
    required String mesArrival,
    required String arrivalDateOfWeekName,
    required String carrierReferenceId,
    required String logoCarrier,
    required String nameCarrier,
    required String departureAirport,
    required String departureCiudad,
    String? departureAeropuerto,
    required String departureDate,
    required String mesDeparture,
    required String departureDateOfWeekName,
    required String departureTime,
    required String flightNumber,
    required String flightStops,
    required String flightTime,
    required String flightType,
    required int order,
    required String equipment,
    required String vuelosClass,
    required String lugresDisponibles,
    required String equipaje,
    String? aeropuertoOrigenAeropuertoV,
  }) : super(
          segment: segment,
          leg: leg,
          arrivalAirport: arrivalAirport,
          arrivalCiudad: arrivalCiudad,
          arrivalAeropuerto: arrivalAeropuerto,
          arrivalChangeDayIndicator: arrivalChangeDayIndicator,
          arrivalDate: arrivalDate,
          arrivalTime: arrivalTime,
          mesArrival: mesArrival,
          arrivalDateOfWeekName: arrivalDateOfWeekName,
          carrierReferenceId: carrierReferenceId,
          logoCarrier: logoCarrier,
          nameCarrier: nameCarrier,
          departureAirport: departureAirport,
          departureCiudad: departureCiudad,
          departureAeropuerto: departureAeropuerto,
          departureDate: departureDate,
          mesDeparture: mesDeparture,
          departureDateOfWeekName: departureDateOfWeekName,
          departureTime: departureTime,
          flightNumber: flightNumber,
          flightStops: flightStops,
          flightTime: flightTime,
          flightType: flightType,
          order: order,
          equipment: equipment,
          vuelosClass: vuelosClass,
          lugresDisponibles: lugresDisponibles,
          equipaje: equipaje,
          aeropuertoOrigenAeropuertoV: aeropuertoOrigenAeropuertoV,
        );

  factory VuelosModel.fromJson(Map<String, dynamic> json) {
    return VuelosModel(
      segment: json['segment'] is int
          ? json['segment']
          : int.tryParse(json['segment']?.toString() ?? '') ?? 0,
      leg: json['leg'] is int
          ? json['leg']
          : int.tryParse(json['leg']?.toString() ?? '') ?? 0,
      arrivalAirport: json['arrival_airport']?.toString() ?? '',
      arrivalCiudad: json['arrival_ciudad']?.toString() ?? '',
      arrivalAeropuerto: json['arrival_aeropuerto']?.toString() ?? '',
      arrivalChangeDayIndicator:
          json['arrival_change_day_indicator']?.toString() ?? '',
      arrivalDate: json['arrival_date']?.toString() ?? '',
      arrivalTime: json['arrival_time']?.toString() ?? '',
      mesArrival: json['mes_arrival']?.toString() ?? '',
      arrivalDateOfWeekName:
          json['arrival_date_of_week_name']?.toString() ?? '',
      carrierReferenceId: json['carrier_reference_id']?.toString() ?? '',
      logoCarrier: json['logo_carrier']?.toString() ?? '',
      nameCarrier: json['name_carrier']?.toString() ?? '',
      departureAirport: json['departure_airport']?.toString() ?? '',
      departureCiudad: json['departure_ciudad']?.toString() ?? '',
      departureAeropuerto: json['departure_aeropuerto']?.toString(),
      departureDate: json['departure_date']?.toString() ?? '',
      mesDeparture: json['mes_departure']?.toString() ?? '',
      departureDateOfWeekName:
          json['departure_date_of_week_name']?.toString() ?? '',
      departureTime: json['departure_time']?.toString() ?? '',
      flightNumber: json['flight_number']?.toString() ?? '',
      flightStops: json['flight_stops']?.toString() ?? '',
      flightTime: json['flight_time']?.toString() ?? '',
      flightType: json['flight_type']?.toString() ?? '',
      order: json['order'] is int
          ? json['order']
          : int.tryParse(json['order']?.toString() ?? '') ?? 0,
      equipment: json['equipment']?.toString() ?? '',
      vuelosClass: json['class']?.toString() ?? '',
      lugresDisponibles: json['lugres_disponibles']?.toString() ?? '',
      equipaje: json['equipaje']?.toString() ?? '',
      aeropuertoOrigenAeropuertoV:
          json['aeropuerto_origen_aeropuerto_v']?.toString(),
    );
  }
}
