import 'package:flutter/material.dart';
import 'package:ornek/manager/manager_date_details.dart';
import 'package:ornek/widgets/app_bar.dart';

// ManagerDateList : yönetici için randevuların listelendiği ve filtrelendiği sayfa

class ManagerDateList extends StatefulWidget {
  const ManagerDateList({super.key});
  @override
  State<ManagerDateList> createState() => _ManagerDateListState();
}

class _ManagerDateListState extends State<ManagerDateList> {
  DateTime? selectedDate;

  // tarih seçimi içim kullanılan fonk.
  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Bayi veya Müşteri ara...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 70,
              child: InkWell(
                onTap: _pickDate,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Tarihe Göre Filtrele',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                  child: Text(
                    selectedDate == null
                        ? 'Tarih Seç'
                        : '${selectedDate!.day}.${selectedDate!.month}.${selectedDate!.year}',
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 70,
              child: DropdownButtonFormField<String>(
                items: const [],
                onChanged: (value) {},
                decoration: InputDecoration(
                  labelText: 'Bayiye Göre Filtrele',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 70,
              child: DropdownButtonFormField<String>(
                items: const [],
                onChanged: (value) {},
                decoration: InputDecoration(
                  labelText: 'Müşteriye Göre Filtrele',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 70,
              child: DropdownButtonFormField<String>(
                items: const [],
                onChanged: (value) {},
                decoration: InputDecoration(
                  labelText: 'Randevu Durumuna Göre Filtrele',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            DataTable(
              columns: const [
                DataColumn(label: Text('Tarih')),
                DataColumn(label: Text('Müşteri')),
                DataColumn(label: Text('Bayi')),
                DataColumn(label: Text('Durum')),
                DataColumn(label: Text('Detay')),
              ],
              rows: const [],
            ),

            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ManagerDateDetails()),
                );
              },
              child: const Icon(Icons.book),
            ),
          ],
        ),
      ),
    );
  }
}
