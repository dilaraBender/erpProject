// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ornek/models/building_model.dart';
import 'package:ornek/services/building_list.dart';
import 'package:ornek/services/create_building.dart';
import 'package:ornek/widgets/app_bar.dart';
import 'package:ornek/widgets/select_location.dart';

// CustomerBuilding : Müşterinin binalarının listelendiği sayfa
class CustomerBuilding extends StatefulWidget {
  final int userId;
  final int customerId;

  const CustomerBuilding({
    super.key,
    required this.userId,
    required this.customerId,
  });

  @override
  State<CustomerBuilding> createState() => _CustomerBuildingState();
}

class _CustomerBuildingState extends State<CustomerBuilding> {
  List<BuildingModel> buildings = [];
  bool isLoading = true;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  double? selectedLat;
  double? selectedLng;

  @override
  void initState() {
    super.initState();
    fetchBuildings();
  }

  Future<void> fetchBuildings() async {
    setState(() => isLoading = true);

    try {
      final fetched = await BuildingListService.fetchBuildings(widget.userId);
      setState(() => buildings = fetched);
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      selectedLat = position.latitude;
      selectedLng = position.longitude;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("GPS konumu alındı")));
  }

  void showCreateDialog() {
    titleController.clear();
    addressController.clear();
    cityController.clear();
    selectedLat = null;
    selectedLng = null;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Yeni Bina Ekle"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Bina Adı'),
              ),

              TextField(
                controller: addressController,
                decoration: const InputDecoration(labelText: 'Adres'),
              ),

              TextField(
                controller: cityController,
                decoration: const InputDecoration(labelText: 'Şehir'),
              ),

              const SizedBox(height: 10),

              ElevatedButton.icon(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SelectLocation()),
                  );

                  if (result != null) {
                    setState(() {
                      selectedLat = result["latitude"];
                      selectedLng = result["longitude"];
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Haritadan konum seçildi")),
                    );
                  }
                },
                icon: const Icon(Icons.map),
                label: const Text("Haritadan Konum Seç"),
              ),

              const SizedBox(height: 10),

              ElevatedButton.icon(
                onPressed: () async {
                  await getLocation();
                },
                icon: const Icon(Icons.location_on),
                label: const Text("Konumumu Al"),
              ),

              const SizedBox(height: 10),

              if (selectedLat != null && selectedLng != null)
                Text(
                  "Lat: $selectedLat\nLng: $selectedLng",
                  style: const TextStyle(fontSize: 12),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (selectedLat == null || selectedLng == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Lütfen konum seçin")),
                );
                return;
              }

              final newBuilding = BuildingModel(
                buildingId: 0,
                customerId: widget.customerId,
                title: titleController.text,
                address: addressController.text,
                city: cityController.text,
                latitude: selectedLat,
                longitude: selectedLng,
              );

              await CreateBuildingService.createBuilding(newBuilding);
              await fetchBuildings();

              Navigator.pop(context);
            },
            child: const Text("Ekle"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("İptal"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(userId: widget.userId),
      floatingActionButton: FloatingActionButton(
        onPressed: showCreateDialog,
        child: const Icon(Icons.add),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: buildings.length,
              itemBuilder: (context, index) {
                final building = buildings[index];

                return ListTile(
                  title: Text(building.title),
                  subtitle: Text(building.address),
                );
              },
            ),
    );
  }
}
