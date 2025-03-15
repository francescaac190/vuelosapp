import 'package:flutter/material.dart';
import 'package:starzinfinite/core/cores.dart';

Column datosVuelosWidget(
  String? carrierlogo,
  String? aerolinea,
  String? tiempo,
  String? aeSalida,
  String? ciudadSalida,
  String? fechaSalida,
  String? horaSalida,
  String? aeLlegada,
  String? ciudadLlegada,
  String? fechaLlegada,
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
                    style: semibold(blackBeePay, 25),
                  ),
                  addVerticalSpace(24),
                  Text(
                    ciudadSalida!,
                    style: medium(kGrey800, 16),
                  ),
                  Text(
                    fechaSalida!,
                    style: regular(kGrisOscurso, 14),
                  ),
                  Text(
                    horaSalida!,
                    style: regular(kGrisOscurso, 14),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Image.asset(
                  'assets/iconos/avion.png',
                  height: 30,
                ),
                addVerticalSpace(8),
                Text(
                  tiempo!,
                  style: medium(kGrey800, 16),
                ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    aeLlegada!,
                    style: semibold(blackBeePay, 25),
                  ),
                  addVerticalSpace(24),
                  Text(
                    ciudadLlegada!,
                    style: medium(kGrey800, 16),
                  ),
                  Text(
                    fechaLlegada!,
                    style: regular(kGrisOscurso, 14),
                  ),
                  Text(
                    horaLlegada!,
                    style: regular(kGrisOscurso, 14),
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
