// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:ornek/models/bayi_model.dart';
import 'package:ornek/models/customer_model.dart';
import 'package:ornek/services/create_bayi.dart';
import 'package:ornek/services/create_customer.dart';
import 'package:ornek/widgets/app_bar.dart';

// ManagerUser : kullanıcı ekleme sayfası
class ManagerUser extends StatefulWidget {
  final int userId;

  const ManagerUser({super.key, required this.userId});

  @override
  State<ManagerUser> createState() => _ManagerUserState();
}

class _ManagerUserState extends State<ManagerUser> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController bayiController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String selectedRole = 'customer';

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    lastnameController.dispose();
    bayiController.dispose();
    super.dispose();
  }

  Future<void> createBayi() async {
    if (!_formKey.currentState!.validate()) return;

    final bayi = BayiModel(
      bayiId: 0,
      name: nameController.text,
      lastName: lastnameController.text,
      title: bayiController.text,
      mail: emailController.text,
      status: "active",
      city: "",
      phone: "",
      address: "",
      tc: "",
      taxNo: "",
      tax: "",
      latitude: null,
      longitude: null,
      password: '',
    );

    final tempPassword = await CreateBayiService.createBayi(bayi);

    if (!mounted) return;

    if (tempPassword != null) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Tek Kullanımlık Şifre"),
          content: Text("Kullanıcının ilk giriş şifresi:\n\n$tempPassword"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);

                nameController.clear();
                lastnameController.clear();
                emailController.clear();
                bayiController.clear();
              },
              child: const Text("Tamam"),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Bayi eklenemedi")));
    }
  }

  Future<void> createCustomer() async {
    if (!_formKey.currentState!.validate()) return;

    final customer = CustomerModel(
      name: nameController.text,
      lastName: lastnameController.text,
      email: emailController.text,
      phone: "",
      status: '',
    );

    final tempPassword = await CreateCustomerService.createCustomer(customer);

    if (!mounted) return;

    if (tempPassword != null) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Tek Kullanımlık Şifre"),
          content: Text("Kullanıcının ilk giriş şifresi:\n\n$tempPassword"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);

                nameController.clear();
                lastnameController.clear();
                emailController.clear();
              },
              child: const Text("Tamam"),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Müşteri eklenemedi")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(userId: widget.userId),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                "Kullanıcı Ekle",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Ad",
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v == null || v.isEmpty ? "Zorunlu" : null,
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: lastnameController,
                decoration: const InputDecoration(
                  labelText: "Soyad",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Mail",
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || !v.contains("@") ? "Geçersiz mail" : null,
              ),

              const SizedBox(height: 12),

              DropdownButtonFormField<String>(
                initialValue: selectedRole,
                items: const [
                  DropdownMenuItem(value: "customer", child: Text("Müşteri")),
                  DropdownMenuItem(value: "bayi", child: Text("Bayi")),
                ],
                onChanged: (v) => setState(() => selectedRole = v!),
                decoration: const InputDecoration(
                  labelText: "Rol",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 12),

              if (selectedRole == "bayi")
                TextFormField(
                  controller: bayiController,
                  decoration: const InputDecoration(
                    labelText: "Bayi Adı",
                    border: OutlineInputBorder(),
                  ),
                ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedRole == "bayi") {
                      createBayi();
                    } else {
                      createCustomer();
                    }
                  },
                  child: const Text("Kaydet"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
