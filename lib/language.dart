import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('tr');

  Locale get locale => _locale;

  void changeLanguage(String code) {
    _locale = Locale(code);
    notifyListeners();
  }
}
