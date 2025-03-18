import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/reservas_provider.dart';
import 'package:starzinfinite/core/styles/colors.dart';
import 'package:starzinfinite/core/styles/TextStyle.dart';

class ReservasSegment extends StatelessWidget {
  const ReservasSegment({super.key});

  @override
  Widget build(BuildContext context) {
    final reservasProvider = Provider.of<ReservasProvider>(context);

    return Container(
      margin: const EdgeInsets.all(16),
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: blanco,
        borderRadius: BorderRadius.circular(70),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 7,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildSegmentItem(context, "Emitidos", index: 0),
          _buildSegmentItem(context, "Reservas", index: 1),
        ],
      ),
    );
  }

  Widget _buildSegmentItem(BuildContext context, String title,
      {required int index}) {
    final reservasProvider = Provider.of<ReservasProvider>(context);

    bool selected = reservasProvider.indexSegmentSelected == index;
    return GestureDetector(
      onTap: () => reservasProvider.setSegmentIndex(index),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: selected
            ? BoxDecoration(
                color: fadeAzul, borderRadius: BorderRadius.circular(70))
            : null,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: selected ? semibold(starzAzul, 16) : regular(gris5, 16),
        ),
      ),
    );
  }
}
