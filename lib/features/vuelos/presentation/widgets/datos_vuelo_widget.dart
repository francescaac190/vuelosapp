import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:starzinfinite/core/cores.dart';

Column datosVuelosWidget(
  String? carrierlogo,
  String? aerolinea,
  String? tiempo,
  String? aeSalida,
  String? ciudadSalida,
  DateTime? fechaSalida,
  String? horaSalida,
  String? aeLlegada,
  String? ciudadLlegada,
  DateTime? fechaLlegada,
  String? horaLlegada,
) {
  return Column(
    children: [
      Container(
        color: blanco,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            addHorizontalSpace(8),
            carrierlogo != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Image.network(
                      carrierlogo,
                      height: 30,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Text('Error'),
                    ),
                  ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    aerolinea!,
                    style: medium(blackBeePay, 15),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      addVerticalSpace(8),
      Container(
        color: blanco,
        padding: EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    aeSalida!,
                    style: semibold(gris8, 25),
                  ),
                  addVerticalSpace(24),
                  Text(
                    ciudadSalida!,
                    style: medium(gris8, 14),
                  ),
                  Text(
                    DateFormat.yMMMEd('es')
                        .format(DateTime.parse(fechaSalida.toString())),
                    style: regular(gris5, 14),
                  ),
                  Text(
                    horaSalida!,
                    style: regular(gris5, 14),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Image.asset(
                  'assets/iconos/avion.png',
                  height: 20,
                ),
                addVerticalSpace(8),
                Text(
                  tiempo!,
                  style: medium(gris8, 16),
                ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    aeLlegada!,
                    textAlign: TextAlign.right,
                    style: semibold(gris8, 25),
                  ),
                  addVerticalSpace(24),
                  Text(
                    ciudadLlegada!,
                    textAlign: TextAlign.right,
                    style: medium(gris8, 14),
                  ),
                  Text(
                    DateFormat.yMMMEd('es')
                        .format(DateTime.parse(fechaLlegada.toString())),
                    textAlign: TextAlign.right,
                    style: regular(gris5, 14),
                  ),
                  Text(
                    horaLlegada!,
                    style: regular(gris5, 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
