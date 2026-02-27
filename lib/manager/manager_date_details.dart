import 'package:flutter/material.dart';
import 'package:ornek/widgets/app_bar.dart';

// ManagerDateDetails : yönetici için randevuların detaylarının gösterildiği sayfa

class ManagerDateDetails extends StatefulWidget {
  const ManagerDateDetails({super.key});
  @override
  State<ManagerDateDetails> createState() => _ManagerDateDetailsState();
}

class _ManagerDateDetailsState extends State<ManagerDateDetails> {
  // controller
  final TextEditingController dateController = TextEditingController();
  final TextEditingController moneyController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController notsController = TextEditingController();
  final TextEditingController bayiController = TextEditingController();
  final TextEditingController customerController = TextEditingController();
  final TextEditingController bayiPhoneController = TextEditingController();
  final TextEditingController bayiStatusController = TextEditingController();
  final TextEditingController customerPhoneController = TextEditingController();
  final TextEditingController customerMailController = TextEditingController();
  final TextEditingController adresController = TextEditingController();
  final TextEditingController bayiMailController = TextEditingController();

  String selectedRole = 'musteri';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text('Randevu Bilgileri'),

                      TextFormField(
                        controller: dateController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Randevu Tarihi: 12 Şubat 2026',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextFormField(
                        controller: moneyController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Fiyat: 120.000',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextFormField(
                        controller: adresController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Adres: Bursa Millet mah.',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextFormField(
                        controller: statusController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Durum: Tamamlandı',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextFormField(
                        controller: notsController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Not: Yok',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 15),

              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text('Müşteri Bilgileri'),

                      TextFormField(
                        controller: customerController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Müşteri: Ad Soyad',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextFormField(
                        controller: customerPhoneController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Telefon Numarası : 555555',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextFormField(
                        controller: customerMailController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Mail: @gmail.com',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 15),

              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text('Bayi Bilgileri'),
                      TextFormField(
                        controller: bayiController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Bayi Adı: Ankara Bayiliği',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextFormField(
                        controller: bayiPhoneController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Telefon Numarası: 555555',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextFormField(
                        controller: bayiMailController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Mail Adresi: @gmail.com',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextFormField(
                        controller: bayiStatusController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Durum: Pasif/Aktif',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
