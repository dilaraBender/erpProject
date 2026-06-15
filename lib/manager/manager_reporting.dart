// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:ornek/report/bayi_report.dart';
import 'package:ornek/report/customer_report.dart';
import 'package:ornek/report/appointment_report.dart';
import 'package:ornek/report/edication_report.dart';
import 'package:ornek/report/finance_report.dart';
import 'package:ornek/widgets/app_bar.dart';
import 'package:ornek/widgets/home_button.dart';

// ManagerReporting : yönetici rapor ana ekranı
class ManagerReporting extends StatefulWidget {
  final int userId;

  const ManagerReporting({super.key, required this.userId});

  @override
  State<ManagerReporting> createState() => _ManagerReportingState();
}

class _ManagerReportingState extends State<ManagerReporting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(userId: widget.userId),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  // İstersen SummaryCard ekleyebilirsin
                  SizedBox(width: 8),
                ],
              ),
            ),

            const SizedBox(height: 16),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Rapor Modülleri",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  homeButton(
                    icon: Icons.people,
                    title: 'Müşteri Raporları',
                    color: Colors.indigo,
                    func: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => CustomerReport()),
                      );
                    },
                  ),

                  homeButton(
                    icon: Icons.attach_money,
                    title: 'Finans Raporları',
                    color: Colors.green,
                    func: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => FinanceReport()),
                      );
                    },
                  ),

                  homeButton(
                    icon: Icons.calendar_month,
                    title: 'Randevu Raporları',
                    color: Colors.brown,
                    func: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => AppointmentReport()),
                      );
                    },
                  ),

                  homeButton(
                    icon: Icons.store,
                    title: 'Bayi Raporları',
                    color: Colors.blue,
                    func: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => BayiReport()),
                      );
                    },
                  ),

                  homeButton(
                    icon: Icons.school,
                    title: 'Eğitim Raporları',
                    color: Colors.teal,
                    func: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const EducationVideoReport(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
