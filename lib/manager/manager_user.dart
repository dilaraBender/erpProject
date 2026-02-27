import 'package:flutter/material.dart';
import 'package:ornek/widgets/app_bar.dart';

// ManagerUser : yönetici için kullanıcı ekleme sayfası
class ManagerUser extends StatefulWidget {
  const ManagerUser({super.key});
  @override
  State<ManagerUser> createState() => _ManagerUserState();
}

class _ManagerUserState extends State<ManagerUser> {
  // controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController bayiController = TextEditingController();

  String selectedRole = 'musteri';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text('Kullanıcı Ekle'),

                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelText: 'Ad',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Ad boş bırakılamaz!" : null,
                  ),

                  const SizedBox(height: 12),

                  TextFormField(
                    controller: lastnameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelText: 'Soyad',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Soyad boş bırakılamaz!" : null,
                  ),

                  const SizedBox(height: 12),

                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelText: 'Mail',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return "Mail boş bırakılamaz";
                      }
                      if (!value.contains('@')) {
                        return "Geçerli bir mail giriniz.";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 12),

                  TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelText: 'Şifre',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.length < 6 ? "En az 6 karakter giriniz" : null,
                  ),

                  const SizedBox(height: 12),

                  DropdownButtonFormField<String>(
                    initialValue: selectedRole,
                    items: const [
                      DropdownMenuItem(
                        value: 'musteri',
                        child: Text('Müşteri'),
                      ),
                      DropdownMenuItem(value: 'bayi', child: Text('Bayi')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedRole = value!;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Rol',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 12),

                  if (selectedRole == 'bayi') ...[
                    TextFormField(
                      controller: bayiController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        labelText: 'Bayi Adı',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? "Bayi adı boş bırakılamaz!" : null,
                    ),
                  ],

                  ElevatedButton(onPressed: () {}, child: Text('Kaydet')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
