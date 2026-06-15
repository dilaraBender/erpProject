import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ornek/models/yesterday_appointment_model.dart';

// YesterdayAppointmentRatingDialog : önceki randevuyu değerlendirmek için sayfa
class YesterdayAppointmentRatingDialog extends StatelessWidget {
  final YesterdayAppointmentModel appointment;
  final Function(int rating) onSubmit;

  const YesterdayAppointmentRatingDialog({
    super.key,
    required this.appointment,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    double rating = 3;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

      title: const Text("Dünkü Randevu"),

      content: Column(
        mainAxisSize: MainAxisSize.min,

        children: [
          Text(
            appointment.customerName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),

          const SizedBox(height: 6),

          if (appointment.bayiName != null)
            Text(
              appointment.bayiName!,
              style: const TextStyle(color: Colors.grey),
            ),

          const SizedBox(height: 16),

          const Text("Randevuyu puanla"),

          const SizedBox(height: 12),

          RatingBar.builder(
            initialRating: 3,
            minRating: 1,
            allowHalfRating: false,
            itemCount: 5,
            itemSize: 32,

            itemBuilder: (context, _) =>
                const Icon(Icons.star, color: Colors.amber),

            onRatingUpdate: (value) {
              rating = value;
            },
          ),
        ],
      ),

      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("İptal"),
        ),

        ElevatedButton(
          onPressed: () {
            onSubmit(rating.toInt());
            Navigator.pop(context);
          },
          child: const Text("Gönder"),
        ),
      ],
    );
  }
}
