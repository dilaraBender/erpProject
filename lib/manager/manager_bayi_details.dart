import 'package:flutter/material.dart';
import 'package:ornek/widgets/app_bar.dart';

// ManagerBAyiDetails : yönetici için bayilerin detay bilgilerinin bulunduğu sayfa

class ManagerBayiDetails extends StatefulWidget {
  const ManagerBayiDetails({super.key});
  @override
  State<ManagerBayiDetails> createState() => _ManagerBayiDetailsState();
}

class _ManagerBayiDetailsState extends State<ManagerBayiDetails> {
  // Controller
  final TextEditingController bayiMailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController bayiNameController = TextEditingController();
  final TextEditingController bayiPhoneController = TextEditingController();
  final TextEditingController bayiController = TextEditingController();
  final TextEditingController sumMonyController = TextEditingController();
  final TextEditingController sumDateController = TextEditingController();
  final TextEditingController monthMonyController = TextEditingController();
  final TextEditingController monthDateController = TextEditingController();
  final TextEditingController firmaNameController = TextEditingController();
  final TextEditingController firmaAdresController = TextEditingController();
  final TextEditingController firmaIlController = TextEditingController();
  final TextEditingController firmaTaxNoController = TextEditingController();
  final TextEditingController firmaTaxController = TextEditingController();

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
                      const Text('Ankara Bayiliği'),

                      TextFormField(
                        controller: bayiNameController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Yönetici Adı: User Name',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextFormField(
                        controller: bayiPhoneController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'İletişim Numarası: 55555555',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextFormField(
                        controller: bayiMailController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Mail Adresi: @gmail',
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
                      const Text('Firma Bilgileri'),

                      TextFormField(
                        controller: firmaNameController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText:
                              'Firma Adı: Pata Technology Ankara Bayiliği',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextFormField(
                        controller: firmaTaxNoController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Vergi Numarası : 55555555',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextFormField(
                        controller: firmaTaxController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Vergi Dairesi: Ankara - Bilkent',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextFormField(
                        controller: firmaAdresController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Adres: Ankara - Bilkent',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextFormField(
                        controller: firmaIlController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'İl/İlçe: Ankara/Bilkent',
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
                      const Text('Performans'),

                      TextFormField(
                        controller: sumDateController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Toplam Randevu : 120',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextFormField(
                        controller: sumMonyController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Toplam Kazanç : 1.500.000',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextFormField(
                        controller: monthDateController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Aylık Randevu: 15',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextFormField(
                        controller: monthMonyController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Aylık Kazanç: 120.000',
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
