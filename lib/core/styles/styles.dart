import 'package:flutter/material.dart';

BoxDecoration customBoxDecoration({Color color = Colors.white}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(20),
    border: Border.all(
      color: Colors.white,
      width: 2,
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        spreadRadius: 0,
        blurRadius: 7,
        offset: const Offset(0, 1), // changes position of shadow
      ),
    ],
  );
}
