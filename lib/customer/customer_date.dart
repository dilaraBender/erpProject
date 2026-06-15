import 'package:flutter/material.dart';
import 'package:ornek/models/appointment_filter_model.dart';
import 'package:ornek/models/appointment_model.dart';
import 'package:ornek/services/appointment_list.dart';
import 'package:ornek/widgets/app_bar.dart';
import 'package:ornek/widgets/appointment.dart';
import 'package:ornek/widgets/create_appointment.dart';

// CustomerDate : müşterinin randevu listeleme + filtre + harita ekranı
class CustomerDate extends StatefulWidget {
  final int userId;
  final int customerId;

  const CustomerDate({
    super.key,
    required this.userId,
    required this.customerId,
  });

  @override
  State<CustomerDate> createState() => _CustomerDateState();
}

class _CustomerDateState extends State<CustomerDate> {
  final TextEditingController binaController = TextEditingController();
  final TextEditingController binaAdresController = TextEditingController();
  final TextEditingController notController = TextEditingController();

  List<AppointmentModel> appointments = [];

  @override
  void initState() {
    super.initState();

    _applyFilters(customerId: widget.customerId);
  }

  Future<void> _applyFilters({
    int? bayiId,
    int? customerId,
    int? buildingId,
    String? status,
    DateTime? selectedDate,
  }) async {
    try {
      final filters = AppointmentFilterModel(
        bayiId: bayiId,
        customerId: customerId ?? widget.customerId,
        buildingId: buildingId,
        status: status,
        startDate: selectedDate,
        endDate: selectedDate,
      );

      final result = await AppointmentListService.fetchAppointments(filters);

      if (!mounted) return;

      setState(() {
        appointments = result;
      });
    } catch (e) {
      debugPrint("Customer randevu yükleme hatası: $e");
    }
  }

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
      length: 2,
      child: Scaffold(
        appBar: AppBarWidget(
          userId: widget.userId,
          tabBar: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.add), text: 'Yeni'),
              Tab(icon: Icon(Icons.schedule), text: 'Randevular'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Yeni Randevu
            AppointmentForm(
              userId: widget.userId,
              customerId: widget.customerId,
              binaController: binaController,
              binaAdresController: binaAdresController,
              notController: notController,
            ),

            Appointment(
              showBayiFilter: true,
              showCustomerFilter: true,
              userId: widget.userId,
              appointments: appointments,
              onFilter:
                  ({
                    int? bayiId,
                    int? customerId,
                    int? buildingId,
                    String? status,
                    DateTime? selectedDate,
                  }) {
                    _applyFilters(
                      bayiId: bayiId,
                      customerId: customerId,
                      buildingId: buildingId,
                      status: status,
                      selectedDate: selectedDate,
                    );
                  },
            ),
          ],
        ),
      ),
    );
  }
}
