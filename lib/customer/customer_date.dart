import 'package:flutter/material.dart';
import 'package:ornek/widgets/app_bar.dart';
import 'package:ornek/widgets/appointment.dart';
import 'package:ornek/customer/customer_new_date.dart';

// CustomerDate : müşterilerin randevularını listelediği ekran
class CustomerDate extends StatefulWidget {
  const CustomerDate({super.key});

  @override
  State<CustomerDate> createState() => _CustomerDateState();
}

class _CustomerDateState extends State<CustomerDate> {
  // controller
  final TextEditingController binaController = TextEditingController();
  final TextEditingController binaAdresController = TextEditingController();
  final TextEditingController notController = TextEditingController();

  // controller sonradan yok edilecek
  @override
  void dispose() {
    binaController.dispose();
    binaAdresController.dispose();
    notController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBarWidget(
          tabBar: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.add), text: 'Yeni Randevu'),
              Tab(icon: Icon(Icons.schedule), text: 'Aktif'),
              Tab(icon: Icon(Icons.history), text: 'Geçmiş'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Yeni Randevu
            CustomerNewDate(
              binaController: binaController,
              binaAdresController: binaAdresController,
              notController: notController,
            ),

            // Aktif Randevular
            Appointment(showBayiFilter: false, showCustomerFilter: false),

            // Geçmiş Randevular
            Appointment(showBayiFilter: false, showCustomerFilter: false),
          ],
        ),
      ),
    );
  }
}
