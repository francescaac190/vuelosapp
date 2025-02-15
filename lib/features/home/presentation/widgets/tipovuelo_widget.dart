import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starzinfinite/core/styles/colors.dart';
import 'package:starzinfinite/core/styles/TextStyle.dart';

import '../providers/tipovuelo_provider.dart';

class TipoVueloDropdown extends StatelessWidget {
  final List<String> opciones = ['Ida', 'Ida y Vuelta'];

  TipoVueloDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final tipoVueloProvider = Provider.of<TipoVueloProvider>(context);

    return Expanded(
      child: Container(
        // width: MediaQuery.of(context).size.width * 0.3,
        padding: EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
          color: background2,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: DropdownButton<String>(
          padding: const EdgeInsets.only(right: 8),
          isExpanded: true,
          value: tipoVueloProvider.opcion, // Valor actual del Provider
          style: medium(blackBeePay, 14),
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: kGrey600,
          ),
          dropdownColor: blanco,
          underline: const SizedBox(),
          items: opciones.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: medium(blackBeePay, 14),
              ),
            );
          }).toList(),
          onChanged: (String? value) {
            if (value != null) {
              tipoVueloProvider.setTipoVuelo(value);
            }
          },
        ),
      ),
    );
  }
}
