import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:starzinfinite/features/home/domain/entities/flight_settings_entity.dart';
import 'package:starzinfinite/features/vuelos/domain/entities/flight_entity.dart';
import 'package:starzinfinite/features/vuelos/presentation/screens/reserva_flight_screen.dart';

import '../../../../core/cores.dart';
import '../../domain/entities/flight_duration.dart';
import '../bloc/flight_bloc.dart';

class FlightListPage extends StatefulWidget {
  final FlightSetting flightsSettings;

  const FlightListPage({
    Key? key,
    required this.flightsSettings,
  }) : super(key: key);

  @override
  State<FlightListPage> createState() => _FlightListPageState();
}

class _FlightListPageState extends State<FlightListPage> {
  int _value = 1;
  Dato? selectedFlight;

  @override
  void initState() {
    super.initState();
    context.read<FlightBloc>().add(FetchFlightsEvent(
          adultos: widget.flightsSettings.adultos,
          ninos: widget.flightsSettings.ninos,
          bebes: widget.flightsSettings.bebes,
          origen: widget.flightsSettings.origen,
          destino: widget.flightsSettings.destino,
          fechaIda: widget.flightsSettings.fechaSalida,
          fechaVuelta: widget.flightsSettings.fechaRegreso,
          tipoVuelo: widget.flightsSettings.tipoVuelo,
        ));
  }

  FlightDuration calculateTotalFlightTime(List<Vuelos> legs) {
    if (legs.isEmpty) {
      return FlightDuration(
        totalFlightTime: "0h 0m",
        flightTime: "0h 0m",
        layoverTime: "0h 0m",
        layoverDurations: [],
      );
    }

    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");

    // Parse the departure time of the first leg
    DateTime departureTime = dateFormat
        .parse("${legs.first.departureDate} ${legs.first.departureTime}");

    // Parse the arrival time of the last leg
    DateTime arrivalTime =
        dateFormat.parse("${legs.last.arrivalDate} ${legs.last.arrivalTime}");

    // Calculate the total duration
    Duration totalDuration = arrivalTime.difference(departureTime);

    // Calculate the total duration of all flights
    Duration flightDuration = Duration();
    List<String> layoverDurations = [];
    for (int i = 0; i < legs.length; i++) {
      var leg = legs[i];
      List<String> flightTimeParts = leg.flightTime.split(":");
      Duration legDuration = Duration(
        hours: int.parse(flightTimeParts[0]),
        minutes: int.parse(flightTimeParts[1]),
      );
      flightDuration += legDuration;

      if (i > 0) {
        // Calculate layover duration
        DateTime previousArrivalTime = dateFormat
            .parse("${legs[i - 1].arrivalDate} ${legs[i - 1].arrivalTime}");
        DateTime currentDepartureTime =
            dateFormat.parse("${leg.departureDate} ${leg.departureTime}");
        Duration layoverDuration =
            currentDepartureTime.difference(previousArrivalTime);
        String formattedLayoverDuration =
            "${layoverDuration.inHours}h ${layoverDuration.inMinutes.remainder(60)}m";
        layoverDurations.add(formattedLayoverDuration);
      }
    }

    // Calculate the total layover time
    Duration layoverDuration = totalDuration - flightDuration;

    // Format the duration to a readable string
    String formattedTotalDuration =
        "${totalDuration.inHours}h ${totalDuration.inMinutes.remainder(60)}m";
    String formattedFlightDuration =
        "${flightDuration.inHours}h ${flightDuration.inMinutes.remainder(60)}m";
    String formattedLayoverDuration =
        "${layoverDuration.inHours}h ${layoverDuration.inMinutes.remainder(60)}m";

    return FlightDuration(
      totalFlightTime: formattedTotalDuration,
      flightTime: formattedFlightDuration,
      layoverTime: formattedLayoverDuration,
      layoverDurations: layoverDurations,
    );
  }

  double screenHeight = 0;
  double screenWidth = 0;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: background2,
      appBar: AppBarStarz(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            DatosVuelo(
              datos: widget.flightsSettings,
            ),
            addVerticalSpace(16),
            Filtros(value: _value),
            addVerticalSpace(8),
            BlocBuilder<FlightBloc, FlightState>(
              builder: (context, state) {
                if (state is FlightLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is FlightLoaded) {
                  final flights = state.flightEntity;
                  if (flights.datos!.isEmpty) {
                    return const Center(
                        child: Text('No se encontraron vuelos.'));
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: flights.datos!.length,
                    itemBuilder: (context, index) {
                      final flight = flights.datos?[index];
                      FlightDuration idaDuration =
                          calculateTotalFlightTime(flight!.ida);
                      FlightDuration? vueltaDuration = flight.vuelta != null
                          ? calculateTotalFlightTime(flight.vuelta!)
                          : null;
                      if (flight == null) {
                        return const ListTile(
                          title: Text("Datos de vuelo no disponibles"),
                        );
                      }

                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedFlight = flight;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReservaFlightScreen(
                                selectedFlight: selectedFlight!,
                                flightSetting: widget.flightsSettings,
                              ),
                              settings: RouteSettings(name: 'receba'),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          margin: EdgeInsets.symmetric(vertical: 8),
                          decoration: customBoxDecoration(),
                          child: Column(
                            children: [
                              datosVuelosDispo(
                                  index,
                                  flight.ida.last.leg - 1,
                                  flight.ida.first.logoCarrier,
                                  'Ida:  ${flight.ida.first.departureDateOfWeekName.toString()}, ${flight.ida.first.departureDate.toString().substring(8, 10)} de ${flight.ida.first.mesDeparture} de ${flight.ida.first.departureDate.toString().substring(0, 4)}',
                                  '${flight.ida.first.departureTime}',
                                  '${flight.ida.first.departureAirport}',
                                  '${flight.ida.first.departureCiudad}',
                                  "${idaDuration.totalFlightTime}",
                                  "Vuelo ${flight.ida.first.flightNumber}",
                                  '${flight.ida.last.arrivalTime}',
                                  '${flight.ida.last.arrivalAirport}',
                                  '${flight.ida.last.arrivalCiudad}'),
                              flight.ida.last.equipaje == "0 " ||
                                      flight.ida.last.equipaje == ''
                                  ? Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '* No incluye equipaje',
                                          style: regular(rojo, 15),
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '* Incluye equipaje',
                                          style: regular(cupertinoGreen, 15),
                                        ),
                                      ),
                                    ),
                              widget.flightsSettings.tipoVuelo == 'RT'
                                  ? Column(
                                      children: [
                                        addVerticalSpace(16),
                                        datosVuelosDispo(
                                            index,
                                            flight.vuelta!.last.leg - 1,
                                            flight.vuelta?.first.logoCarrier,
                                            'Vuelta:  ${flight.vuelta?.first.arrivalDateOfWeekName.toString()}, ${flight.vuelta?.first.departureDate.toString().substring(8, 10)} de ${flight.vuelta?.first.mesDeparture} de ${flight.vuelta?.first.departureDate.toString().substring(0, 4)}',
                                            '${flight.vuelta?.first.departureTime}',
                                            '${flight.vuelta?.first.departureAirport}',
                                            '${flight.vuelta?.first.departureCiudad}',
                                            "${vueltaDuration!.totalFlightTime}",
                                            "Vuelo ${flight.vuelta?.first.flightNumber}",
                                            '${flight.vuelta?.last.arrivalTime}',
                                            '${flight.vuelta?.last.arrivalAirport}',
                                            '${flight.vuelta?.last.arrivalCiudad}'),
                                        flight.vuelta!.last.equipaje == "0 " ||
                                                flight.vuelta!.last.equipaje ==
                                                    ''
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    '* No incluye equipaje',
                                                    style: regular(rojo, 15),
                                                  ),
                                                ),
                                              )
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    '* Incluye equipaje',
                                                    style: regular(
                                                        cupertinoGreen, 15),
                                                  ),
                                                ),
                                              ),
                                        addVerticalSpace(8),
                                      ],
                                    )
                                  : Container(),
                              Divider(
                                  height: 16,
                                  thickness: 1,
                                  endIndent: 8,
                                  indent: 8,
                                  color: gris2),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 16, 10, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'TOTAL',
                                      style: semibold(gris5, 20),
                                    ),
                                    Text(
                                      '${flight.totalCurrency}. ${flight.totalAmountFee}',
                                      style: semibold(gris5, 20),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is FlightError) {
                  return Center(child: Text('Error: ${state.errorMessage}'));
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  Column datosVuelosDispo(
      int index,
      int conexiones,
      String? carrierlogo,
      String? fecha,
      String? horaSalida,
      String? aeSalida,
      String? ciudadSalida,
      String? vueloSalida,
      String? numeroSalida,
      String? horaLlegada,
      String? aeLlegada,
      String? ciudadLlegada) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              addHorizontalSpace(16),
              carrierlogo != null
                  ? Image.network(
                      carrierlogo,
                      height: 30,
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text('Error'),
                      ),
                    ),
              addVerticalSpace(8),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      fecha!,
                      style: regular(gris5, 15),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          color: blanco,
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                alignment: Alignment.center,
                child: Icon(
                  Icons.flight_rounded,
                  color: starzAzul,
                  size: 20,
                ),
              ),
              SizedBox(
                width: screenWidth * 0.22,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      horaSalida!,
                      style: medium(blackBeePay, 20),
                    ),
                    Text(
                      aeSalida!,
                      style: medium(gris8, 16),
                    ),
                    Text(
                      ciudadSalida!,
                      style: regular(gris5, 14),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Column(
                children: [
                  conexiones >= 1
                      ? Text(
                          'Conexiones: ${conexiones}',
                          style: medium(gris4, 15),
                        )
                      : Text(
                          'Directo',
                          style: medium(gris4, 15),
                        ),
                  Text(
                    vueloSalida!,
                    style: medium(gris8, 16),
                  ),
                ],
              ),
              Spacer(),
              SizedBox(
                width: screenWidth * 0.22,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      horaLlegada!,
                      style: medium(blackBeePay, 20),
                    ),
                    Text(
                      aeLlegada!,
                      style: medium(gris8, 16),
                    ),
                    Text(
                      ciudadLlegada!,
                      style: regular(gris5, 14),
                    ),
                  ],
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}

class DatosVuelo extends StatelessWidget {
  final FlightSetting datos;
  const DatosVuelo({
    super.key,
    required this.datos,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: customBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${datos.origen}  -  ${datos.destino}',
            style: medium(gris5, 16),
          ),
          addHorizontalSpace(16),
          datos.tipoVuelo != "RT"
              ? Text(
                  '${DateFormat.MMMMd('es').format(DateTime.parse(datos.fechaSalida))}',
                  style: medium(gris5, 16),
                )
              : Text(
                  '${DateFormat.MMMMd('es').format(DateTime.parse(datos.fechaSalida))} - ${DateFormat.MMMMd('es').format(DateTime.parse(datos.fechaRegreso))}',
                  style: medium(gris5, 16),
                ),
          addHorizontalSpace(8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.supervisor_account,
                size: 15,
                color: gris7,
              ),
              addHorizontalSpace(4),
              Text(
                datos.adultos.toString(),
                style: medium(gris5, 16),
              ),
              addHorizontalSpace(8),
              Icon(
                Icons.child_care,
                size: 15,
                color: gris7,
              ),
              addHorizontalSpace(4),
              Text(
                datos.ninos.toString(),
                style: medium(gris5, 16),
              ),
              addHorizontalSpace(8),
              Icon(
                Icons.child_friendly_sharp,
                size: 15,
                color: gris7,
              ),
              addHorizontalSpace(4),
              Text(
                datos.bebes.toString(),
                style: medium(gris5, 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Filtros extends StatelessWidget {
  const Filtros({
    super.key,
    required int value,
  }) : _value = value;

  final int _value;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 8,
        ),
        decoration: customBoxDecoration(),
        child: DropdownButton<int>(
          value: _value,
          items: [
            DropdownMenuItem(
              alignment: Alignment.center,
              value: 1,
              child: Text(
                'Más Económico',
                style: semibold(starzAzul, 15),
              ),
            ),
            DropdownMenuItem(
              alignment: Alignment.center,
              value: 2,
              child: Text(
                'Más Cashback',
                style: semibold(gris5, 15),
              ),
            ),
            DropdownMenuItem(
              alignment: Alignment.center,
              value: 3,
              child: Text(
                'Más Temprano',
                style: semibold(gris5, 15),
              ),
            ),
          ],
          onChanged: (int? newValue) async {
            // setState(() {
            //   _value = newValue!;
            //   _isLoading = true;
            // });

            // final flights = await fetchFlights();
            // List<Flight1> sortedFlights;

            // if (_value == 1) {
            //   sortedFlights = sortByPrice(flights);
            //   setState(() {
            //     flightsFuture =
            //         Future<List<Flight1>>.value(sortedFlights);
            //     _isLoading = false;
            //   });
            // } else if (_value == 2) {
            //   sortedFlights = sortByCashback(flights);
            //   setState(() {
            //     flightsFuture = Future.value(sortedFlights);
            //     _isLoading = false;
            //   });
            // } else {
            //   sortedFlights = flights;
            //   setState(() {
            //     flightsFuture =
            //         Future<List<Flight1>>.value(flights);
            //     _isLoading = false;
            //   });
            // }
          },
          alignment: Alignment.centerLeft,
          icon: Icon(Icons.expand_more_rounded),
          underline: Container(), // Remove underline
          dropdownColor: blanco,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
