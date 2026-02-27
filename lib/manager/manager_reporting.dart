import 'package:flutter/material.dart';
import 'package:ornek/widgets/app_bar.dart';
import 'package:ornek/widgets/home_button.dart';

// ManagerReporting : yönetici için rapor sayfası tüm kayıtların raporu olduğu için ayrı bir menü sayfası gibi tasarlandı
class ManagerReporting extends StatefulWidget {
  const ManagerReporting({super.key});
  @override
  State<ManagerReporting> createState() => _ManagerReportingState();
}

class _ManagerReportingState extends State<ManagerReporting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            homeButton(
              icon: Icons.attach_money,
              title: 'Finans Raporları',
              color: Colors.indigo,
              func: () {},
            ),
            homeButton(
              icon: Icons.calendar_month,
              title: 'Randevu Raporları',
              color: Colors.brown,
              func: () {},
            ),
            homeButton(
              icon: Icons.store,
              title: 'Bayi Raporları',
              color: Colors.white,
              func: () {},
            ),
            homeButton(
              icon: Icons.school,
              title: 'Eğitim Raporları',
              color: Colors.teal,
              func: () {},
            ),
          ],
        ),
      ),
    );
  }
}
