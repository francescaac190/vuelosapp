import 'package:flutter/material.dart';
import 'package:flutter_spinbox/cupertino.dart';
import 'package:provider/provider.dart';
import '../providers/pasajeros_provider.dart';
import 'package:starzinfinite/core/styles/TextStyle.dart';
import 'package:starzinfinite/core/styles/colors.dart';

class PasajerosBagsClasses extends StatelessWidget {
  const PasajerosBagsClasses({super.key});

  @override
  Widget build(BuildContext context) {
    final pasajerosProvider = Provider.of<PasajerosProvider>(context);

    return Expanded(
      child: ElevatedButton(
        onPressed: () => _showPasajerosModal(context),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.all(8),
          backgroundColor: background2,
          elevation: 0,
          minimumSize: Size(MediaQuery.of(context).size.width, 45),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildIconLabel(
                Icons.supervisor_account, pasajerosProvider.adultos),
            _buildIconLabel(Icons.child_care, pasajerosProvider.ninos),
            _buildIconLabel(
                Icons.child_friendly_sharp, pasajerosProvider.bebes),
          ],
        ),
      ),
    );
  }

  Widget _buildIconLabel(IconData icon, int count) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(right: 2),
          child: Icon(icon, size: 15, color: gris7),
        ),
        Text(count.toString(), style: medium(blackBeePay, 14)),
      ],
    );
  }

  void _showPasajerosModal(BuildContext context) {
    showModalBottomSheet<dynamic>(
      context: context,
      backgroundColor: blanco,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return Consumer<PasajerosProvider>(
          builder: (context, provider, child) {
            return Container(
              height: 400,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: background2,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildSpinBox("Adultos", Icons.person, provider.adultos,
                      provider.setAdultos, provider),
                  _buildSpinBox("Niños", Icons.child_care, provider.ninos,
                      provider.setNinos, provider),
                  _buildSpinBox("Bebés", Icons.child_friendly_sharp,
                      provider.bebes, provider.setBebes, provider),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSpinBox(
    String label,
    IconData icon,
    int value,
    Function(int) onChanged,
    PasajerosProvider provider,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, size: 20, color: gris7),
            Container(
              padding: const EdgeInsets.all(8),
              child: Text(label, style: regular(blackBeePay, 18)),
            ),
          ],
        ),
        SizedBox(
          width: 150,
          child: CupertinoSpinBox(
            decrementIcon: Icon(
              Icons.remove_circle_outline,
              color: value <= 0 ? gris7 : starzAzul,
            ),
            incrementIcon: Icon(
              Icons.add_circle_outline,
              color: provider.getRemainingSeats() > 0 ? starzAzul : gris7,
            ),
            decoration: BoxDecoration(
              color: blanco,
              borderRadius: BorderRadius.circular(5),
            ),
            textStyle: const TextStyle(color: blackBeePay),
            min: 0,
            max: (value + provider.getRemainingSeats()).toDouble(),
            value: value.toDouble(),
            onChanged: (newValue) {
              if (provider.getRemainingSeats() > 0 || newValue < value) {
                onChanged(newValue.toInt());
              }
            },
          ),
        ),
      ],
    );
  }
}
