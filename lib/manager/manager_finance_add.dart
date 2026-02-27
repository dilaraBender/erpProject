import 'package:flutter/material.dart';
import 'package:ornek/widgets/app_bar.dart';

// ManagerFinanceAdd : Yönetici için gelir-gider işlemleri ekleyebileceği sayfa
class ManagerFinanceAdd extends StatefulWidget {
  const ManagerFinanceAdd({super.key});

  @override
  State<ManagerFinanceAdd> createState() => _ManagerFinanceAddState();
}

class _ManagerFinanceAddState extends State<ManagerFinanceAdd> {
  // Controller
  final TextEditingController dateController = TextEditingController();
  final TextEditingController moneyController = TextEditingController();
  final TextEditingController processController = TextEditingController();

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
                      TextFormField(
                        controller: processController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'İşlem',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "İşlem boş bırakılamaz!" : null,
                      ),

                      const SizedBox(height: 12),

                      TextFormField(
                        controller: dateController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Tarih',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "Tarih boş bırakılamaz!" : null,
                      ),

                      const SizedBox(height: 12),

                      TextFormField(
                        controller: moneyController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Fiyat',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return "Fiyat boş bırakılamaz";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 12),

                      SizedBox(
                        height: 80,
                        child: DropdownButtonFormField<String>(
                          items: const [],
                          onChanged: (value) {},
                          decoration: InputDecoration(
                            labelText: 'Gelir-Gider',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      ElevatedButton(onPressed: () {}, child: Text('Kaydet')),
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
