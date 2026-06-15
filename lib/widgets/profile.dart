import 'package:flutter/material.dart';

// Profile : Kullanıcıların bilgilerini güncelleyebileceği ortak ekran
class Profile extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController? userNameController;
  final TextEditingController? passwordController;
  final TextEditingController? taxController;
  final TextEditingController? taxNoController;
  final TextEditingController? firmController;
  final TextEditingController? firmAddressController;
  final TextEditingController? firmMailController;
  final TextEditingController? firmIbanController;

  final bool isCustomer;

  const Profile({
    super.key,
    required this.nameController,
    required this.lastNameController,
    required this.emailController,
    required this.phoneController,
    this.passwordController,
    this.userNameController,
    this.taxController,
    this.taxNoController,
    this.firmController,
    this.firmMailController,
    this.firmAddressController,
    this.firmIbanController,
    required this.isCustomer,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('resimler/profile.png'),
              radius: 50,
            ),

            const SizedBox(height: 12),

            const Text(
              "Kişisel Bilgiler",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Ad',
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextField(
                      controller: lastNameController,
                      decoration: const InputDecoration(
                        labelText: 'Soyad',
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Telefon',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            if (!isCustomer) ...[
              const Text(
                "Şirket Bilgileri",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextField(
                        controller: firmController,
                        decoration: const InputDecoration(
                          labelText: 'Şirket Adı',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextField(
                        controller: taxController,
                        decoration: const InputDecoration(
                          labelText: 'Vergi Dairesi',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextField(
                        controller: taxNoController,
                        decoration: const InputDecoration(
                          labelText: 'Vergi No',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextField(
                        controller: firmAddressController,
                        decoration: const InputDecoration(
                          labelText: 'Adres',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
