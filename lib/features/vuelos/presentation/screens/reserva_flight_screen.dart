import 'package:flutter/material.dart';
import 'package:starzinfinite/core/cores.dart';

import '../../domain/entities/flight_entity.dart';

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
      body: Center(
        child: Text(
          widget.selectedFlight.gds,
          style: medium(blackBeePay, 30),
        ),
      ),
    );
  }
}
