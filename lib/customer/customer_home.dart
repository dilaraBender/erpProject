// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:ornek/customer/customer_building.dart';
import 'package:ornek/customer/customer_profile.dart';
import 'package:ornek/customer/customer_settings.dart';
import 'package:ornek/customer/customer_info.dart';
import 'package:ornek/customer/customer_date.dart';
import 'package:ornek/models/rate_appointment_model.dart';
import 'package:ornek/services/active_appointment.dart';
import 'package:ornek/services/rate_appointment.dart';
import 'package:ornek/services/yesterday_appointment.dart';
import 'package:ornek/widgets/app_bar.dart';
import 'package:ornek/widgets/chat.dart';
import 'package:ornek/widgets/home_button.dart';
import 'package:ornek/widgets/rating.dart';
import 'package:ornek/widgets/weather.dart';
import 'package:ornek/widgets/notification_controller.dart';
import 'package:provider/provider.dart';

// CustomerHome : Müşteri ana ekranı
class CustomerHome extends StatefulWidget {
  final int userId;
  final int customerId;
  final double latitude;
  final double longitude;

  const CustomerHome({
    super.key,
    required this.userId,
    required this.customerId,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<CustomerHome> createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {
  bool _ratingShown = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  void _init() {
    if (!mounted) return;

    context.read<NotificationController>().load(widget.userId);
    _checkYesterdayAppointment();
  }

  Future<void> _checkYesterdayAppointment() async {
    if (_ratingShown) return;

    try {
      final appointment = await YesterdayAppointmentService.getYesterday();

      if (!mounted || appointment == null) return;

      _ratingShown = true;

      await Future.delayed(const Duration(milliseconds: 300));

      if (!mounted) return;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          return YesterdayAppointmentRatingDialog(
            appointment: appointment,
            onSubmit: (rating) async {
              try {
                final model = RateAppointmentModel(
                  appointmentId: appointment.appointmentId,
                  rating: rating,
                );

                await RateAppointmentService.rateAppointment(model);
              } catch (e) {
                debugPrint("RATE ERROR: $e");
              }

              if (Navigator.of(dialogContext).canPop()) {
                Navigator.of(dialogContext).pop();
              }
            },
          );
        },
      );
    } catch (e, s) {
      debugPrint("YESTERDAY ERROR: $e");
      debugPrint("$s");
    }
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
                    icon: Icons.calendar_month,
                    title: 'Randevularım',
                    color: Colors.brown,
                    func: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CustomerDate(
                            userId: widget.userId,
                            customerId: widget.customerId,
                          ),
                        ),
                      );
                    },
                  ),

                  homeButton(
                    icon: Icons.build,
                    title: 'Binalarım',
                    color: Colors.white,
                    func: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CustomerBuilding(
                            userId: widget.userId,
                            customerId: widget.customerId,
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
                          builder: (_) => CustomerProfile(
                            userId: widget.userId,
                            customerId: widget.customerId,
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
                            chatRoomId: appointment.appointmentId,
                            userId: widget.userId,
                          ),
                        ),
                      );
                    },
                  ),

                  homeButton(
                    icon: Icons.info_outline,
                    title: 'Hakkımızda',
                    color: Colors.blue,
                    func: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Info(userId: widget.userId),
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
                          builder: (_) => CustomerSettings(
                            userId: widget.userId,
                            customerId: widget.customerId,
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
