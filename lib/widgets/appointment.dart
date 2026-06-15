// ignore_for_file: use_build_context_synchronously, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ornek/models/appointment_model.dart';
import 'package:ornek/models/drop_down_bayi_model.dart';
import 'package:ornek/models/drop_down_customer_model.dart';
import 'package:ornek/services/drop_down.dart';
import 'package:ornek/widgets/appointment_detail.dart';
import 'package:ornek/widgets/show_message.dart';

class Appointment extends StatefulWidget {
  final bool showCustomerFilter;
  final bool showBayiFilter;
  final int userId;

  final List<AppointmentModel> appointments;

  final Function({
    int? bayiId,
    int? customerId,
    String? status,
    DateTime? selectedDate,
  })
  onFilter;

  const Appointment({
    super.key,
    required this.showBayiFilter,
    required this.showCustomerFilter,
    required this.userId,
    required this.appointments,
    required this.onFilter,
  });

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  List<DropDownBayiModel> bayiList = [];
  List<DropDownCustomerModel> customerList = [];

  String? selectedStatus;
  int? selectedBayi;
  int? selectedCustomer;
  DateTime? selectedDate;

  final List<String> statusList = [
    'pending',
    'approved',
    'completed',
    'cancelled',
    'rejected',
  ];

  @override
  void initState() {
    super.initState();
    loadDropdowns();
  }

  Future<void> loadDropdowns() async {
    try {
      final bayiler = await DropdownService.fetchBayiler();
      final customers = await DropdownService.fetchCustomers();

      if (!mounted) return;

      setState(() {
        bayiList = bayiler;
        customerList = customers;
      });
    } catch (e) {
      showMessage(context, "Dropdown yükleme hatası: $e");
    }
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });

      _applyFilters();
    }
  }

  void _applyFilters() {
    widget.onFilter(
      bayiId: selectedBayi,
      customerId: selectedCustomer,
      status: selectedStatus,
      selectedDate: selectedDate,
    );
  }

  void _autoFilter() {
    setState(() {});
    _applyFilters();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              /// DATE
              SizedBox(
                width: 200,
                child: InkWell(
                  onTap: _pickDate,
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: "Tarih",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffixIcon: const Icon(Icons.calendar_today),
                    ),
                    child: Text(
                      selectedDate == null
                          ? "Tarih Seç"
                          : DateFormat('dd.MM.yyyy').format(selectedDate!),
                    ),
                  ),
                ),
              ),

              if (widget.showBayiFilter)
                SizedBox(
                  width: 250,
                  child: DropdownButtonFormField<int>(
                    value: selectedBayi,
                    items: bayiList.map((b) {
                      return DropdownMenuItem(
                        value: b.bayiId,
                        child: Text(b.title),
                      );
                    }).toList(),
                    onChanged: (value) {
                      selectedBayi = value;
                      _autoFilter();
                    },
                    decoration: const InputDecoration(
                      labelText: "Bayi",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

              if (widget.showCustomerFilter)
                SizedBox(
                  width: 250,
                  child: DropdownButtonFormField<int>(
                    value: selectedCustomer,
                    items: customerList.map((c) {
                      return DropdownMenuItem(
                        value: c.customerId,
                        child: Text(c.fullName),
                      );
                    }).toList(),
                    onChanged: (value) {
                      selectedCustomer = value;
                      _autoFilter();
                    },
                    decoration: const InputDecoration(
                      labelText: "Müşteri",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

              SizedBox(
                width: 250,
                child: DropdownButtonFormField<String>(
                  value: selectedStatus,
                  items: statusList.map((s) {
                    return DropdownMenuItem(value: s, child: Text(s));
                  }).toList(),
                  onChanged: (value) {
                    selectedStatus = value;
                    _autoFilter();
                  },
                  decoration: const InputDecoration(
                    labelText: "Durum",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Expanded(
            child: widget.appointments.isEmpty
                ? const Center(child: Text("Randevu bulunamadı"))
                : ListView.builder(
                    itemCount: widget.appointments.length,
                    itemBuilder: (context, index) {
                      final a = widget.appointments[index];

                      return Card(
                        child: ListTile(
                          title: Text(a.buildingTitle ?? "-"),
                          subtitle: Text(
                            "${a.bayiName ?? ""} • "
                            "${a.appDate == null ? "-" : DateFormat('dd.MM.yyyy').format(a.appDate!)}",
                          ),
                          trailing: Text(a.status ?? "-"),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AppointmentDetails(
                                  userId: widget.userId,
                                  appointment: a,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
