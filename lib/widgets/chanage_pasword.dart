// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:ornek/services/change_password.dart';
import 'package:ornek/widgets/app_bar.dart';
import 'package:ornek/models/change_password_model.dart';

// ChangePasswordPage : şifre değiştirme ekranı
class ChangePasswordPage extends StatefulWidget {
  final int userId;
  const ChangePasswordPage({super.key, required this.userId});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController currentPasswordController;
  late final TextEditingController newPasswordController;
  late final TextEditingController confirmPasswordController;

  bool currentObscure = true;
  bool newObscure = true;
  bool confirmObscure = true;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    currentPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> changePassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    print("===== CHANGE PASSWORD DEBUG =====");
    print("USER ID: ${widget.userId}");
    print("CURRENT RAW: '${currentPasswordController.text}'");
    print("NEW RAW: '${newPasswordController.text}'");

    final model = ChangePasswordModel(
      userId: widget.userId,
      currentPassword: currentPasswordController.text.trim(),
      newPassword: newPasswordController.text.trim(),
    );

    print("MODEL JSON: ${model.toJson()}");

    final result = await ChangePasswordService.changePassword(model);

    print("RESULT: $result");
    print("===== END DEBUG =====");

    setState(() => isLoading = false);

    if (!mounted) return;

    if (result) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Şifre başarıyla değiştirildi")),
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Mevcut şifre hatalı veya API hatası")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBarWidget(userId: widget.userId),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),

              /// Mevcut Şifre
              TextFormField(
                controller: currentPasswordController,
                obscureText: currentObscure,
                decoration: InputDecoration(
                  labelText: "Mevcut Şifre",
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      currentObscure ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        currentObscure = !currentObscure;
                      });
                    },
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Mevcut şifre giriniz";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              /// Yeni Şifre
              TextFormField(
                controller: newPasswordController,
                obscureText: newObscure,
                decoration: InputDecoration(
                  labelText: "Yeni Şifre",
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      newObscure ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        newObscure = !newObscure;
                      });
                    },
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Yeni şifre giriniz";
                  }
                  if (value.length < 6) {
                    return "Şifre en az 6 karakter olmalı";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              /// Şifre Tekrar
              TextFormField(
                controller: confirmPasswordController,
                obscureText: confirmObscure,
                decoration: InputDecoration(
                  labelText: "Yeni Şifre Tekrar",
                  prefixIcon: const Icon(Icons.lock_reset),
                  suffixIcon: IconButton(
                    icon: Icon(
                      confirmObscure ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        confirmObscure = !confirmObscure;
                      });
                    },
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Şifre tekrar giriniz";
                  }
                  if (value != newPasswordController.text) {
                    return "Şifreler eşleşmiyor";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 35),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: isLoading ? null : changePassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Şifreyi Güncelle",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
