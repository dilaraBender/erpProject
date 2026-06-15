import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ornek/models/building_model.dart';

// BuildingMapPage : binaların haritada gösterildiği sayfa
class BuildingMapPage extends StatefulWidget {
  final List<BuildingModel> buildings;

  const BuildingMapPage({super.key, required this.buildings});

  @override
  State<BuildingMapPage> createState() => _BuildingMapPageState();
}

class _BuildingMapPageState extends State<BuildingMapPage> {
  late GoogleMapController mapController;

  final Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    loadMarkers();
  }

  void loadMarkers() {
    for (var b in widget.buildings) {
      if (b.latitude != null && b.longitude != null) {
        markers.add(
          Marker(
            markerId: MarkerId(b.buildingId.toString()),
            position: LatLng(b.latitude!, b.longitude!),
            infoWindow: InfoWindow(title: b.title, snippet: b.address),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bina Haritası")),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target:
              widget.buildings.isNotEmpty &&
                  widget.buildings.first.latitude != null
              ? LatLng(
                  widget.buildings.first.latitude!,
                  widget.buildings.first.longitude!,
                )
              : const LatLng(39.0, 35.0),
          zoom: 6,
        ),
        markers: markers,
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
      ),
    );
  }
}
