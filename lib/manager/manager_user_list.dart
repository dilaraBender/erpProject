import 'package:flutter/material.dart';
import 'package:ornek/manager/manager_user.dart';
import 'package:ornek/widgets/app_bar.dart';

// ManagerUserList : yönetici için kullanıcıların listelendiği ve filtrelenebildiği sayfa
class ManagerUserList extends StatefulWidget {
  const ManagerUserList({super.key});
  @override
  State<ManagerUserList> createState() => _ManagerUserListState();
}

class _ManagerUserListState extends State<ManagerUserList> {
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
                hintText: "Kullanıcı ara...",
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
                  labelText: 'Role Göre Filtrele',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

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
                DataColumn(label: Text('Ad-Soyad')),
                DataColumn(label: Text('Telefon')),
                DataColumn(label: Text('Rol')),
                DataColumn(label: Text('Durum')),
              ],
              rows: const [],
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
