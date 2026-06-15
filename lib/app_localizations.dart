import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static Map<String, Map<String, String>> localizedValues = {
    'tr': {
      'notifications': 'Bildirimler',
      'notifications_on': 'Bildirimler açık',
      'notifications_off': 'Bildirimler kapalı',
      'dark_mode': 'Karanlık Mod',
      'language': 'Dil',
      'appearance': 'Görünüm',
      'about': 'Hakkında',
      'version': 'Versiyon',
      'developer': 'Geliştirici',
    },
    'en': {
      'notifications': 'Notifications',
      'notifications_on': 'Notifications enabled',
      'notifications_off': 'Notifications disabled',
      'dark_mode': 'Dark Mode',
      'language': 'Language',
      'appearance': 'Appearance',
      'about': 'About',
      'version': 'Version',
      'developer': 'Developer',
    },
  };

  String get notifications =>
      localizedValues[locale.languageCode]!['notifications']!;

  String get notificationsOn =>
      localizedValues[locale.languageCode]!['notifications_on']!;

  String get notificationsOff =>
      localizedValues[locale.languageCode]!['notifications_off']!;

  String get darkMode => localizedValues[locale.languageCode]!['dark_mode']!;

  String get language => localizedValues[locale.languageCode]!['language']!;

  String get appearance => localizedValues[locale.languageCode]!['appearance']!;

  String get about => localizedValues[locale.languageCode]!['about']!;

  String get version => localizedValues[locale.languageCode]!['version']!;

  String get developer => localizedValues[locale.languageCode]!['developer']!;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['tr', 'en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_) => false;
}
