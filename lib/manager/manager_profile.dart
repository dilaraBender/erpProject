// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ornek/services/manager_profile.dart';
import 'package:ornek/widgets/app_bar.dart';
import 'package:ornek/widgets/profile.dart';
import 'package:ornek/models/manager_profile_model.dart';
import 'package:ornek/widgets/select_location.dart';

// ManagerProfile : yönetici bilgilerinin gösterildiği sayfa
class ManagerProfile extends StatefulWidget {
  final int userId;
  const ManagerProfile({super.key, required this.userId});

  @override
  State<ManagerProfile> createState() => _ManagerProfileState();
}

class _ManagerProfileState extends State<ManagerProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addresController = TextEditingController();
  final TextEditingController taxController = TextEditingController();

  double? selectedLat;
  double? selectedLng;

  bool get hasLocation => selectedLat != null && selectedLng != null;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  @override
  void dispose() {
    nameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    userNameController.dispose();
    passwordController.dispose();
    addresController.dispose();
    taxController.dispose();
    super.dispose();
  }

  Future<void> _loadProfile() async {
    try {
      final profile = await ManagerProfileService.fetchProfile(widget.userId);

      if (!mounted) return;

      setState(() {
        nameController.text = profile.name;
        lastNameController.text = profile.lastName;
        emailController.text = profile.mail;
        phoneController.text = profile.phone;

        selectedLat = profile.latitude;
        selectedLng = profile.longitude;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Profil yüklenirken hata: $e')));
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

  Future<void> _updateProfile() async {
    try {
      ManagerProfileModel profile = ManagerProfileModel(
        userId: widget.userId,
        name: nameController.text,
        lastName: lastNameController.text,
        mail: emailController.text,
        phone: phoneController.text,
        latitude: selectedLat,
        longitude: selectedLng,
      );

      bool success = await ManagerProfileService.updateProfile(profile);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success ? 'Profil güncellendi' : 'Profil güncellenemedi',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Güncelleme hatası: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(userId: widget.userId),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Profile(
              nameController: nameController,
              lastNameController: lastNameController,
              emailController: emailController,
              phoneController: phoneController,
              passwordController: passwordController,
              userNameController: userNameController,
              isCustomer: false,
              firmAddressController: addresController,
              taxController: taxController,
            ),

            const SizedBox(height: 15),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: hasLocation ? Colors.green.shade50 : Colors.red.shade50,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: hasLocation
                      ? Colors.green.shade200
                      : Colors.red.shade200,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    hasLocation ? Icons.location_on : Icons.location_off,
                    color: hasLocation ? Colors.green : Colors.red,
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hasLocation ? "Konum kayıtlı" : "Konum kayıtlı değil",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          hasLocation
                              ? "Konum başarıyla kaydedildi"
                              : "Haritadan veya GPS ile ekleyin",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (hasLocation)
                    const Icon(Icons.check_circle, color: Colors.green),
                ],
              ),
            ),

            const SizedBox(height: 15),

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
                }
              },
              icon: const Icon(Icons.map),
              label: const Text("Haritadan Konum Seç"),
            ),

            const SizedBox(height: 10),

            ElevatedButton.icon(
              onPressed: getLocation,
              icon: const Icon(Icons.my_location),
              label: const Text("GPS Konumu Al"),
            ),

            const SizedBox(height: 10),

            if (hasLocation)
              Text(
                "Lat: $selectedLat\nLng: $selectedLng",
                style: const TextStyle(fontSize: 12),
              ),

            const SizedBox(height: 20),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _updateProfile,
        child: const Icon(Icons.save),
      ),
    );
  }
}
