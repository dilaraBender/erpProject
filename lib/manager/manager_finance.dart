import 'package:flutter/material.dart';
import 'package:ornek/manager/manager_finance_add.dart';
import 'package:ornek/widgets/app_bar.dart';

// ManagerFinance : yönetici için gelir-gider işlemlerinin listelendiği ve filtrelenebildiği sayfa
class ManagerFinance extends StatefulWidget {
  const ManagerFinance({super.key});

  @override
  State<ManagerFinance> createState() => _ManagerFinanceState();
}

class _ManagerFinanceState extends State<ManagerFinance> {
  String selectedDateFilter = "Tümü";
  String selectedFinanceFilter = "Tümü";

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
                      Text(
                        'Toplam Gelir',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      SizedBox(height: 12),

                      Text('100.000'),

                      SizedBox(height: 12),
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
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Toplam Gider',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      SizedBox(height: 12),

                      Text('20.000'),

                      SizedBox(height: 12),
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
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Toplam Kazanç',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      SizedBox(height: 12),

                      Text('80.000'),

                      SizedBox(height: 12),
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
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Ara...",
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      SizedBox(height: 15),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: ["Bu Ay", "Bu Yıl", "Tümü"].map((type) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: ChoiceChip(
                              label: Text(type),
                              selected: selectedDateFilter == type,
                              selectedColor: Colors.blue.shade200,
                              onSelected: (bool selected) {
                                setState(() {
                                  selectedDateFilter = type;
                                });
                              },
                            ),
                          );
                        }).toList(),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: ["Tümü", "Gelir", "Gider"].map((type) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: ChoiceChip(
                              label: Text(type),
                              selected: selectedFinanceFilter == type,
                              selectedColor: Colors.blue.shade200,
                              onSelected: (bool selected) {
                                setState(() {
                                  selectedFinanceFilter = type;
                                });
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              DataTable(
                columns: const [
                  DataColumn(label: Text('İşlem')),
                  DataColumn(label: Text('Fiyat')),
                  DataColumn(label: Text('Tarih')),
                  DataColumn(label: Text('Durum')),
                ],
                rows: const [],
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ManagerFinanceAdd(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Yeni İşlem Ekle"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
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
