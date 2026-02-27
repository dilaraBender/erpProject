import 'package:flutter/material.dart';
import 'package:ornek/login.dart';
import 'package:ornek/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  // runApp uygulamayı çalıştıran fonksiyondur
  runApp(
    // changeNotifierProvider ile ThemeProvideri tüm uygulamaya erişilebilir yapıyoruz dark mode için
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const Uygulamam(),
    ),
  );
}

// Stateless değşmeyen sabit
// state değişen verilerin sayfa içinde bulundugunu söyler
// sabit UI'lerde Stateless kullanıyoruz çünkü daha az maliyetli
class Uygulamam extends StatelessWidget {
  const Uygulamam({super.key});

  //UI her çizildiğinde build çalışır
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      // Sağ üstteki Debug yazısını kapat
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      // bu proje login sayfası ile başlasın
      home: LoginPage(),
    );
  }
}
