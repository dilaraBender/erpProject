import 'package:flutter/material.dart';
import 'package:ornek/widgets/show_message.dart';

// CustomerNewDate : Müşterilerin randevu talebi oluşturduğu ekran

class CustomerNewDate extends StatefulWidget {
  //controller
  final TextEditingController binaController;
  final TextEditingController binaAdresController;
  final TextEditingController notController;

  const CustomerNewDate({
    super.key,
    required this.binaController,
    required this.binaAdresController,
    required this.notController,
  });

  @override
  State<CustomerNewDate> createState() => _CustomerNewDateState();
}

class _CustomerNewDateState extends State<CustomerNewDate> {
  final _formKey = GlobalKey<FormState>();

  DateTime? selectedDate;
  String? selectedBayi;

  // Tarih seçimi için kullanılan fonk.
  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      // varsayılan tarih
      initialDate: DateTime.now(),
      // Başalngıç tarihi
      firstDate: DateTime.now(),
      // son tarih
      lastDate: DateTime(2030),
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  // kontroller
  void _submitForm() {
    if (selectedDate == null) {
      showMessage(context, 'Lütfen tarih seçiniz.');
      return;
    }

    if (_formKey.currentState!.validate()) {
      showMessage(context, 'Randevu Talebiniz Alındı, Geri Dönüş Sağlanacak.');
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
              SizedBox(
                width: 200,
                child: InkWell(
                  onTap: _pickDate,
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Tarih Seçiniz',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffixIcon: const Icon(Icons.calendar_today),
                      errorText: selectedDate == null ? 'Tarih seçiniz' : null,
                    ),
                    child: Text(
                      selectedDate == null
                          ? 'Tarih Seç'
                          : '${selectedDate!.day}.${selectedDate!.month}.${selectedDate!.year}',
                    ),
                  ),
                ),
              ),

              SizedBox(
                width: 250,
                child: DropdownButtonFormField<String>(
                  value: selectedBayi,
                  items: const [
                    DropdownMenuItem(value: "Bayi 1", child: Text("Bayi 1")),
                    DropdownMenuItem(value: "Bayi 2", child: Text("Bayi 2")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedBayi = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Bayi Seçiniz',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Lütfen bayi seçiniz';
                    }
                    return null;
                  },
                ),
              ),

              SizedBox(
                width: 300,
                child: TextFormField(
                  controller: widget.binaController,
                  decoration: const InputDecoration(
                    labelText: 'Bina',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bina adı boş bırakılamaz';
                    }
                    return null;
                  },
                ),
              ),

              SizedBox(
                width: 300,
                child: TextFormField(
                  controller: widget.binaAdresController,
                  decoration: const InputDecoration(
                    labelText: 'Bina Detaylı Adresi',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Adres boş bırakılamaz';
                    }
                    return null;
                  },
                ),
              ),

              SizedBox(
                width: 300,
                child: TextFormField(
                  controller: widget.notController,
                  decoration: const InputDecoration(
                    labelText: 'Not',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Not alanı boş bırakılamaz';
                    }
                    return null;
                  },
                ),
              ),

              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Randevu Talebi Oluştur'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
