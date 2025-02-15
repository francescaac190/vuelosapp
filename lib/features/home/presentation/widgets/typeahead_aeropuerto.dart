import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:starzinfinite/core/styles/TextStyle.dart';
import 'package:starzinfinite/core/styles/colors.dart';
import '../../domain/entities/aeropuerto.dart';
import '../providers/aeropuerto_provider.dart';

class TypeAheadAeropuerto extends StatefulWidget {
  final Function(String) onIataSelected;
  final String label; // Identificador para Origen/Destino
  final TextEditingController controller;
  final IconData icon;

  const TypeAheadAeropuerto({
    Key? key,
    required this.onIataSelected,
    required this.label,
    required this.controller,
    required this.icon,
  }) : super(key: key);

  @override
  _TypeAheadAeropuertoState createState() => _TypeAheadAeropuertoState();
}

class _TypeAheadAeropuertoState extends State<TypeAheadAeropuerto> {
  @override
  Widget build(BuildContext context) {
    final aeropuertosProvider = Provider.of<AeropuertosProvider>(context);

    print(
        "Número de aeropuertos cargados: ${aeropuertosProvider.aeropuertos.length}");

    return TypeAheadField<Aeropuerto>(
      controller: widget.controller,
      suggestionsCallback: (search) async {
        print(
            "Texto ingresado: $search"); // Depuración: verifica que el texto está llegando

        if (search.isEmpty) {
          return aeropuertosProvider
              .aeropuertos; // Si el usuario no ha escrito nada, muestra todos
        }

        return aeropuertosProvider.aeropuertos.where((aeropuerto) {
          return aeropuerto.concatenacion
              .toLowerCase()
              .contains(search.toLowerCase());
        }).toList();
      },
      // loadingBuilder: (context) => const Center(
      //   child: Padding(
      //     padding: EdgeInsets.all(10.0),
      //     child: CircularProgressIndicator(),
      //   ),
      // ),
      emptyBuilder: (context) => const ListTile(
        title: Text("No se encontraron coincidencias",
            style: TextStyle(color: Colors.red)),
      ),
      builder: (context, controller, focusNode) {
        return TextField(
          controller: widget.controller,
          focusNode: focusNode,
          style: medium(blackBeePay, 16),
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(widget.icon, size: 30, color: starzAzul),
            hintText: widget.label,
            hintStyle: medium(kGrey600, 17),
            suffixIcon: IconButton(
              icon: const Icon(Icons.close, size: 20, color: kGrey600),
              onPressed: () {
                setState(() {
                  widget.controller.clear();
                });
                widget.onIataSelected(""); // Limpiar la selección
              },
            ),
          ),
        );
      },
      itemBuilder: (context, Aeropuerto suggestion) {
        return ListTile(
          leading: const Icon(Icons.local_airport, color: blackBeePay),
          title: Text(
            "${suggestion.iata} - ${suggestion.nombre}",
            style: medium(blackBeePay, 16),
          ),
          subtitle: Text(
            suggestion.concatenacion,
            style: regular(kGrey600, 14),
          ),
        );
      },
      onSelected: (Aeropuerto suggestion) {
        setState(() {
          widget.controller.text = suggestion.nombre;
        });
        widget.onIataSelected(suggestion.iata);
      },
    );
  }
}
