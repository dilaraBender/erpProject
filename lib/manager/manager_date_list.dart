import 'package:flutter/material.dart';
import 'package:ornek/models/appointment_filter_model.dart';
import 'package:ornek/models/appointment_model.dart';
import 'package:ornek/services/appointment_list.dart';
import 'package:ornek/widgets/app_bar.dart';
import 'package:ornek/widgets/appointment.dart';
import 'package:ornek/widgets/create_appointment.dart';

// ManagerDateList : yönetici için randevuların listelendiği ve filtrelendiği sayfa
class ManagerDateList extends StatefulWidget {
  final int userId;
  const ManagerDateList({super.key, required this.userId});
  @override
  State<ManagerDateList> createState() => _ManagerDateListState();
}

class _ManagerDateListState extends State<ManagerDateList> {
  final TextEditingController binaController = TextEditingController();
  final TextEditingController binaAdresController = TextEditingController();
  final TextEditingController notController = TextEditingController();
  List<AppointmentModel> appointments = [];
  @override
  void initState() {
    super.initState();
    _applyFilters(); // ilk yükleme
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
        customerId: customerId,
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
      debugPrint("Manager randevu yükleme hatası: $e");
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
            // CREATE
            AppointmentForm(
              userId: widget.userId,
              customerId: 0,
              isBayi: true,
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
