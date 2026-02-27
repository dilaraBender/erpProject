import 'package:flutter/material.dart';
import 'package:ornek/manager/manager_edication_add.dart';
import 'package:ornek/manager/manager_edication_details.dart';
import 'package:ornek/widgets/app_bar.dart';

// ManagerEdication : yönetici için eğitim videoları
class ManagerEdication extends StatefulWidget {
  const ManagerEdication({super.key});

  @override
  State<ManagerEdication> createState() => _ManagerEdicationState();
}

class _ManagerEdicationState extends State<ManagerEdication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Image.asset('resimler/drone.jpg', width: 80),

                      Text(
                        '1.Drone Eğitimi',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      SizedBox(height: 12),

                      Text('Konu: Drone Tanıma ve Ekipmanları'),

                      SizedBox(height: 12),

                      Text('Süre: 5.14'),

                      SizedBox(height: 12),

                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('İzle'),
                      ),

                      SizedBox(height: 12),

                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ManagerEdicationDetails(),
                            ),
                          );
                        },
                        child: const Text('Detay'),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Image.asset('resimler/batarya.jpg', width: 80),

                      Text(
                        '2.Batarya Eğitimi',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      SizedBox(height: 12),

                      Text('Konu: Batarya Çantası ve Batarya'),

                      SizedBox(height: 12),

                      Text('Süre: 3.48'),

                      SizedBox(height: 12),

                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('İzle'),
                      ),

                      SizedBox(height: 12),

                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Detay'),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Image.asset('resimler/kumanda.webp', width: 80),

                      Text(
                        '3.Kumanda Eğitimi',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      SizedBox(height: 12),

                      Text('Konu: Drone Kumandası ve Kullanımı'),

                      SizedBox(height: 12),

                      Text('Süre: 8.32'),

                      SizedBox(height: 12),

                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('İzle'),
                      ),

                      SizedBox(height: 12),

                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Detay'),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ManagerEdicationAdd(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Yeni Eğitim Ekle"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
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
