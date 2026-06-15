// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:ornek/models/appointment_model.dart';

// AppointmentMap : Randevuların haritada gösterildiği ekran
class AppointmentMap extends StatelessWidget {
  final List<AppointmentModel> appointments;

  const AppointmentMap({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    final markers = appointments
        .where((a) => a.latitude != null && a.longitude != null)
        .map((a) {
          return Marker(
            point: LatLng(a.latitude!, a.longitude!),
            width: 50,
            height: 50,
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  builder: (_) => Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          a.customerName ?? "-",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text("Bayi: ${a.bayiName ?? "-"}"),
                        Text("Adres: ${a.address ?? "-"}"),
                        Text("Durum: ${a.status ?? "-"}"),
                      ],
                    ),
                  ),
                );
              },
              child: Icon(
                Icons.location_on,
                color: _getColor(a.status),
                size: 40,
              ),
            ),
          );
        })
        .toList();

    print("Appointment Marker sayısı: ${markers.length}");

    return SizedBox(
      height: 300,
      child: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(39.0, 35.0),
          initialZoom: 5.5,
          interactionOptions: InteractionOptions(flags: InteractiveFlag.all),
        ),

        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            userAgentPackageName: 'com.rw.ornek',
          ),

          MarkerLayer(markers: markers),
        ],
      ),
    );
  }

  Color _getColor(String? status) {
    switch (status) {
      case "active":
        return Colors.green;
      case "pending":
        return Colors.orange;
      case "completed":
        return Colors.blue;
      case "cancelled":
        return Colors.grey;
      default:
        return Colors.red;
    }
  }
}
