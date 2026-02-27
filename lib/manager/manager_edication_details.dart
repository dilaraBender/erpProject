import 'package:flutter/material.dart';
import 'package:ornek/widgets/app_bar.dart';

// ManagerEdicationDetails : yönetici için eğitim videolarının detay sayfası
class ManagerEdicationDetails extends StatefulWidget {
  const ManagerEdicationDetails({super.key});
  @override
  State<ManagerEdicationDetails> createState() =>
      _ManagerEdicationDetailsState();
}

class _ManagerEdicationDetailsState extends State<ManagerEdicationDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '1.Drone Eğitimi',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    SizedBox(height: 12),

                    Text('Konu: Drone Tanıma ve Ekipmanları'),

                    SizedBox(height: 12),

                    Text('Süre: 5.14'),

                    SizedBox(height: 12),
                  ],
                ),
              ),
            ),

            TextField(
              decoration: InputDecoration(
                hintText: "Bayi ara...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            SizedBox(height: 15),

            DataTable(
              columns: const [
                DataColumn(label: Text('Bayi Adı')),
                DataColumn(label: Text('Durum')),
              ],
              rows: const [],
            ),
          ],
        ),
      ),
    );
  }
}
