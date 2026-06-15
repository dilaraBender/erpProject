// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ornek/bayi/bayi_home.dart';
import 'package:ornek/customer/customer_home.dart';
import 'package:ornek/manager/manager_home.dart';
import 'package:ornek/url.dart';
import 'package:ornek/widgets/password.dart';
import 'package:ornek/widgets/show_message.dart';

// LoginPage : kullanıcının giriş yapacagı ekran
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  bool isLoading = false;

  Future<void> login() async {
    final url = Uri.parse("${ApiConfig.baseUrl}/Login/Login");

    setState(() => isLoading = true);

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "mail": emailController.text.trim(),
          "password": passwordController.text.trim(),
        }),
      );

      if (!mounted) return;

      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");

      if (response.statusCode != 200) {
        showMessage(context, "Email veya şifre hatalı");
        return;
      }

      final data = jsonDecode(response.body);

      final role = data["role"]?.toString() ?? "";
      final userId = data["userId"] ?? 0;

      final bayiId = data["bayiId"] ?? 0;
      final customerId = data["customerId"] ?? 0;
      final managerId = data["managerId"] ?? 0;

      final passwordChanged = data["passwordChanged"] ?? true;

      final latitude = (data["latitude"] ?? 0).toDouble();
      final longitude = (data["longitude"] ?? 0).toDouble();

      if (!passwordChanged) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                ForceChangePasswordScreen(userId: userId, role: role),
          ),
        );
        return;
      }

      if (role == "customer") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => CustomerHome(
              userId: userId,
              customerId: customerId,
              latitude: latitude,
              longitude: longitude,
            ),
          ),
        );
      } else if (role == "bayi") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => BayiHome(
              userId: userId,
              bayiId: bayiId,
              latitude: latitude,
              longitude: longitude,
            ),
          ),
        );
      } else if (role == "manager") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => ManagerHome(
              userId: userId,
              managerId: managerId,
              latitude: latitude,
              longitude: longitude,
            ),
          ),
        );
      } else {
        showMessage(context, "Rol bulunamadı");
      }
    } catch (e) {
      print("LOGIN ERROR: $e");
      if (!mounted) return;
      showMessage(context, "Bağlantı hatası!");
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 40),

                Image.asset("resimler/logo.png", height: 120),

                const SizedBox(height: 40),

                TextField(
                  controller: emailController,
                  focusNode: emailFocus,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (_) => passwordFocus.requestFocus(),
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20),

                TextField(
                  controller: passwordController,
                  focusNode: passwordFocus,
                  obscureText: true,
                  onSubmitted: (_) => login(),
                  decoration: const InputDecoration(
                    labelText: "Şifre",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : login,
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text("Giriş Yap"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
