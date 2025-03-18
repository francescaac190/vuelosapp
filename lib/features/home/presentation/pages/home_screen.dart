import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starzinfinite/features/home/presentation/providers/pasajeros_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:starzinfinite/features/auth/presentation/controller/auth_provider.dart';
import 'package:starzinfinite/features/home/presentation/widgets/passangers_widget.dart';
import 'package:starzinfinite/features/home/presentation/widgets/tipovuelo_widget.dart';
import 'package:starzinfinite/features/profile/presentation/pages/perfil_screen.dart';
import 'package:starzinfinite/features/reservas/presentation/pages/reservas_screen.dart';
import 'dart:math';

import '../../../../core/cores.dart';
import '../../../vuelos/presentation/screens/flight_list_screen.dart';
import '../../domain/entities/flight_settings_entity.dart';
import '../providers/aeropuerto_provider.dart';
import '../providers/tipovuelo_provider.dart';
import '../widgets/fecha_selector.dart';
import '../widgets/typeahead_aeropuerto.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // indice de la pestaña seleccionada

  // Lista de widgets para cada pestaña
  final List<Widget> _pages = [
    HomePage(),
    ReservasPage(),
    PerfilPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final authState = Provider.of<AuthState>(context);

    return Scaffold(
      body: _pages[_selectedIndex], // Muestra la página correspondiente
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 25,
        selectedLabelStyle: medium(gris3, 15),
        unselectedLabelStyle: medium(gris3, 14),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Mis Reservas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          HeaderHome(),
          Vuelos(),
        ],
      ),
    );
  }
}

class Vuelos extends StatefulWidget {
  const Vuelos({Key? key}) : super(key: key);

  @override
  State<Vuelos> createState() => _VuelosState();
}

class _VuelosState extends State<Vuelos> with TickerProviderStateMixin {
  // origen - destino
  TextEditingController origenController = TextEditingController();
  TextEditingController destinoController = TextEditingController();

  // iata seleccionado origen - destino
  String selectedIataOrigen = "";
  String selectedIataDestino = "";

  // tipo vuelo
  String tipoVuelo = 'RT';

  late Animation _arrowAnimation;
  late AnimationController _arrowAnimationController;

  @override
  void initState() {
    super.initState();
    _arrowAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _arrowAnimation =
        Tween(begin: 0.0, end: pi).animate(_arrowAnimationController);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget firstChild() {
    return InkWell(
      child: AnimatedBuilder(
        animation: _arrowAnimation,
        builder: (context, child) => Transform.rotate(
          angle: _arrowAnimation.value,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Icon(
                  Icons.arrow_downward_outlined,
                  color: starzAzul,
                  size: 20,
                ),
                Icon(
                  Icons.arrow_upward_outlined,
                  color: starzAzul,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        _arrowAnimationController.isCompleted
            ? _arrowAnimationController.reverse()
            : _arrowAnimationController.forward();

        setState(() {
          // Intercambia valores de IATA
          String swapIata = selectedIataOrigen;
          selectedIataOrigen = selectedIataDestino;
          selectedIataDestino = swapIata;

          // Intercambia valores de los campos de texto
          String swapText = origenController.text;
          origenController.text = destinoController.text;
          destinoController.text = swapText;
        });

        print(
            "Nuevo Origen: $selectedIataOrigen - Nuevo Destino: $selectedIataDestino");
      },
    );
  }

  void _validate(BuildContext context) {
    final tipoVueloProvider =
        Provider.of<TipoVueloProvider>(context, listen: false);

    final pasajeros = Provider.of<PasajerosProvider>(context, listen: false);

    String origen = selectedIataOrigen;
    String destino = selectedIataDestino;
    String fechaSalida = tipoVueloProvider.format1;
    String fechaRegreso = tipoVueloProvider.format2;
    int adultos = pasajeros.adultos;
    int ninos = pasajeros.ninos;
    int bebes = pasajeros.bebes;

    // print("Origen: $origen");
    // print("Destino: $destino");
    // print("Fecha Salida: $fechaSalida");
    // print("Fecha Regreso: $fechaRegreso");
    // print("Pasajeros: Adultos: $adultos, Ninos: $ninos, Bebes: $bebes");
    if (origen.isEmpty || destino.isEmpty || fechaSalida.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          title: Text(
            "Por favor ingrese todos los datos",
            style: medium(blackBeePay, 17),
          ),
        ),
      );
    } else {
      // Crear array con los datos seleccionados y print en consola
      FlightSetting datosViaje = FlightSetting(
          adultos: adultos.toString(),
          ninos: ninos.toString(),
          bebes: bebes.toString(),
          origen: origen,
          destino: destino,
          fechaSalida: fechaSalida,
          fechaRegreso: fechaRegreso,
          tipoVuelo: tipoVueloProvider.tipoVuelo);

      FileSystemManager.instance.flightSetting = datosViaje;
      print(FileSystemManager.instance.flightSetting);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  FlightListPage(flightsSettings: datosViaje)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
      child: Column(
        children: <Widget>[
          Text(
            '¿A DÓNDE QUERÉS VIAJAR?',
            textAlign: TextAlign.center,
            style: medium(gris7, 24),
          ),
          Text(
            'Seleccioná los detalles del vuelo',
            style: medium(gris7, 17),
          ),
          Divider(
            height: 24,
            thickness: 2,
            color: starzAzul,
            endIndent: 15,
            indent: 15,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: background2,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TypeAheadAeropuerto(
                  label: "Origen",
                  icon: Icons.flight_takeoff_rounded,
                  controller: origenController,
                  onIataSelected: (iata) {
                    setState(() {
                      selectedIataOrigen = iata;
                    });
                    print("Origen seleccionado: $iata");
                  },
                ),
                addVerticalSpace(15),
                Padding(
                  padding: const EdgeInsets.only(right: 15, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Divider(
                        color: starzAzul,
                      )),
                      firstChild(),
                      Expanded(
                          child: Divider(
                        color: starzAzul,
                      )),
                    ],
                  ),
                ),
                addVerticalSpace(15),
                TypeAheadAeropuerto(
                  label: "Destino",
                  controller: destinoController,
                  onIataSelected: (iata) {
                    setState(() {
                      selectedIataDestino = iata;
                    });
                    print("Destino seleccionado: $iata");
                  },
                  icon: Icons.flight_land_rounded,
                ),
              ],
            ),
          ),
          addVerticalSpace(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TipoVueloDropdown(),
              addHorizontalSpace(
                30,
              ),
              PasajerosBagsClasses(),
            ],
          ),
          addVerticalSpace(16),
          Text(
            'Seleccioná tus fechas:',
            style: medium(gris7, 17),
          ),
          FechaSelector(),
          addVerticalSpace(16),
          CustomButton(
            text: 'Buscar vuelos',
            onPressed: () => _validate(context),
            color: starzAzul,
            textColor: blanco,
            width: double.infinity,
            height: 45,
          )
        ],
      ),
    );
  }
}

class HeaderHome extends StatelessWidget {
  const HeaderHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: starzAzul,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 7,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          addVerticalSpace(
            50,
          ),
          Text(
            'Bienvenido,',
            style: semibold(blanco, 24),
          ),
          Text(
            'Nombre Apellido',
            style: medium(blanco, 20),
          ),
          Spacer(),
          Text(
            'Saldo:',
            style: semibold(blanco, 24),
          ),
          Text(
            '12.000,00',
            style: medium(blanco, 20),
          ),
        ],
      ),
    );
  }
}
