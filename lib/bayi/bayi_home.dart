// ignore_for_file: use_build_context_synchronously, duplicate_ignore
import 'package:flutter/material.dart';
import 'package:ornek/bayi/bayi_date_list.dart';
import 'package:ornek/bayi/bayi_edication.dart';
import 'package:ornek/bayi/bayi_finance.dart';
import 'package:ornek/bayi/bayi_profile.dart';
import 'package:ornek/bayi/bayi_accept.dart';
import 'package:ornek/bayi/bayi_settings.dart';
import 'package:ornek/services/active_appointment.dart';
import 'package:ornek/widgets/app_bar.dart';
import 'package:ornek/widgets/chat.dart';
import 'package:ornek/widgets/home_button.dart';
import 'package:ornek/widgets/weather.dart';
import 'package:ornek/widgets/notification_controller.dart';
import 'package:provider/provider.dart';

// BayiHome : homeButton widgeti kullanılarak oluşturulan ana menü
class BayiHome extends StatefulWidget {
  final int userId;
  final int bayiId;
  final double latitude;
  final double longitude;

  const BayiHome({
    super.key,
    required this.userId,
    required this.bayiId,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<BayiHome> createState() => _BayiHomeState();
}

class _BayiHomeState extends State<BayiHome> {
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
                    icon: Icons.event_note,
                    title: 'Randevu Talepleri',
                    color: Colors.deepOrangeAccent,
                    func: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BayiAccept(
                            userId: widget.userId,
                            bayiId: widget.bayiId,
                          ),
                        ),
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
                        MaterialPageRoute(
                          builder: (_) => BayiDate(
                            userId: widget.userId,
                            bayiId: widget.bayiId,
                          ),
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
                          builder: (_) => BayiFinance(userId: widget.userId),
                        ),
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
                        MaterialPageRoute(
                          builder: (_) => BayiEdication(
                            userId: widget.userId,
                            bayiId: widget.bayiId,
                          ),
                        ),
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
                        MaterialPageRoute(
                          builder: (_) => BayiProfile(
                            userId: widget.userId,
                            bayiId: widget.bayiId,
                          ),
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
                    icon: Icons.settings,
                    title: 'Ayarlar',
                    color: Colors.grey,
                    func: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BayiSettings(
                            userId: widget.userId,
                            bayiId: widget.bayiId,
                          ),
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
