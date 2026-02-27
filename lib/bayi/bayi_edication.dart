import 'package:flutter/material.dart';
import 'package:ornek/widgets/app_bar.dart';

// BayiEdication : Eğitim videolarının izlenebildiği yer
class BayiEdication extends StatefulWidget {
  const BayiEdication({super.key});

  @override
  State<BayiEdication> createState() => _BayiEdicationState();
}

class _BayiEdicationState extends State<BayiEdication> {
  bool isCompleted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
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
                      onPressed: () {
                        isCompleted = true;
                      },
                      child: const Text('İzle'),
                    ),

                    SizedBox(height: 12),

                    Switch(
                      value: isCompleted,
                      onChanged: (value) {
                        setState(() {
                          isCompleted = value;
                        });
                      },
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
                      onPressed: () {
                        isCompleted = true;
                      },
                      child: const Text('İzle'),
                    ),

                    SizedBox(height: 12),

                    Switch(
                      value: isCompleted,
                      onChanged: (value) {
                        setState(() {
                          isCompleted = value;
                        });
                      },
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
                      onPressed: () {
                        isCompleted = true;
                      },
                      child: const Text('İzle'),
                    ),

                    SizedBox(height: 12),

                    Switch(
                      value: isCompleted,
                      onChanged: (value) {
                        setState(() {
                          isCompleted = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
