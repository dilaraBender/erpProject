import 'package:flutter/material.dart';
import 'package:ornek/customer/customer_profile.dart';
import 'package:ornek/customer/customer_settings.dart';
import 'package:ornek/customer/customer_info.dart';
import 'package:ornek/customer/customer_date.dart';
import 'package:ornek/widgets/app_bar.dart';
import 'package:ornek/widgets/home_button.dart';

// CustomerHome : Müşterilerin ana menüsü buttonHome widgeti ile yapıldı
class CustomerHome extends StatefulWidget {
  const CustomerHome({super.key});

  @override
  State<CustomerHome> createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {
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
              icon: Icons.calendar_month,
              title: 'Randevularım',
              color: Colors.brown,
              func: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CustomerDate()),
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
                  MaterialPageRoute(builder: (_) => const CustomerProfile()),
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
              icon: Icons.info_outline,
              title: 'Hakkımızda',
              color: Colors.blue,
              func: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Info()),
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
                  MaterialPageRoute(builder: (_) => const CustomerSettings()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
