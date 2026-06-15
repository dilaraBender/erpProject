// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:ornek/models/create_appointment_model.dart';
import 'package:ornek/models/drop_down_bayi_model.dart';
import 'package:ornek/models/drop_down_building_model.dart';
import 'package:ornek/models/drop_down_customer_model.dart';
import 'package:ornek/services/create_appointment.dart';
import 'package:ornek/services/drop_down.dart';
import 'package:ornek/services/notification.dart';
import 'package:ornek/widgets/show_message.dart';

class AppointmentForm extends StatefulWidget {
  final int userId;
  final int customerId;
  final bool isBayi;

  final TextEditingController binaController;
  final TextEditingController binaAdresController;
  final TextEditingController notController;

  const AppointmentForm({
    super.key,
    required this.userId,
    required this.customerId,
    required this.binaController,
    required this.binaAdresController,
    required this.notController,
    this.isBayi = false,
  });

  @override
  State<AppointmentForm> createState() => _AppointmentFormState();
}

class _AppointmentFormState extends State<AppointmentForm> {
  List<DropDownBayiModel> bayiList = [];
  int? selectedBayi;

  List<DropDownCustomerModel> customerList = [];
  int? selectedCustomer;

  List<DropDownBuildingModel> buildingList = [];
  int? selectedBuilding;

  final _formKey = GlobalKey<FormState>();

  DateTime? selectedDate;

  final TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final bayiler = await DropdownService.fetchBayiler();
      final customers = await DropdownService.fetchCustomers();

      List<DropDownBuildingModel> buildings = [];

      if (!widget.isBayi) {
        buildings = await DropdownService.fetchBuildings(widget.userId);
      }

      setState(() {
        bayiList = bayiler;
        customerList = customers;
        buildingList = buildings;
      });
    } catch (e) {
      showMessage(context, "API Hatası: $e");
    }
  }

  Future<void> loadBuildings(int userId) async {
    try {
      final buildings = await DropdownService.fetchBuildings(userId);

      setState(() {
        buildingList = buildings;
        selectedBuilding = null;
      });
    } catch (e) {
      showMessage(context, "Binalar yüklenemedi");
    }
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  void _clearForm() {
    setState(() {
      selectedBayi = null;
      selectedCustomer = null;
      selectedBuilding = null;
      selectedDate = null;
      priceController.clear();

      if (!widget.isBayi) {
        loadData();
      } else {
        buildingList = [];
      }
    });

    widget.notController.clear();
    _formKey.currentState?.reset();
  }

  Future<void> _submitForm() async {
    if (selectedDate == null) {
      showMessage(context, 'Lütfen tarih seçiniz.');
      return;
    }

    if (_formKey.currentState!.validate()) {
      double price = widget.isBayi
          ? double.tryParse(priceController.text) ?? 0
          : 0;

      final appointment = CreateAppointmentModel(
        bayiId: widget.isBayi ? widget.userId : selectedBayi!,
        buildingId: selectedBuilding!,
        appDate: selectedDate!.toIso8601String(),
        appTime: DateTime.now().toIso8601String(),
        price: price,
        description: widget.notController.text,
        status: "pending",
      );

      final result = await CreateAppointmentService.createAppointment(
        appointment,
      );

      if (result) {
        showMessage(context, "Randevu Talebiniz Alındı");

        await NotificationService.createNotification(
          userId: widget.isBayi ? selectedCustomer! : selectedBayi!,
          title: "Yeni Randevu Talebi",
          body:
              "${selectedDate!.day}.${selectedDate!.month}.${selectedDate!.year} tarihli yeni randevu",
        );

        Future.delayed(const Duration(milliseconds: 300), () {
          _clearForm();
        });
      } else {
        showMessage(context, "Randevu oluşturulamadı");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              // DATE
              SizedBox(
                width: 220,
                child: InkWell(
                  onTap: _pickDate,
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Tarih Seçiniz',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    child: Text(
                      selectedDate == null
                          ? 'Tarih Seç'
                          : '${selectedDate!.day}.${selectedDate!.month}.${selectedDate!.year}',
                    ),
                  ),
                ),
              ),

              // CUSTOMER (BAYİ MODE)
              if (widget.isBayi)
                SizedBox(
                  width: 250,
                  child: DropdownButtonFormField<int>(
                    value: selectedCustomer,
                    items: customerList.map((c) {
                      return DropdownMenuItem<int>(
                        value: c.customerId,
                        child: Text(c.fullName),
                      );
                    }).toList(),
                    onChanged: (value) async {
                      setState(() {
                        selectedCustomer = value;
                      });

                      if (value != null) {
                        final selected = customerList.firstWhere(
                          (c) => c.customerId == value,
                        );

                        await loadBuildings(selected.userId);
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Müşteri Seçiniz',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

              // BAYI (CUSTOMER MODE)
              if (!widget.isBayi)
                SizedBox(
                  width: 250,
                  child: DropdownButtonFormField<int>(
                    value: selectedBayi,
                    items: bayiList.map((b) {
                      return DropdownMenuItem<int>(
                        value: b.bayiId,
                        child: Text(b.title),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedBayi = value;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Bayi Seçiniz',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

              // BUILDING
              SizedBox(
                width: 250,
                child: DropdownButtonFormField<int>(
                  value: selectedBuilding,
                  items: buildingList.map((b) {
                    return DropdownMenuItem<int>(
                      value: b.buildingId,
                      child: Text(b.title),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedBuilding = value;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Bina Seçiniz',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              // NOTE
              SizedBox(
                width: 300,
                child: TextFormField(
                  controller: widget.notController,
                  decoration: const InputDecoration(
                    labelText: 'Not',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              // PRICE (BAYİ)
              if (widget.isBayi)
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Fiyat (₺)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

              ElevatedButton(
                onPressed: _submitForm,
                child: const Text("Randevu Oluştur"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
