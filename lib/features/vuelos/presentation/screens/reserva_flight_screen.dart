import 'package:flutter/material.dart';
import 'package:starzinfinite/core/cores.dart';

import '../../domain/entities/flight_entity.dart';
import '../widgets/datos_vuelo_widget.dart';

class ReservaFlightScreen extends StatefulWidget {
  final Dato selectedFlight;
  const ReservaFlightScreen({super.key, required this.selectedFlight});

  @override
  State<ReservaFlightScreen> createState() => _ReservaFlightScreenState();
}

class _ReservaFlightScreenState extends State<ReservaFlightScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background2,
      appBar: AppBarStarz(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(8),
              decoration: customBoxDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'VUELO DE IDA',
                    style: bold(grisOscBeePay, 17),
                  ),
                  addVerticalSpace(16),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.selectedFlight.ida.length,
                      itemBuilder: (context, index) {
                        final vueloDato = widget.selectedFlight.ida[index];
                        return Column(
                          children: [
                            datosVuelosWidget(
                              vueloDato.logoCarrier,
                              vueloDato.nameCarrier,
                              vueloDato.flightTime,
                              vueloDato.departureAirport,
                              vueloDato.departureCiudad,
                              vueloDato.departureDate,
                              vueloDato.departureTime,
                              vueloDato.arrivalAirport,
                              vueloDato.arrivalCiudad,
                              vueloDato.arrivalDate,
                              vueloDato.arrivalTime,
                            ),
                            ExpansionTile(
                                childrenPadding: EdgeInsets.zero,
                                tilePadding: EdgeInsets.zero,
                                title: Text(
                                  widget.selectedFlight.gds,
                                )),
                          ],
                        );
                      }),
                ],
              ),
            ),
            Text(
              widget.selectedFlight.gds,
              style: medium(blackBeePay, 30),
            ),
          ],
        ),
      ),
    );
  }
}
