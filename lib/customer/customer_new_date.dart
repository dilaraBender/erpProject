import 'package:flutter/material.dart';
import 'package:ornek/widgets/create_appointment.dart';

// CustomerPage : Müşterinin randevu talebi oluşturacagı sayfa
class CustomerPage extends StatelessWidget {
  final int userId;
  final int customerId;

  CustomerPage({super.key, required this.userId, required this.customerId});

  final TextEditingController binaController = TextEditingController();
  final TextEditingController binaAdresController = TextEditingController();
  final TextEditingController notController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Müşteri Randevu Talebi")),
      body: AppointmentForm(
        userId: userId,
        customerId: customerId,
        binaController: binaController,
        binaAdresController: binaAdresController,
        notController: notController,
      ),
    );
  }
}
