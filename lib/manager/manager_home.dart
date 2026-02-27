import 'package:flutter/material.dart';
import 'package:ornek/manager/manager_bayi_list.dart';
import 'package:ornek/manager/manager_date_list.dart';
import 'package:ornek/manager/manager_edication.dart';
import 'package:ornek/manager/manager_finance.dart';
import 'package:ornek/manager/manager_profile.dart';
import 'package:ornek/manager/manager_reporting.dart';
import 'package:ornek/manager/manager_settings.dart';
import 'package:ornek/manager/manager_user_list.dart';
import 'package:ornek/widgets/app_bar.dart';
import 'package:ornek/widgets/home_button.dart';

// ManagerHome : Yöneticilerin ana menüsü buttonHome widgeti ile yapıldı
class ManagerHome extends StatelessWidget {
  const ManagerHome({super.key});

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
              icon: Icons.people,
              title: 'Kullanıcı Yönetimi',
              color: Colors.indigo,
              func: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ManagerUserList()),
                );
              },
            ),
            homeButton(
              icon: Icons.calendar_month,
              title: 'Randevu Yönetimi',
              color: Colors.brown,
              func: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ManagerDateList()),
                );
              },
            ),
            homeButton(
              icon: Icons.store,
              title: 'Bayi Yönetimi',
              color: Colors.blueGrey,
              func: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ManagerBayiList()),
                );
              },
            ),
            homeButton(
              icon: Icons.support_agent,
              title: 'Destek Mesajları',
              color: Colors.grey,
              func: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Yakında aktif olacak")),
                );
              },
            ),
            homeButton(
              icon: Icons.analytics,
              title: 'Raporlama',
              color: Colors.deepPurple,
              func: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ManagerReporting()),
                );
              },
            ),
            homeButton(
              icon: Icons.school,
              title: 'Eğitim Yönetimi',
              color: Colors.teal,
              func: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ManagerEdication()),
                );
              },
            ),
            homeButton(
              icon: Icons.attach_money,
              title: 'Gelir & Fatura',
              color: Colors.green,
              func: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ManagerFinance()),
                );
              },
            ),
            homeButton(
              icon: Icons.person,
              title: 'Profilim',
              color: Colors.orange,
              func: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ManagerProfile()),
                );
              },
            ),
            homeButton(
              icon: Icons.settings,
              title: 'Ayarlar',
              color: Colors.grey,
              func: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ManagerSettings()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
