// ignore_for_file: control_flow_in_finally, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ornek/models/customer_model.dart';
import 'package:ornek/services/customer_profile.dart';
import 'package:ornek/services/update_customer.dart';
import 'package:ornek/widgets/app_bar.dart';
import 'package:ornek/widgets/profile.dart';
import 'package:ornek/widgets/select_location.dart';

// CustomerProfile : Müşterinin kişisel bilgilerinin gösterildiği sayfa
class CustomerProfile extends StatefulWidget {
  final int userId;
  final int customerId;

  const CustomerProfile({
    super.key,
    required this.userId,
    required this.customerId,
  });

  @override
  State<CustomerProfile> createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  late TextEditingController nameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  bool isLoading = true;

  double? selectedLat;
  double? selectedLng;

  bool get hasLocation => selectedLat != null && selectedLng != null;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();

    loadCustomer();
  }

  Future<void> loadCustomer() async {
    setState(() => isLoading = true);

    try {
      final customer = await CustomerProfileService.fetchCustomerProfile(
        widget.userId,
      );

      if (!mounted) return;

      if (customer != null) {
        nameController.text = customer.name;
        lastNameController.text = customer.lastName;
        emailController.text = customer.email;
        phoneController.text = customer.phone;

        selectedLat = customer.latitude;
        selectedLng = customer.longitude;
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Hata: $e")));
    } finally {
      if (!mounted) return;
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

  Future<void> saveCustomer() async {
    try {
      final customer = CustomerModel(
        userId: widget.userId,
        name: nameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        phone: phoneController.text,
        status: "active",
        latitude: selectedLat,
        longitude: selectedLng,
      );

      final result = await UpdateCustomerService.updateCustomer(customer);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result ? "Profil güncellendi" : "Güncelleme başarısız"),
        ),
      );

      if (result) {
        await loadCustomer();
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Hata: $e")));
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
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
                    passwordController: null,
                    userNameController: null,
                    isCustomer: true,
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
        onPressed: saveCustomer,
        child: const Icon(Icons.save),
      ),
    );
  }
}
