import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starzinfinite/core/cores.dart';
import '../providers/reservas_provider.dart';
import '../widgets/reservas_segment.dart';
import '../widgets/ticket_item.dart';

class ReservasPage extends StatelessWidget {
  const ReservasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final reservasProvider = Provider.of<ReservasProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mis Reservas",
          style: semibold(blackBeePay, 24),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const ReservasSegment(), // Selector de segmentos
            reservasProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : reservasProvider.indexSegmentSelected == 0
                    ? _buildList(reservasProvider.tickets)
                    : _buildList(reservasProvider.reservas),
          ],
        ),
      ),
    );
  }

  Widget _buildList(List<dynamic> items) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return TicketItem(
          title: items[index].toString(),
          onTap: () => print("Ver detalles de ${items[index]}"),
        );
      },
    );
  }
}
