import 'package:flutter/material.dart';
import 'package:ornek/widgets/create_appointment.dart';

// BayiAddDate : bayinin randevu oluşturabileceği sayfa
class BayiAddDate extends StatelessWidget {
  final int bayiId;
  final int userId;

  BayiAddDate({super.key, required this.bayiId, required this.userId});

  final TextEditingController binaController = TextEditingController();

  final TextEditingController binaAdresController = TextEditingController();

  final TextEditingController notController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bayi Randevu Talebi")),

      body: AppointmentForm(
        userId: bayiId,
        customerId: 0,
        isBayi: true,
        binaController: binaController,
        binaAdresController: binaAdresController,
        notController: notController,
      ),
    );
  }
}
