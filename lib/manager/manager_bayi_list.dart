import 'package:flutter/material.dart';
import 'package:ornek/manager/manager_bayi_details.dart';
import 'package:ornek/manager/manager_user.dart';
import 'package:ornek/widgets/app_bar.dart';

// ManagerBayiList : yönetici için bayileri listeleyip filtreleme sayfası

class ManagerBayiList extends StatefulWidget {
  const ManagerBayiList({super.key});
  @override
  State<ManagerBayiList> createState() => _ManagerBayiListState();
}

class _ManagerBayiListState extends State<ManagerBayiList> {
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
                hintText: "Bayi ara...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            SizedBox(height: 15),

            SizedBox(
              height: 80,
              child: DropdownButtonFormField<String>(
                items: const [],
                onChanged: (value) {},
                decoration: InputDecoration(
                  labelText: 'Duruma Göre Filtrele',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            DataTable(
              columns: const [
                DataColumn(label: Text('Bayi Adı')),
                DataColumn(label: Text('İletişim')),
                DataColumn(label: Text('Durum(Aktif-Pasif)')),
                DataColumn(label: Text('İşlem')),
                DataColumn(label: Text('Detay')),
              ],
              rows: const [],
            ),

            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ManagerBayiDetails()),
                );
              },
              child: const Icon(Icons.book),
            ),

            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ManagerUser()),
                );
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
