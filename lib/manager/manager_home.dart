// ignore_for_file: use_build_context_synchronously, duplicate_ignore
import 'package:flutter/material.dart';
import 'package:ornek/manager/manager_bayi_list.dart';
import 'package:ornek/manager/manager_customer_list.dart';
import 'package:ornek/manager/manager_date_list.dart';
import 'package:ornek/manager/manager_edication.dart';
import 'package:ornek/manager/manager_finance.dart';
import 'package:ornek/manager/manager_profile.dart';
import 'package:ornek/manager/manager_reporting.dart';
import 'package:ornek/manager/manager_settings.dart';
import 'package:ornek/manager/manager_user_list.dart';
import 'package:ornek/services/active_appointment.dart';
import 'package:ornek/widgets/app_bar.dart';
import 'package:ornek/widgets/chat.dart';
import 'package:ornek/widgets/home_button.dart';
import 'package:ornek/widgets/weather.dart';
import 'package:ornek/widgets/notification_controller.dart';
import 'package:provider/provider.dart';

// ManagerHome : Yöneticilerin ana menüsü buttonHome widgeti ile yapıldı

class ManagerHome extends StatefulWidget {
  final int userId;
  final int managerId;
  final double latitude;
  final double longitude;

  const ManagerHome({
    super.key,
    required this.userId,
    required this.managerId,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<ManagerHome> createState() => _ManagerHomeState();
}

class _ManagerHomeState extends State<ManagerHome> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<NotificationController>().load(widget.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(userId: widget.userId),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                height: 180,
                child: WeeklyWeatherWidget(
                  lat: widget.latitude,
                  lon: widget.longitude,
                ),
              ),

              const SizedBox(height: 16),

              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  homeButton(
                    icon: Icons.people,
                    title: 'Kullanıcı Yönetimi',
                    color: Colors.indigo,
                    func: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ManagerUserList(userId: widget.userId),
                        ),
                      );
                    },
                  ),

                  homeButton(
                    icon: Icons.calendar_month,
                    title: 'Müşteri Yönetimi',
                    color: Colors.brown,
                    func: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ManagerCustomerList(userId: widget.userId),
                        ),
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
                        MaterialPageRoute(
                          builder: (_) =>
                              ManagerDateList(userId: widget.userId),
                        ),
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
                        MaterialPageRoute(
                          builder: (_) =>
                              ManagerBayiList(userId: widget.userId),
                        ),
                      );
                    },
                  ),

                  homeButton(
                    icon: Icons.support_agent,
                    title: 'Destek',
                    color: Colors.grey,
                    func: () async {
                      final appointment =
                          await ActiveAppointmentService.getActiveAppointment(
                            widget.userId,
                          );

                      if (appointment == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Aktif chat bulunamadı"),
                          ),
                        );
                        return;
                      }

                      if (!appointment.canChat) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Chat henüz aktif değil"),
                          ),
                        );
                        return;
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatPage(
                            chatRoomId:
                                appointment.appointmentId, // 👈 BURASI KRİTİK
                            userId: widget.userId,
                          ),
                        ),
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
                        MaterialPageRoute(
                          builder: (_) =>
                              ManagerReporting(userId: widget.userId),
                        ),
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
                        MaterialPageRoute(
                          builder: (_) =>
                              ManagerEdication(userId: widget.userId),
                        ),
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
                        MaterialPageRoute(
                          builder: (_) => ManagerFinance(userId: widget.userId),
                        ),
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
                        MaterialPageRoute(
                          builder: (_) => ManagerProfile(userId: widget.userId),
                        ),
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
                        MaterialPageRoute(
                          builder: (_) =>
                              ManagerSettings(userId: widget.userId),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
