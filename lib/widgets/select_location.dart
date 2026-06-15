// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

// SelectLocation : manuel konum oluştrumak için sayfa
class SelectLocation extends StatefulWidget {
  const SelectLocation({super.key});

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  LatLng? selectedLocation;

  String? selectedCity;
  String? selectedDistrict;

  final Map<String, List<String>> cityDistricts = {
    "Bursa": ["Nilüfer", "Osmangazi", "Yıldırım"],
    "İstanbul": ["Kadıköy", "Beşiktaş", "Üsküdar"],
    "Ankara": ["Çankaya", "Keçiören", "Mamak"],
  };

  final MapController mapController = MapController();

  Future<void> searchLocation(String query) async {
    final url = Uri.parse(
      "https://nominatim.openstreetmap.org/search?format=json&q=$query",
    );

    final response = await http.get(
      url,
      headers: {"User-Agent": "flutter_app"},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data.isNotEmpty) {
        final lat = double.parse(data[0]["lat"]);
        final lon = double.parse(data[0]["lon"]);

        final newPos = LatLng(lat, lon);

        setState(() {
          selectedLocation = newPos;
        });

        mapController.move(newPos, 15);
      }
    }
  }

  void onDistrictSelected(String? value) {
    setState(() {
      selectedDistrict = value;
    });

    if (selectedCity != null && selectedDistrict != null) {
      final query = "$selectedDistrict, $selectedCity, Turkey";
      searchLocation(query);
    }
  }

  void saveLocation() {
    if (selectedLocation == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Lütfen konum seçin")));
      return;
    }

    Navigator.pop(context, {
      "latitude": selectedLocation!.latitude,
      "longitude": selectedLocation!.longitude,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Konum Seç")),
      body: SafeArea(
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedCity,
              items: cityDistricts.keys
                  .map(
                    (city) => DropdownMenuItem(value: city, child: Text(city)),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCity = value;
                  selectedDistrict = null;
                });
              },
              decoration: const InputDecoration(labelText: "İl"),
            ),

            DropdownButtonFormField<String>(
              value: selectedDistrict,
              items: selectedCity == null
                  ? []
                  : cityDistricts[selectedCity]!
                        .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                        .toList(),
              onChanged: onDistrictSelected,
              decoration: const InputDecoration(labelText: "İlçe"),
            ),

            Expanded(
              child: FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  initialCenter: const LatLng(39.0, 35.0),
                  initialZoom: 5,
                  onTap: (tapPosition, point) {
                    setState(() {
                      selectedLocation = point;
                    });
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                    userAgentPackageName: 'com.example.ornek',
                  ),
                  if (selectedLocation != null)
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: selectedLocation!,
                          width: 50,
                          height: 50,
                          child: const Icon(
                            Icons.location_pin,
                            color: Colors.red,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                left: 12,
                right: 12,
                top: 12,
                bottom: MediaQuery.of(context).padding.bottom + 12,
              ),
              child: ElevatedButton(
                onPressed: saveLocation,
                child: const Text("Konumu Onayla"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
