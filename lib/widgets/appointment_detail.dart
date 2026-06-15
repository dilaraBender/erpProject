// ignore_for_file: unused_local_variable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:ornek/models/appointment_model.dart';
import 'package:ornek/widgets/app_bar.dart';

class AppointmentDetails extends StatefulWidget {
  final int userId;
  final AppointmentModel appointment;

  const AppointmentDetails({
    super.key,
    required this.userId,
    required this.appointment,
  });

  @override
  State<AppointmentDetails> createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  bool get hasLocation =>
      widget.appointment.latitude != null &&
      widget.appointment.longitude != null;

  @override
  Widget build(BuildContext context) {
    final LatLng defaultCenter = const LatLng(39.0, 35.0);

    final LatLng? point = hasLocation
        ? LatLng(widget.appointment.latitude!, widget.appointment.longitude!)
        : null;

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      appBar: AppBarWidget(userId: widget.userId),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ÜST PROFİL KARTI
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [Color(0xff0F766E), Color(0xff115E59)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 38,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.calendar_month,
                        size: 40,
                        color: Color(0xff0F766E),
                      ),
                    ),

                    const SizedBox(height: 14),

                    Text(
                      widget.appointment.buildingTitle ?? "-",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        hasLocation
                            ? "Konum Bilgisi Mevcut"
                            : "Konum Bilgisi Yok",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // DETAY KARTI
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Randevu Bilgileri",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                        ),
                      ),

                      const SizedBox(height: 20),

                      detailRow(Icons.calendar_today_outlined, "Tarih", "-"),

                      const SizedBox(height: 16),

                      detailRow(
                        Icons.apartment_outlined,
                        "Bina",
                        widget.appointment.buildingTitle ?? "-",
                      ),

                      const SizedBox(height: 16),

                      detailRow(
                        Icons.business_outlined,
                        "Bayi",
                        widget.appointment.bayiName ?? "-",
                      ),

                      const SizedBox(height: 16),

                      detailRow(
                        Icons.phone_outlined,
                        "Telefon",
                        widget.appointment.phone ?? "-",
                      ),

                      const SizedBox(height: 16),

                      detailRow(
                        Icons.location_on_outlined,
                        "Adres",
                        widget.appointment.address ?? "-",
                      ),

                      const SizedBox(height: 16),

                      detailRow(
                        Icons.description_outlined,
                        "Açıklama",
                        widget.appointment.description ?? "-",
                      ),

                      const SizedBox(height: 16),

                      detailRow(
                        Icons.map_outlined,
                        "Konum Durumu",
                        hasLocation ? "Mevcut" : "Bulunamadı",
                        valueColor: hasLocation ? Colors.green : Colors.red,
                      ),

                      if (hasLocation) ...[
                        const SizedBox(height: 16),

                        detailRow(
                          Icons.my_location_outlined,
                          "Latitude",
                          widget.appointment.latitude.toString(),
                        ),

                        const SizedBox(height: 16),

                        detailRow(
                          Icons.my_location_outlined,
                          "Longitude",
                          widget.appointment.longitude.toString(),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // HARİTA KARTI
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Harita Görünümü",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),

                      const SizedBox(height: 14),

                      SizedBox(
                        height: 350,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: hasLocation
                              ? FlutterMap(
                                  options: MapOptions(
                                    initialCenter: point!,
                                    initialZoom: 15,
                                  ),
                                  children: [
                                    TileLayer(
                                      urlTemplate:
                                          "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                                      userAgentPackageName: 'com.example.ornek',
                                    ),

                                    MarkerLayer(
                                      markers: [
                                        Marker(
                                          point: point,
                                          width: 60,
                                          height: 60,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.red.withOpacity(
                                                0.15,
                                              ),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.location_on,
                                              color: Colors.red,
                                              size: 40,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : const Center(
                                  child: Text(
                                    "Bu randevu için konum bilgisi yok",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget detailRow(
    IconData icon,
    String title,
    String value, {
    Color? valueColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xffECFDF5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color(0xff0F766E)),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),

              const SizedBox(height: 4),

              Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: valueColor ?? Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
