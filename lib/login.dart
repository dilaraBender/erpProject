import 'package:flutter/material.dart';
import 'package:ornek/bayi/bayi_home.dart';
import 'package:ornek/customer/customer_home.dart';
import 'package:ornek/manager/manager_home.dart';
import 'package:ornek/widgets/show_message.dart';

// LoginPage : Kullanıcı adı ve şifre ile sisteme giriş yapacağımız ekran

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  // bu satır sadece stateful için kullanılır stateless de kullanılmaz
  //// LoginPage widget’ının state’ini _LoginPageState sınıfı yönetecek.
  @override
  State<LoginPage> createState() => _LoginPageState();
}

// LoginPageState sınıfı
class _LoginPageState extends State<LoginPage> {
  // textField içinde yazılan metni almak için CONTROLLER kullanıyoruz
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String?
  selectedRole; // ? kullandık çünkü selectedRole değeri null de olabilir

  @override
  Widget build(BuildContext context) {
    // scaffold sayfa iskeleti demektir
    return Scaffold(
      appBar: AppBar(),
      // sayfaya sığamazsak kaydırabilirlik eklemek için
      body: SingleChildScrollView(
        // Center sayfayı tam ortalamak için yatay ve dikeyde
        child: Center(
          // form genişliğini sınırlamak için
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              // max form genişliği
              maxWidth: 400,
            ),

            child: Padding(
              // widgetin içinde 16px boşluklar bırak
              padding: const EdgeInsets.all(16),
              // widgetleri üstten alta yerleştirmek için
              child: Column(
                // widgetlerin yatayda ekranı kaplaması için
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset('resimler/logo.png', width: 200),

                  const SizedBox(height: 15),

                  // kullancının veri gireceği textbox
                  TextField(
                    // kullanıcının girdiği veriyi almak için controller
                    controller: emailController,
                    // klavyeyi mail yazmak için uygun hale getir(@ ve .com vs. gibi)
                    keyboardType: TextInputType.emailAddress,
                    // textFieldin tasarım kısmı
                    decoration: const InputDecoration(
                      labelText: 'Email Adresinizi Giriniz',
                      // textFielda kenarlık eklemek için
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextField(
                    controller: passwordController,
                    // kullanıcının yazdığı verileri gizle(şifre için)
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Şifrenizi Giriniz',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Rolünüzü Seçiniz',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  RadioGroup<String>(
                    groupValue: selectedRole,
                    onChanged: (value) {
                      setState(() {
                        selectedRole = value;
                      });
                    },
                    child: Column(
                      children: [
                        RadioListTile(
                          value: 'musteri',
                          title: const Text('MÜŞTERİ'),
                        ),
                        RadioListTile(
                          value: 'bayilik',
                          title: const Text('BAYİ'),
                        ),
                        RadioListTile(
                          value: 'yonetici',
                          title: const Text('YÖNETİCİ'),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      if (emailController.text.isEmpty ||
                          passwordController.text.isEmpty ||
                          selectedRole == null) {
                        showMessage(
                          context,
                          'Bilgileriniz eksik veya hatalı! Lütfen tekrar deneyiniz.',
                        );
                        return;
                      }
                      if (selectedRole == 'musteri') {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CustomerHome(),
                          ),
                        );
                      }
                      if (selectedRole == 'yonetici') {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ManagerHome(),
                          ),
                        );
                      }
                      if (selectedRole == 'bayilik') {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const BayiHome()),
                        );
                      }
                    },
                    child: const Text('Giriş Yap'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
