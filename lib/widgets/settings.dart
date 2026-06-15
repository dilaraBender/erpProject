import 'package:flutter/material.dart';
import 'package:ornek/app_localizations.dart';
import 'package:ornek/language.dart';
import 'package:ornek/theme_provider.dart';
import 'package:ornek/widgets/chanage_pasword.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

// Settings : Uygulamanın görünüm,bildirim gibi ayarlarını ayarlamak için kullanılan ortak ekran
class Settings extends StatefulWidget {
  final int userId;
  const Settings({super.key, required this.userId});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool notificationsEnabled = false;

  @override
  void initState() {
    super.initState();
    loadNotificationStatus();
  }

  Future<void> loadNotificationStatus() async {
    final status = await Permission.notification.status;

    setState(() {
      notificationsEnabled = status.isGranted;
    });
  }

  Future<void> toggleNotifications(bool value) async {
    if (value) {
      final result = await Permission.notification.request();

      setState(() {
        notificationsEnabled = result.isGranted;
      });
    } else {
      await openAppSettings();

      final status = await Permission.notification.status;

      setState(() {
        notificationsEnabled = status.isGranted;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final lang = AppLocalizations.of(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          /// NOTIFICATIONS
          Text(
            lang.notifications.toUpperCase(),
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: SwitchListTile(
              title: Text(lang.notifications),
              subtitle: Text(
                notificationsEnabled
                    ? lang.notificationsOn
                    : lang.notificationsOff,
              ),
              value: notificationsEnabled,
              onChanged: toggleNotifications,
            ),
          ),

          const SizedBox(height: 16),

          /// HESAP
          const Text(
            "HESAP",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(Icons.lock_outline),
              title: const Text("Şifre Değiştir"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ChangePasswordPage(userId: widget.userId),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          /// APPEARANCE
          Text(
            lang.appearance.toUpperCase(),
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                SwitchListTile(
                  title: Text(lang.darkMode),
                  value: themeProvider.isDarkMode,
                  onChanged: (value) {
                    themeProvider.toggleTheme(value);
                  },
                ),

                Consumer<LanguageProvider>(
                  builder: (context, languageProvider, child) {
                    return ListTile(
                      title: Text(lang.language),
                      trailing: DropdownButton<String>(
                        value: languageProvider.locale.languageCode,
                        underline: const SizedBox(),
                        items: const [
                          DropdownMenuItem(value: "tr", child: Text("Türkçe")),
                          DropdownMenuItem(value: "en", child: Text("English")),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            languageProvider.changeLanguage(value);
                          }
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          /// ABOUT
          Text(
            lang.about.toUpperCase(),
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          ListTile(title: Text(lang.version), trailing: const Text("1.0.0")),

          const Divider(height: 0),

          ListTile(title: Text(lang.developer), trailing: const Text("PATA")),
        ],
      ),
    );
  }
}
