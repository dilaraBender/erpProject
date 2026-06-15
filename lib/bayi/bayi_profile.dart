// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ornek/models/bayi_model.dart';
import 'package:ornek/services/bayi_profile.dart';
import 'package:ornek/services/update_bayi.dart';
import 'package:ornek/widgets/app_bar.dart';
import 'package:ornek/widgets/select_location.dart';
import '../widgets/profile.dart';

// BayiProfile : Bayinin kişisel ve şirket bilgilerinin gösterdiği sayfa
class BayiProfile extends StatefulWidget {
  final int userId;
  final int bayiId;

  const BayiProfile({super.key, required this.userId, required this.bayiId});

  @override
  State<BayiProfile> createState() => _BayiProfileState();
}

class _BayiProfileState extends State<BayiProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController tcController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController addresController = TextEditingController();
  final TextEditingController taxController = TextEditingController();
  final TextEditingController taxNoController = TextEditingController();

  bool isLoading = true;

  double? selectedLat;
  double? selectedLng;

  bool get hasLocation =>
      selectedLat != null &&
      selectedLng != null &&
      selectedLat != 0 &&
      selectedLng != 0;

  @override
  void initState() {
    super.initState();
    fetchBayiProfile();
  }

  @override
  void dispose() {
    nameController.dispose();
    lastNameController.dispose();
    tcController.dispose();
    emailController.dispose();
    phoneController.dispose();
    userNameController.dispose();
    passwordController.dispose();
    titleController.dispose();
    cityController.dispose();
    addresController.dispose();
    taxController.dispose();
    taxNoController.dispose();
    super.dispose();
  }

  Future<void> fetchBayiProfile() async {
    setState(() => isLoading = true);

    try {
      final profile = await BayiProfileService.fetchProfile(widget.userId);

      nameController.text = profile.name;
      lastNameController.text = profile.lastName;
      emailController.text = profile.mail;
      titleController.text = profile.title;
      tcController.text = profile.tc ?? "";
      phoneController.text = profile.phone ?? "";
      cityController.text = profile.city ?? "";
      addresController.text = profile.address ?? "";
      taxController.text = profile.tax ?? "";
      taxNoController.text = profile.taxNo ?? "";

      selectedLat = profile.latitude;
      selectedLng = profile.longitude;
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Hata: $e")));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(userId: widget.userId),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                    firmController: titleController,
                    firmAddressController: addresController,
                    taxController: taxController,
                    taxNoController: taxNoController,
                  ),

                  const SizedBox(height: 15),

                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: hasLocation
                          ? Colors.green.shade50
                          : Colors.red.shade50,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: hasLocation
                            ? Colors.green.shade200
                            : Colors.red.shade200,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: hasLocation
                                ? Colors.green.shade100
                                : Colors.red.shade100,
                          ),
                          child: Icon(
                            hasLocation
                                ? Icons.location_on
                                : Icons.location_off,
                            color: hasLocation ? Colors.green : Colors.red,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                hasLocation
                                    ? "Konum kayıtlı"
                                    : "Konum kayıtlı değil",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade50,
                      foregroundColor: Colors.blue,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SelectLocation(),
                        ),
                      );

                      if (result != null) {
                        setState(() {
                          selectedLat = result["latitude"];
                          selectedLng = result["longitude"];
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Konum haritadan seçildi"),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.map),
                    label: const Text("Haritadan Konum Seç"),
                  ),

                  const SizedBox(height: 10),

                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade50,
                      foregroundColor: Colors.green,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
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
        onPressed: () async {
          final model = BayiModel(
            bayiId: widget.bayiId,
            name: nameController.text,
            lastName: lastNameController.text,
            title: titleController.text,
            mail: emailController.text,
            status: "active",
            city: cityController.text,
            phone: phoneController.text,
            address: addresController.text,
            tc: tcController.text,
            taxNo: taxNoController.text,
            tax: taxController.text,
            latitude: selectedLat,
            longitude: selectedLng,
            password: '',
          );

          final result = await UpdateBayiService.updateBayi(model);

          if (result) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Profil başarıyla güncellendi!")),
            );

            await fetchBayiProfile();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Güncelleme başarısız!")),
            );
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
