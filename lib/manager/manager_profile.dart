import 'package:flutter/material.dart';
import 'package:ornek/widgets/app_bar.dart';
import 'package:ornek/widgets/profile.dart';

// ManagerProfile : yönetici için kişisel bilgilerin güncellenebildiği sayfa
class ManagerProfile extends StatefulWidget {
  const ManagerProfile({super.key});

  @override
  State<ManagerProfile> createState() => _ManagerProfileState();
}

class _ManagerProfileState extends State<ManagerProfile> {
  // controller
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addresController = TextEditingController();
  final TextEditingController taxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: Profile(
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
    );
  }
}
