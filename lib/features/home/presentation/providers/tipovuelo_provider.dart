import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TipoVueloProvider extends ChangeNotifier {
  String _tipoVuelo = 'RT'; // Default: Ida y Vuelta (Round Trip)
  String _opcion = 'Ida y Vuelta'; // Valor del Dropdown
  String _format1 = '';
  String _format2 = '';

  DateTime _date = DateTime.now();
  DateTimeRange _dateRange =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());

  // Getters
  String get tipoVuelo => _tipoVuelo;
  String get opcion => _opcion;
  String get format1 => _format1;
  String get format2 => _format2;
  DateTime get date => _date;
  DateTime get start => _dateRange.start;
  DateTime get end => _dateRange.end;

  // Cambiar tipo de vuelo
  void setTipoVuelo(String value) {
    _opcion = value;

    if (value == 'Ida') {
      _tipoVuelo = "OW"; // One Way
      _format1 = DateFormat('yyyy-MM-dd').format(_date);
      _format2 = "";
    } else {
      _tipoVuelo = "RT"; // Round Trip
      _format1 = DateFormat('yyyy-MM-dd').format(_dateRange.start);
      _format2 = DateFormat('yyyy-MM-dd').format(_dateRange.end);
    }

    notifyListeners();
  }

  // Seleccionar fecha de ida
  Future<void> pickDate(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      locale: Locale('es', 'US'),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 2),
    );

    if (newDate != null) {
      _date = newDate;
      _format1 = DateFormat('yyyy-MM-dd').format(_date);
      notifyListeners();
    }
  }

  // Seleccionar rango de fechas (ida y vuelta)
  Future<void> pickDateRange(BuildContext context) async {
    final newDateRange = await showDateRangePicker(
      context: context,
      locale: Locale('es', 'US'),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 2),
      initialDateRange: _dateRange,
    );

    if (newDateRange != null) {
      _dateRange = newDateRange;
      _format1 = DateFormat('yyyy-MM-dd').format(_dateRange.start);
      _format2 = DateFormat('yyyy-MM-dd').format(_dateRange.end);
      notifyListeners();
    }
  }
}
