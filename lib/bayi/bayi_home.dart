import 'package:flutter/material.dart';
import 'package:ornek/bayi/bayi_date_list.dart';
import 'package:ornek/bayi/bayi_edication.dart';
import 'package:ornek/bayi/bayi_profile.dart';
import 'package:ornek/bayi/bayi_accept.dart';
import 'package:ornek/bayi/bayi_settings.dart';
import 'package:ornek/widgets/app_bar.dart';
import 'package:ornek/widgets/home_button.dart';

// BayiHome : homeButton widgeti kullanılarak oluşturulan ana menü
class BayiHome extends StatefulWidget {
  const BayiHome({super.key});
  @override
  State<BayiHome> createState() => _BayiHomeState();
}

class _BayiHomeState extends State<BayiHome> {
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
              icon: Icons.event_note,
              title: 'Randevu Talepleri',
              color: Colors.deepOrangeAccent,
              func: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BayiAccept()),
                );
              },
            ),

            homeButton(
              icon: Icons.calendar_month,
              title: 'Randevu Listesi',
              color: Colors.brown,
              func: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BayiDate()),
                );
              },
            ),

            homeButton(
              icon: Icons.school,
              title: 'Eğitimler',
              color: Colors.teal,
              func: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BayiEdication()),
                );
              },
            ),

            homeButton(
              icon: Icons.person,
              title: 'Profilim',
              color: Colors.white,
              func: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BayiProfile()),
                );
              },
            ),

            homeButton(
              icon: Icons.support_agent,
              title: 'Destek',
              color: Colors.grey,
              func: () {},
            ),

            homeButton(
              icon: Icons.settings,
              title: 'Ayarlar',
              color: Colors.grey,
              func: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BayiSettings()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
