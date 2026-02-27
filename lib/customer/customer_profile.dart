import 'package:flutter/material.dart';
import 'package:ornek/widgets/app_bar.dart';
import 'package:ornek/widgets/profile.dart';

// CustomerProfile : Müşterilerin profile görnümünü kullanarak bilgilerini güncelleyebileceği ekran
class CustomerProfile extends StatefulWidget {
  const CustomerProfile({super.key});

  @override
  State<CustomerProfile> createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  // controller
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
        isCustomer: true,
      ),
    );
  }
}
