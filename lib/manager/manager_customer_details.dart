// ignore_for_file: unnecessary_string_interpolations, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:ornek/models/customer_model.dart';
import 'package:ornek/widgets/app_bar.dart';

// ManagerCustomerDetails : müşteri detay bilgilerinin gösterildiği sayfa

class ManagerCustomerDetails extends StatelessWidget {
  final int userId;
  final CustomerModel customer;

  const ManagerCustomerDetails({
    super.key,
    required this.userId,
    required this.customer,
  });

  bool get hasLocation =>
      customer.latitude != null && customer.longitude != null;

  @override
  Widget build(BuildContext context) {
    final LatLng defaultCenter = const LatLng(39.0, 35.0);

    final LatLng? point = hasLocation
        ? LatLng(customer.latitude!, customer.longitude!)
        : null;

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      appBar: AppBarWidget(userId: userId),

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
                        Icons.person,
                        size: 40,
                        color: Color(0xff0F766E),
                      ),
                    ),

                    const SizedBox(height: 14),

                    Text(
                      customer.name,
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
                        "Müşteri Bilgileri",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                        ),
                      ),

                      const SizedBox(height: 20),

                      detailRow(Icons.email_outlined, "Mail", customer.email),

                      const SizedBox(height: 16),

                      detailRow(
                        Icons.phone_outlined,
                        "Telefon",
                        customer.phone,
                      ),

                      const SizedBox(height: 16),

                      detailRow(
                        Icons.location_on_outlined,
                        "Konum Durumu",
                        hasLocation ? "Mevcut" : "Bulunamadı",
                        valueColor: hasLocation ? Colors.green : Colors.red,
                      ),

                      if (hasLocation) ...[
                        const SizedBox(height: 16),

                        detailRow(
                          Icons.map_outlined,
                          "Latitude",
                          customer.latitude.toString(),
                        ),

                        const SizedBox(height: 16),

                        detailRow(
                          Icons.map_outlined,
                          "Longitude",
                          customer.longitude.toString(),
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
                          child: FlutterMap(
                            options: MapOptions(
                              initialCenter: point ?? defaultCenter,
                              initialZoom: hasLocation ? 15 : 6,
                            ),
                            children: [
                              TileLayer(
                                urlTemplate:
                                    "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                                userAgentPackageName: 'com.example.ornek',
                              ),

                              if (hasLocation)
                                MarkerLayer(
                                  markers: [
                                    Marker(
                                      point: point!,
                                      width: 60,
                                      height: 60,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.red.withOpacity(0.15),
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
