import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:ornek/models/create_video_model.dart';
import 'package:ornek/services/create_video.dart';
import 'package:ornek/widgets/app_bar.dart';

// ManagerEdicationAdd : Yönetici için eğitim videosu ekleme sayfası
class ManagerEdicationAdd extends StatefulWidget {
  final int userId;

  const ManagerEdicationAdd({super.key, required this.userId});

  @override
  State<ManagerEdicationAdd> createState() => _ManagerEdicationAddState();
}

class _ManagerEdicationAddState extends State<ManagerEdicationAdd> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController commendController = TextEditingController();
  final TextEditingController headerController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();

  // Video seçme için
  final ImagePicker picker = ImagePicker();

  File? selectedVideo;

  @override
  void dispose() {
    commendController.dispose();
    headerController.dispose();
    timeController.dispose();
    subjectController.dispose();
    super.dispose();
  }

  // Video seçme fonksiyonu
  Future<void> pickVideo() async {
    final XFile? video = await picker.pickVideo(source: ImageSource.gallery);

    if (video != null) {
      setState(() {
        selectedVideo = File(video.path);
      });
    }
  }

  // Video kaydetme fonksiyonu
  Future<void> saveVideo() async {
    if (!_formKey.currentState!.validate()) return;

    // Video seçilmiş mi kontrol et
    if (selectedVideo == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Lütfen bir video seçiniz")));
      return;
    }

    final video = CreateVideoModel(
      title: headerController.text,
      description: commendController.text,
      duration: int.tryParse(timeController.text) ?? 0,
      url: selectedVideo!.path,
      videoType: "mp4",
      createdAt: DateTime.now(),
      status: "Aktif",
    );

    bool success = await CreateVideoService.createVideo(video);

    if (success) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Video başarıyla eklendi")));

      Navigator.pop(context);
    } else {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Video eklenemedi")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(userId: widget.userId),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Form(
          key: _formKey,

          child: Card(
            elevation: 4,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),

            child: Padding(
              padding: const EdgeInsets.all(16),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,

                children: [
                  const Text(
                    'Yeni Eğitim Videosu Ekle',

                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),

                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 16),

                  // Başlık
                  TextFormField(
                    controller: headerController,

                    decoration: const InputDecoration(
                      labelText: 'Başlık',
                      border: OutlineInputBorder(),
                    ),

                    validator: (value) => value == null || value.isEmpty
                        ? "Başlık boş bırakılamaz!"
                        : null,
                  ),

                  const SizedBox(height: 12),

                  // Konu
                  TextFormField(
                    controller: subjectController,

                    decoration: const InputDecoration(
                      labelText: 'Konu',
                      border: OutlineInputBorder(),
                    ),

                    validator: (value) => value == null || value.isEmpty
                        ? "Konu boş bırakılamaz!"
                        : null,
                  ),

                  const SizedBox(height: 12),

                  // Süre
                  TextFormField(
                    controller: timeController,

                    keyboardType: TextInputType.number,

                    decoration: const InputDecoration(
                      labelText: 'Süre (dk)',
                      border: OutlineInputBorder(),
                    ),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Süre boş bırakılamaz";
                      }

                      if (int.tryParse(value) == null) {
                        return "Geçerli bir sayı giriniz";
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 12),

                  // Açıklama
                  TextFormField(
                    controller: commendController,

                    maxLines: 3,

                    decoration: const InputDecoration(
                      labelText: 'Açıklama',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Video seç butonu
                  ElevatedButton.icon(
                    onPressed: pickVideo,

                    icon: const Icon(Icons.video_library),

                    label: const Text('Video Seç'),
                  ),

                  const SizedBox(height: 12),

                  // Seçilen video bilgisi
                  Container(
                    padding: const EdgeInsets.all(12),

                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),

                      borderRadius: BorderRadius.circular(8),
                    ),

                    child: Row(
                      children: [
                        const Icon(Icons.movie),

                        const SizedBox(width: 8),

                        Expanded(
                          child: Text(
                            selectedVideo == null
                                ? "Henüz video seçilmedi"
                                : selectedVideo!.path.split('/').last,

                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Kaydet butonu
                  ElevatedButton(
                    onPressed: saveVideo,

                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),

                    child: const Text('Kaydet'),
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
