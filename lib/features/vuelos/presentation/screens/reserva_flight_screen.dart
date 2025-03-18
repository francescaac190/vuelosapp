import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:starzinfinite/core/cores.dart';
import 'package:starzinfinite/features/home/domain/entities/flight_settings_entity.dart';

import '../../domain/entities/flight_entity.dart';
import '../../domain/entities/pasajeros_list.dart';
import '../widgets/datos_vuelo_widget.dart';
import '../widgets/dropdown_prefijos.dart';
import 'resumen_reserva_screen.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class ReservaFlightScreen extends StatefulWidget {
  final Dato selectedFlight;
  final FlightSetting? flightSetting;
  const ReservaFlightScreen(
      {super.key, required this.selectedFlight, this.flightSetting});

  @override
  State<ReservaFlightScreen> createState() => _ReservaFlightScreenState();
}

class _ReservaFlightScreenState extends State<ReservaFlightScreen> {
  late Reserva listPasajeros;
  TextEditingController razonController = TextEditingController();
  TextEditingController nitController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numeroController = TextEditingController();

  final _formKeyReceba = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Llenar listPasajeros con datos de ejemplo
    listPasajeros = Reserva.fromJson({
      "adultos": [
        {
          "id": 1,
          "surname": "PÉREZ",
          "name": "JUAN",
          "foid_type": "NI",
          "foid_id": "12345678",
          "date_of_birth": "1990-05-10"
        },
        {
          "id": 2,
          "surname": "GARCÍA",
          "name": "MARÍA",
          "foid_type": "PAS",
          "foid_id": "98765432",
          "date_of_birth": "1988-09-22"
        }
      ],
      "menores": [
        {
          "id": 1,
          "surname": "PÉREZ",
          "name": "LUIS",
          "foid_type": "NI",
          "foid_id": "56789012",
          "date_of_birth": "2012-08-15"
        }
      ],
      "bebes": [
        {
          "id": 1,
          "surname": "PÉREZ",
          "name": "ANA",
          "foid_type": "NI",
          "foid_id": "23456789",
          "date_of_birth": "2023-06-20"
        }
      ]
    });
  }

  bool validarFormulario() {
    return _formKeyReceba.currentState?.validate() ?? false;
  }

  bool validarDatosPasajeros() {
    return listPasajeros.adultos.length ==
            int.parse(widget.flightSetting!.adultos) &&
        listPasajeros.menores.length ==
            int.parse(widget.flightSetting!.ninos) &&
        listPasajeros.bebes.length == int.parse(widget.flightSetting!.bebes);
  }

  bool validarAgregarPasajeros() {
    return listPasajeros.adultos.length <=
            int.parse(widget.flightSetting!.adultos) - 1 ||
        listPasajeros.menores.length <=
            int.parse(widget.flightSetting!.ninos) - 1 ||
        listPasajeros.bebes.length <=
            int.parse(widget.flightSetting!.bebes) - 1;
  }

  void onContinuar() {
    if (!validarFormulario()) {
      MensajeError(context, 'Completar datos de pasajeros');
      return;
    }

    if (!validarDatosPasajeros()) {
      MensajeError(context, 'La cantidad de pasajeros no coincide');
      return;
    }

    FileSystemManager.instance.descripcion = 'Pago Boleto Aéreo';
    FileSystemManager.instance.verificaMonto =
        widget.selectedFlight.totalAmountFee;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ResumenReservaScreen(selectedFlight: widget.selectedFlight),
        settings: RouteSettings(name: 'ResumenReserva'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background2,
      appBar: AppBarStarz(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        physics: BouncingScrollPhysics(),
        child: Form(
          key: _formKeyReceba,
          child: Column(
            children: [
              ContainerInfoVuelo(widget: widget.selectedFlight),
              ContainerPasajeros(
                listPasajeros,
                validar: validarAgregarPasajeros(),
              ),
              ContainerFacturacion(
                  razonController: razonController,
                  nitController: nitController),
              ContainerContacto(
                  emailController: emailController,
                  numeroController: numeroController),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 100,
        color: blanco,
        surfaceTintColor: blanco,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'BOB. ${widget.selectedFlight.totalAmountFee}',
                style: semibold(blackBeePay, 25),
              ),
              ElevatedButton(
                onPressed: onContinuar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: starzAzul,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  'Continuar',
                  style: medium(blanco, 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContainerContacto extends StatelessWidget {
  const ContainerContacto({
    super.key,
    required this.emailController,
    required this.numeroController,
  });

  final TextEditingController emailController;
  final TextEditingController numeroController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: customBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Detalles de Contacto',
            style: medium(blackBeePay, 15),
          ),
          Divider(
            color: gris6,
            height: 16,
          ),
          addVerticalSpace(8),
          Text(
            'Correo electrónico',
            style: medium(gris8, 14),
          ),
          CustomTextFormFieldUnderline(
            emailController,
            TextInputType.emailAddress,
            TextCapitalization.none,
            false,
            false,
            (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresá tu email';
              }
              if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                  .hasMatch(value)) {
                return 'Por favor ingresá un email valido';
              }
              return null;
            },
            (value) {
              value = emailController.text;
              FileSystemManager.instance.emailReserva = value.toString();
            },
          ),
          addVerticalSpace(16),
          Text(
            'Número de teléfono',
            style: medium(gris8, 14),
          ),
          Row(
            children: [
              CountryDropdown(),
              addHorizontalSpace(10),
              Expanded(
                child: CustomTextFormFieldUnderline(
                  numeroController,
                  TextInputType.number,
                  TextCapitalization.none,
                  false,
                  false,
                  (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresá tu número';
                    }

                    return null;
                  },
                  (value) {
                    value = numeroController.text;
                    FileSystemManager.instance.numeroReserva = value.toString();
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ContainerFacturacion extends StatelessWidget {
  const ContainerFacturacion({
    super.key,
    required this.razonController,
    required this.nitController,
  });

  final TextEditingController razonController;
  final TextEditingController nitController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: customBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Datos de facturación',
            style: medium(blackBeePay, 15),
          ),
          Divider(
            color: gris6,
            height: 16,
          ),
          addVerticalSpace(8),
          Text(
            'Razón Social',
            style: medium(gris8, 14),
          ),
          CustomTextFormFieldUnderline(
            razonController,
            TextInputType.name,
            TextCapitalization.words,
            false,
            false,
            (value) {
              if (value == null || value.isEmpty) {
                return 'Obligatorio';
              }

              return null;
            },
            (value) {
              FileSystemManager.instance.razonSocial = value.toString();
              print(FileSystemManager.instance.razonSocial);
            },
          ),
          // TypeAheadFormField<String>(
          //   textFieldConfiguration:
          //       TextFieldConfiguration(
          //     textCapitalization:
          //         TextCapitalization.words,
          //     style: regular(blackBeePay, 16),
          //     keyboardType: TextInputType.text,
          //     textInputAction: TextInputAction.done,
          //     decoration: InputDecoration(
          //       hintText: razonSocial != null
          //           ? razonSocial
          //           : ' ',
          //       hintStyle: razonSocial == null
          //           ? regular(blackBeePay, 16)
          //           : regular(blackBeePay, 16),
          //       contentPadding: EdgeInsets.all(5),
          //       focusedBorder: UnderlineInputBorder(
          //         borderSide:
          //             BorderSide(color: gris5),
          //       ),
          //     ),
          //     onChanged: (newValue) {
          //       setState(() {
          //         razonSocial = newValue;
          //         FileSystemManager.instance
          //             .razonSocial = razonSocial;
          //       });
          //     },
          //   ),
          //   suggestionsCallback: (pattern) {
          //     List<String> fetchSuggestions(
          //         String pattern) {
          //       return datosPerfil.facturacion!
          //           .where((item) => item.razonSocial!
          //               .contains(
          //                   pattern.toLowerCase()))
          //           .map((item) =>
          //               item.razonSocial.toString())
          //           .toList();
          //     }

          //     return fetchSuggestions(
          //         pattern); // Replace with your own logic
          //   },
          //   itemBuilder: (context, suggestion) {
          //     var selectedContact = datosPerfil
          //         .facturacion!
          //         .firstWhere((contact) =>
          //             contact.razonSocial ==
          //             suggestion);

          //     return ListTile(
          //       tileColor: blanco,
          //       title: Text(
          //         suggestion,
          //         style: TextStyle(
          //             fontWeight: FontWeight.normal),
          //       ),
          //       subtitle: Text(
          //         '${selectedContact.nit}',
          //         style: TextStyle(
          //             fontWeight: FontWeight.normal),
          //       ),
          //     );
          //   },
          //   onSuggestionSelected: (suggestion) {
          //     var selectedContact = datosPerfil
          //         .facturacion!
          //         .firstWhere((contact) =>
          //             contact.razonSocial ==
          //             suggestion);

          //     setState(() {
          //       razonSocial = suggestion;
          //       FileSystemManager.instance
          //           .razonSocial = suggestion;
          //       FileSystemManager.instance.nit =
          //           selectedContact
          //               .nit; // Guardar el NIT
          //       nit.text = selectedContact
          //           .nit!; // Actualizar el controlador del NIT
          //     });
          //   },
          //   noItemsFoundBuilder: (context) {
          //     return ListTile(
          //       tileColor: blanco,
          //       title: Text('Sin datos guardados'),
          //     );
          //   },
          // ),
          addVerticalSpace(16),
          Text(
            'Número de Identificación Tributaria',
            style: medium(gris8, 14),
          ),
          CustomTextFormFieldUnderline(
            nitController,
            TextInputType.number,
            TextCapitalization.none,
            false,
            false,
            (value) {
              if (value == null || value.isEmpty) {
                return 'Obligatorio';
              }

              return null;
            },
            (value) {
              FileSystemManager.instance.nit = value.toString();
              print(FileSystemManager.instance.nit);
            },
          ),
        ],
      ),
    );
  }
}

class ContainerPasajeros extends StatefulWidget {
  final Reserva listPasajeros;
  final bool validar;

  const ContainerPasajeros(this.listPasajeros,
      {super.key, required this.validar});

  @override
  State<ContainerPasajeros> createState() => _ContainerPasajerosState();
}

class _ContainerPasajerosState extends State<ContainerPasajeros> {
  void eliminarPasajero(List<Pasajero> lista, int index) {
    setState(() {
      lista.removeAt(index);
      print(lista.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        addVerticalSpace(8),
        Text(
          'Pasajeros',
          style: medium(gris7, 20),
        ),
        //LISTA PASAJERO ADULTO
        if (widget.listPasajeros.adultos.isNotEmpty)
          containerLista(
              widget.listPasajeros.adultos, "Adultos:", eliminarPasajero),
        if (widget.listPasajeros.menores.isNotEmpty)
          containerLista(
              widget.listPasajeros.menores, "Niños:", eliminarPasajero),
        if (widget.listPasajeros.bebes.isNotEmpty)
          containerLista(
              widget.listPasajeros.bebes, "Bebés:", eliminarPasajero),
        addVerticalSpace(8),

        widget.validar
            ? ElevatedButton.icon(
                label: Text(
                  'Agregar pasajero',
                  style: medium(blackBeePay, 14),
                ),
                icon: Icon(
                  Icons.add_rounded,
                  color: blackBeePay,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: starzAzulClaro,
                  surfaceTintColor: blanco,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  print('agregar');
                },
              )
            : Container(),
      ],
    );
  }

  Column containerLista(List<Pasajero> lista, String titulo,
      Function(List<Pasajero>, int) onDelete) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
          child: Text(
            titulo,
            style: medium(blackBeePay, 14),
          ),
        ),
        Container(
          decoration: customBoxDecoration(),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: lista.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final listaPasajero = lista[index];
              return Column(
                children: [
                  ListTile(
                    title: Text(
                      '${listaPasajero.name} ${listaPasajero.surname}',
                      style: medium(blackBeePay, 14),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat.yMMMMd('es').format(DateTime.parse(
                              listaPasajero.dateOfBirth.toString())),
                          style: regular(gris8, 13),
                        ),
                        Text(
                          'Documento: ${listaPasajero.foidId}',
                          style: regular(gris8, 13),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => onDelete(lista, index),
                    ),
                  ),
                  if (index != lista.length - 1)
                    Divider(
                      color: gris1,
                      height: 8,
                      endIndent: 8,
                      indent: 8,
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class ContainerInfoVuelo extends StatelessWidget {
  const ContainerInfoVuelo({
    super.key,
    required this.widget,
  });

  final Dato widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      decoration: customBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '   VUELO DE IDA',
            style: bold(gris6, 17),
          ),
          addVerticalSpace(16),
          ExpansionTileWidget(flightList: widget.ida),
          if (widget.vuelta!.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(
                  color: starzAzul,
                ),
                addVerticalSpace(8),
                Text(
                  '   VUELO DE VUELTA',
                  style: bold(gris6, 17),
                ),
                addVerticalSpace(16),
                ExpansionTileWidget(flightList: widget.vuelta!),
              ],
            ),
        ],
      ),
    );
  }
}

class ExpansionTileWidget extends StatelessWidget {
  const ExpansionTileWidget({
    super.key,
    required this.flightList,
  });

  final List<Vuelos> flightList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: flightList.length,
        itemBuilder: (context, index) {
          final vueloDato = flightList[index];
          return Column(
            children: [
              ExpansionTile(
                childrenPadding: EdgeInsets.zero,
                tilePadding: EdgeInsets.zero,
                expandedAlignment: Alignment.center,
                title: datosVuelosWidget(
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
                shape: Border(bottom: BorderSide.none),
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 5, 5, 5),
                    child: Row(
                      children: [
                        Text(
                          '${flightList[index].departureAirport}     ',
                          style: semibold(blackBeePay, 16),
                        ),
                        Flexible(
                          child: Column(
                            children: [
                              Text(
                                '${flightList[index].departureAeropuerto}',
                                style: regular(blackBeePay, 16),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 5, 5, 5),
                    child: Row(
                      children: [
                        Text(
                          '${flightList[index].arrivalAirport}    ',
                          style: semibold(blackBeePay, 16),
                        ),
                        Flexible(
                          child: Column(
                            children: [
                              Text(
                                '${flightList[index].arrivalAeropuerto}',
                                style: regular(blackBeePay, 16),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 5, 5, 5),
                    child: Row(
                      children: [
                        Icon(
                          Icons.flight,
                          size: 20,
                          color: blackBeePay,
                        ),
                        Text(
                          '    ${flightList[index].flightNumber}',
                          style: regular(blackBeePay, 16),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 5, 5, 16),
                    child: Row(
                      children: [
                        Icon(
                          Icons.luggage_rounded,
                          size: 20,
                          color: blackBeePay,
                        ),
                        Text(
                          flightList[index].equipaje == "0 " ||
                                  flightList[index].equipaje == ''
                              ? '    0'
                              : '    ${flightList[index].equipaje}',
                          style: regular(blackBeePay, 16),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              if (index != flightList.length - 1)
                Divider(
                  color: gris2,
                ),
            ],
          );
        });
  }
}
