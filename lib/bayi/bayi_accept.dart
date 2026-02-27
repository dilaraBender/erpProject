import 'package:flutter/material.dart';
import 'package:ornek/widgets/app_bar.dart';

// BayiAccept : Bayilerin müşterilerin randevu taleplerini görüp randevuları onaylayıp reddedebildiği ekran
class BayiAccept extends StatefulWidget {
  const BayiAccept({super.key});

  @override
  State<BayiAccept> createState() => _BayiAcceptState();
}

class _BayiAcceptState extends State<BayiAccept> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),

              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Müşteri: Dilara BENDER'),

                    SizedBox(height: 12),

                    Text('Tarih/Saat: 10.11.2022-21.00'),

                    SizedBox(height: 12),

                    Text('Bina-Adres: Ataşehir-B Blok'),

                    SizedBox(height: 12),

                    // butonları yan yana konumlandırmak için Row
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text('Onayla'),
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text('Red Et'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Müşteri: Dilara BENDER'),

                    SizedBox(height: 12),

                    Text('Tarih/Saat: 10.11.2022-21.00'),

                    SizedBox(height: 12),

                    Text('Bina-Adres: Ataşehir-B Blok'),

                    SizedBox(height: 12),

                    // butonları yan yana konumlandırmak için Row
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text('Onayla'),
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text('Red Et'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
