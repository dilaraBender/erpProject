import 'package:flutter/material.dart';

// Appointment ekranı : Randevu filtreleme ve randevu listesi için
class Appointment extends StatefulWidget {
  // Filtreleme için parametreler
  final bool showCustomerFilter;
  final bool showBayiFilter;

  const Appointment({
    super.key,
    required this.showBayiFilter,
    required this.showCustomerFilter,
  });

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  DateTime? selectedDate;

  // Tarih seçmek için kullanılan fonk.
  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      // varsayılan tarih
      initialDate: DateTime.now(),
      // en eski tarih
      firstDate: DateTime(2024),
      // en son tarih
      lastDate: DateTime(2030),
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          SizedBox(
            width: 180,
            child: InkWell(
              onTap: _pickDate,
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Tarihe Göre Filtrele',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: const Icon(Icons.calendar_today),
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
            width: 300,
            child: DropdownButtonFormField<String>(
              items: const [],
              onChanged: (value) {},
              decoration: InputDecoration(
                labelText: 'Binaya Göre Filtrele',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          if (widget.showBayiFilter)
            SizedBox(
              width: 300,
              child: DropdownButtonFormField<String>(
                items: const [],
                onChanged: (value) {},
                decoration: InputDecoration(
                  labelText: 'Bayiye Göre Filtrele',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

          SizedBox(
            width: 300,
            child: DropdownButtonFormField<String>(
              items: const [],
              onChanged: (value) {},
              decoration: InputDecoration(
                labelText: 'Randevu Durumuna Göre Filtrele',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          if (widget.showCustomerFilter)
            SizedBox(
              width: 300,
              child: DropdownButtonFormField<String>(
                items: const [],
                onChanged: (value) {},
                decoration: InputDecoration(
                  labelText: 'Müşteriye Göre Filtrele',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

          SingleChildScrollView(
            // yatay kaydırma cubuğu
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              // dikey kaydırma cubuğu
              scrollDirection: Axis.vertical,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Tarih')),
                  DataColumn(label: Text('Bina')),
                  DataColumn(label: Text('Bayi')),
                  DataColumn(label: Text('Durum')),
                ],
                rows: const [],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
