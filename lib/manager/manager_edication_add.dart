import 'package:flutter/material.dart';
import 'package:ornek/widgets/app_bar.dart';

// ManagerEdicationAdd : Yönetici için eğitim videosu ekleme sayfası
class ManagerEdicationAdd extends StatefulWidget {
  const ManagerEdicationAdd({super.key});
  @override
  State<ManagerEdicationAdd> createState() => _ManagerUserState();
}

class _ManagerUserState extends State<ManagerEdicationAdd> {
  // controller
  final TextEditingController commendController = TextEditingController();
  final TextEditingController headerController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();

  String selectedRole = 'musteri';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text('Yeni Eğitim Videosu Ekle'),

                  TextFormField(
                    controller: headerController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelText: 'Başlık',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Başlık boş bırakılamaz!" : null,
                  ),

                  const SizedBox(height: 12),

                  TextFormField(
                    controller: subjectController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelText: 'Konu',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Konu boş bırakılamaz!" : null,
                  ),

                  const SizedBox(height: 12),

                  TextFormField(
                    controller: timeController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelText: 'Süre',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return "Süre boş bırakılamaz";
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 12),

                  TextFormField(
                    controller: commendController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelText: 'Açıklama',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 12),

                  ElevatedButton(onPressed: () {}, child: Text('Video Seç')),

                  const SizedBox(height: 12),

                  ElevatedButton(onPressed: () {}, child: Text('Kaydet')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
