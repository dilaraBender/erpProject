import 'package:flutter/material.dart';
import 'package:ornek/widgets/app_bar.dart';
import 'package:ornek/widgets/profile.dart';

// BayiProfile : Bayiliklerin profile görünümünü kullanarak blgilerini güncellediği sayfa
class BayiProfile extends StatefulWidget {
  const BayiProfile({super.key});

  @override
  State<BayiProfile> createState() => _BayiProfileState();
}

class _BayiProfileState extends State<BayiProfile> {
  // Controller
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
