// ignore_for_file: use_build_context_synchronously, control_flow_in_finally
import 'package:flutter/material.dart';
import 'package:ornek/models/appointment_filter_model.dart';
import 'package:ornek/models/appointment_model.dart';
import 'package:ornek/services/appointment_list.dart';
import 'package:ornek/services/update_appointment.dart';
import 'package:ornek/widgets/app_bar.dart';

// BayiAccept : ilgili bayinin beklemede olan randevuları kabul edip red edeceği sayfa
class BayiAccept extends StatefulWidget {
  final int userId;
  final int bayiId;

  const BayiAccept({super.key, required this.userId, required this.bayiId});

  @override
  State<BayiAccept> createState() => _BayiAcceptState();
}

class _BayiAcceptState extends State<BayiAccept> {
  List<AppointmentModel> appointments = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    setState(() => isLoading = true);

    try {
      final request = AppointmentFilterModel(
        bayiId: widget.bayiId,
        status: "pending",
      );

      appointments = await AppointmentListService.fetchAppointments(request);
    } catch (e) {
      debugPrint("Hata: $e");
    } finally {
      if (!mounted) return;
      setState(() => isLoading = false);
    }
  }

  Future<void> handleAppointment(
    int appointmentId,
    String status,
    String message,
  ) async {
    try {
      final result = await UpdateAppointmentService.updateStatus(
        appointmentId: appointmentId,
        status: status,
      );

      if (result) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));

        await fetchAppointments();
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("İşlem başarısız")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(userId: widget.userId),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : appointments.isEmpty
            ? const Center(child: Text("Randevu yok"))
            : ListView.builder(
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  final item = appointments[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Müşteri: ${item.customerName}"),
                          Text("Tarih: ${item.appDate}"),
                          Text("Bina: ${item.buildingTitle}"),

                          const SizedBox(height: 12),

                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () => handleAppointment(
                                    item.appointmentId,
                                    "approved",
                                    "Randevu Onaylandı",
                                  ),
                                  child: const Text("Onayla"),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  onPressed: () => handleAppointment(
                                    item.appointmentId,
                                    "Rejected",
                                    "Randevu Reddedildi",
                                  ),
                                  child: const Text("Red"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
