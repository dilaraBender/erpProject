import 'package:flutter/material.dart';

// Profile : Kullanıcıların bilgilerini güncelleyeebileceği ortak ekran

class Profile extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController userNameController;
  final TextEditingController passwordController;
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
    required this.passwordController,
    required this.userNameController,
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

            Text('Yönetici'),

            const SizedBox(height: 8),

            ElevatedButton(
              onPressed: () {},
              child: const Text('Profili Değiştir'),
            ),

            const SizedBox(height: 8),

            Text(
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
                    const SizedBox(height: 12),

                    TextField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        labelText: 'Adınızı Giriniz',
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextField(
                      controller: lastNameController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        labelText: 'Soyadınızı Giriniz',
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Emailinizi Giriniz',
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'Telefon Numaranızı Giriniz',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 12),

            if (isCustomer == false) ...[
              Text(
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
                      const SizedBox(height: 12),

                      TextField(
                        controller: firmController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Şirket Adı',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextField(
                        controller: taxController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Vergi Dairesi',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextField(
                        controller: taxNoController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Vergi Numarası',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextField(
                        controller: firmMailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Kurumsal mail adresi',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextField(
                        controller: firmAddressController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Adres',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextField(
                        controller: firmIbanController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true, //şifreyi gizleme
                        decoration: const InputDecoration(
                          labelText: 'Iban',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            ElevatedButton(onPressed: () {}, child: Text('Kaydet')),
          ],
        ),
      ),
    );
  }
}
