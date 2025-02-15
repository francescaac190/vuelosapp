import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starzinfinite/core/styles/TextStyle.dart';
import 'package:starzinfinite/core/styles/colors.dart';

import '../providers/tipovuelo_provider.dart';

class FechaSelector extends StatelessWidget {
  const FechaSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final tipoVueloProvider = Provider.of<TipoVueloProvider>(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        children: [
          tipoVueloProvider.tipoVuelo != "RT"
              ? InkWell(
                  onTap: () => tipoVueloProvider.pickDate(context),
                  child: Container(
                    height: 70,
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: background2,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    margin: const EdgeInsets.only(top: 15),
                    alignment: Alignment.center,
                    child: Text(
                      tipoVueloProvider.format1.isEmpty
                          ? 'Fecha de Ida'
                          : '${tipoVueloProvider.date.day}/${tipoVueloProvider.date.month}/${tipoVueloProvider.date.year}',
                      style: medium(blackBeePay, 15),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : InkWell(
                  onTap: () => tipoVueloProvider.pickDateRange(context),
                  child: Container(
                    height: 70,
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: background2,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    margin: const EdgeInsets.only(top: 15),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          tipoVueloProvider.format1.isEmpty
                              ? 'Fecha de Ida'
                              : '${tipoVueloProvider.start.day}/${tipoVueloProvider.start.month}/${tipoVueloProvider.start.year}',
                          style: medium(blackBeePay, 15),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '-',
                          style: medium(blackBeePay, 15),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          tipoVueloProvider.format2.isEmpty
                              ? 'Fecha de Vuelta'
                              : '${tipoVueloProvider.end.day}/${tipoVueloProvider.end.month}/${tipoVueloProvider.end.year}',
                          style: medium(blackBeePay, 15),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
