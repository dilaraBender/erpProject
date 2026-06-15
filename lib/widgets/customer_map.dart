// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:ornek/models/customer_model.dart';

// CustomerMapWidget : müşterilerin haritada gösterildiği sayfa
class CustomerMapWidget extends StatelessWidget {
  final List<CustomerModel> customers;

  const CustomerMapWidget({super.key, required this.customers});

  @override
  Widget build(BuildContext context) {
    final List<Marker> markers = customers
        .where((c) => c.latitude != null && c.longitude != null)
        .map((c) {
          final lat = c.latitude;
          final lng = c.longitude;

          if (lat == null || lng == null) return null;

          return Marker(
            point: LatLng(lat, lng),
            width: 50,
            height: 50,
            child: const Icon(Icons.location_on, color: Colors.blue, size: 40),
          );
        })
        .whereType<Marker>()
        .toList();

    print("Customer sayısı: ${customers.length}");
    print("Marker sayısı: ${markers.length}");

    return SizedBox(
      height: 350,
      child: FlutterMap(
        options: const MapOptions(
          // Türkiye merkez
          initialCenter: LatLng(39.0, 35.0),
          initialZoom: 6,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            userAgentPackageName: 'com.example.ornek',
          ),

          MarkerLayer(markers: markers),
        ],
      ),
    );
  }
}
