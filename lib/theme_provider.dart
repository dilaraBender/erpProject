import 'package:flutter/material.dart';

// ThemeProvider : uygulamaya karanlık ve aydınlık mod olarak iki görünüm seçeneği sunar

// notifyListeners kullanmak için changeNotifier kullanıyoruz
class ThemeProvider extends ChangeNotifier {
  // uygulamanın güncel teması
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;
  // tema karanlık ise true değilse false
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  //
  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    // themeProvideri kullanan tüm sayfaları build eder
    notifyListeners();
  }
}
