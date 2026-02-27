import 'package:flutter/material.dart';
import 'package:ornek/theme_provider.dart';
import 'package:provider/provider.dart';

// Settings : Uygulamanın görünüm,bildirim gibi ayarlarını ayarlamak için kullanılan ortak ekran

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool notificationsEnabled = true;
  bool darkModeEnabled = false;
  String selectedLanguage = "tr";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          const Text(
            "BİLDİRİMLER",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: SwitchListTile(
              title: const Text("Bildirimler"),
              value: notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  notificationsEnabled = value;
                });
              },
            ),
          ),

          const SizedBox(height: 16),

          const Text(
            "GÖRÜNÜM",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text("Karanlık Mod"),
                  value: Provider.of<ThemeProvider>(context).isDarkMode,
                  onChanged: (value) {
                    // Tema değiştirme işlemi ThemeProvider'da yapılır
                    Provider.of<ThemeProvider>(
                      context,
                      listen: false,
                    ).toggleTheme(value);
                  },
                ),

                ListTile(
                  title: const Text("Dil"),
                  trailing: DropdownButton<String>(
                    value: selectedLanguage,
                    underline: const SizedBox(),
                    items: const [
                      DropdownMenuItem(value: "tr", child: Text("Türkçe")),
                      DropdownMenuItem(value: "en", child: Text("English")),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedLanguage = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          const Text(
            "HAKKINDA",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          ListTile(title: Text("Versiyon"), trailing: Text("1.0.0")),

          // Yatay ince çizgi
          Divider(height: 0),

          ListTile(title: Text("Geliştirici"), trailing: Text("PATA")),
        ],
      ),
    );
  }
}
