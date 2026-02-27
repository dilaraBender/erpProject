import 'package:flutter/material.dart';
import 'package:ornek/widgets/app_bar.dart';
import 'package:ornek/widgets/appointment.dart';

// BayiDate : Randevuların listelendiği yer

class BayiDate extends StatefulWidget {
  const BayiDate({super.key});

  @override
  State<BayiDate> createState() => _BayiDateState();
}

class _BayiDateState extends State<BayiDate> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBarWidget(
          tabBar: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.schedule), text: 'Aktif'),
              Tab(icon: Icon(Icons.history), text: 'Geçmiş'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Aktif Randevular
            Appointment(showBayiFilter: false, showCustomerFilter: true),

            // Geçmiş Randevular
            Appointment(showBayiFilter: false, showCustomerFilter: true),
          ],
        ),
      ),
    );
  }
}
