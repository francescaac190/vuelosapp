import 'package:flutter/material.dart';
import 'package:starzinfinite/core/styles/TextStyle.dart';
import 'package:starzinfinite/core/styles/colors.dart';

class TicketItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const TicketItem({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: blanco,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 7,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: ListTile(
          leading: const Icon(Icons.airplane_ticket, color: starzAzul),
          title: Text(title, style: medium(blackBeePay, 15)),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
