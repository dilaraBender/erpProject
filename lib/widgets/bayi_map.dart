// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:ornek/models/bayi_model.dart';

// BayiMapWidget : bayilerin haritada gösterildiği sayfa
class BayiMapWidget extends StatelessWidget {
  final List<BayiModel> bayis;

  const BayiMapWidget({super.key, required this.bayis});

  @override
  Widget build(BuildContext context) {
    final markers = bayis
        .where((b) => b.latitude != null && b.longitude != null)
        .map((b) {
          return Marker(
            point: LatLng(b.latitude!, b.longitude!),
            width: 50,
            height: 50,
            child: const Icon(Icons.location_on, color: Colors.red, size: 40),
          );
        })
        .toList();

    print("Marker sayısı: ${markers.length}");

    return SizedBox(
      height: 300,
      child: FlutterMap(
        options: MapOptions(
          // 🇹🇷 Türkiye merkez (yaklaşık)
          initialCenter: const LatLng(39.0, 35.0),

          initialZoom: 5.5,

          interactionOptions: const InteractionOptions(
            flags: InteractiveFlag.all,
          ),
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
