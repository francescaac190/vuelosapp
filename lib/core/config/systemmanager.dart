import 'package:starzinfinite/features/home/domain/entities/flight_settings_entity.dart';

class FileSystemManager {
  // Aereo
  FlightSetting? flightSetting;

  String? razonSocial;
  String? nit;
  String? emailReserva;
  String? numeroReserva;
  String? prefijo;
  String descripcion = '';
  var verificaMonto;
  static final FileSystemManager _instance = FileSystemManager._internal();

  FileSystemManager._internal();

  static FileSystemManager get instance => _instance;
}
