// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:ornek/customer/customer_home.dart';
import 'package:ornek/bayi/bayi_home.dart';
import 'package:ornek/manager/manager_home.dart';
import 'package:ornek/services/customer_profile.dart';
import 'package:ornek/services/bayi_profile.dart';
import 'package:ornek/services/new_password.dart';

class ForceChangePasswordScreen extends StatefulWidget {
  final int userId;
  final String role;

  const ForceChangePasswordScreen({
    super.key,
    required this.userId,
    required this.role,
  });

  @override
  State<ForceChangePasswordScreen> createState() =>
      _ForceChangePasswordScreenState();
}

class _ForceChangePasswordScreenState extends State<ForceChangePasswordScreen> {
  final TextEditingController newPassController = TextEditingController();

  bool isLoading = false;

  Future<void> changePassword() async {
    if (newPassController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Şifre boş olamaz")));
      return;
    }

    setState(() => isLoading = true);

    try {
      final success = await PasswordService.changePassword(
        widget.userId,
        newPassController.text.trim(),
      );

      if (!success) {
        throw Exception("Şifre güncellenemedi");
      }

      // CUSTOMER
      if (widget.role == "customer") {
        final profile = await CustomerProfileService.fetchCustomerProfile(
          widget.userId,
        );

        if (profile == null) {
          throw Exception("Customer profili bulunamadı");
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => CustomerHome(
              userId: profile.userId ?? 0,
              customerId: profile.customerId ?? 0,
              latitude: profile.latitude ?? 0,
              longitude: profile.longitude ?? 0,
            ),
          ),
        );
      }
      // BAYİ
      else if (widget.role == "bayi") {
        final profile = await BayiProfileService.fetchProfile(widget.userId);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => BayiHome(
              userId: widget.userId,
              bayiId: profile.bayiId,
              latitude: profile.latitude ?? 0,
              longitude: profile.longitude ?? 0,
            ),
          ),
        );
      }
      // MANAGER
      else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => ManagerHome(
              userId: widget.userId,
              managerId: widget.userId,
              latitude: 0,
              longitude: 0,
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Hata: $e")));
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    newPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Şifre Değiştir")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: newPassController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Yeni Şifre",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : changePassword,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Kaydet"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
