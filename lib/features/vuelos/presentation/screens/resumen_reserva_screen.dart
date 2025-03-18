import 'package:flutter/material.dart';
import '../../domain/entities/flight_entity.dart';

class ResumenReservaScreen extends StatefulWidget {
  final Dato? selectedFlight;
  const ResumenReservaScreen({super.key, required this.selectedFlight});

  @override
  State<ResumenReservaScreen> createState() => _ResumenReservaScreenState();
}

class _ResumenReservaScreenState extends State<ResumenReservaScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder(
      child: Text('hola'),
    );
  }
}
