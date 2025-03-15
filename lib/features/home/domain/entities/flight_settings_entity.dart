class FlightSetting {
  final String adultos;
  final String ninos;
  final String bebes;
  final String origen;
  final String destino;
  final String fechaSalida;
  final String fechaRegreso;
  final String tipoVuelo;

  FlightSetting({
    required this.adultos,
    required this.ninos,
    required this.bebes,
    required this.origen,
    required this.destino,
    required this.fechaSalida,
    required this.fechaRegreso,
    required this.tipoVuelo,
  });

  @override
  String toString() {
    return 'FlightSetting(adultos: $adultos, ninos: $ninos, bebes: $bebes, '
        'origen: $origen, destino: $destino, fechaSalida: $fechaSalida, '
        'fechaRegreso: $fechaRegreso, tipoVuelo: $tipoVuelo)';
  }
}
