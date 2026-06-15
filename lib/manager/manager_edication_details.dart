// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:ornek/models/video_list_model.dart';
import 'package:ornek/models/video_details_model.dart';
import 'package:ornek/services/delete_video.dart';
import 'package:ornek/services/video_details.dart';
import 'package:ornek/services/notification.dart';
import 'package:ornek/widgets/app_bar.dart';
import 'package:ornek/widgets/show_message.dart';

// ManagerEdicationDetails : ilgili eğitim videolarının detaylı bilgilerinin gösterildiği sayfa
class ManagerEdicationDetails extends StatefulWidget {
  final int userId;
  final int videoDbId;
  final VideoListModel video;

  const ManagerEdicationDetails({
    super.key,
    required this.userId,
    required this.videoDbId,
    required this.video,
  });

  @override
  State<ManagerEdicationDetails> createState() =>
      _ManagerEdicationDetailsState();
}

class _ManagerEdicationDetailsState extends State<ManagerEdicationDetails> {
  List<VideoDetailsModel> bayiProgress = [];
  bool isLoading = true;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    fetchVideoProgress();
  }

  Future<void> fetchVideoProgress() async {
    try {
      final data = await VideoDetailsService.fetchVideoDetails(
        videoId: widget.videoDbId,
        bayiId: null,
      );

      setState(() {
        bayiProgress = data;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      showMessage(context, "Hata: $e");

      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> sendReminder(VideoDetailsModel item) async {
    try {
      final success = await NotificationService.createNotification(
        userId: item.userId,
        title: widget.video.title ?? "Eğitim Videosu",
        body: "İlgili Eğitim Videosunu Lütfen İzleyiniz",
      );

      if (success) {
        if (!mounted) return;

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Hatırlatma gönderildi")));
      } else {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Hatırlatma gönderilemedi")),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Hata: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredProgress = searchQuery.isEmpty
        ? bayiProgress
        : bayiProgress
              .where(
                (item) => item.title.toLowerCase().contains(
                  searchQuery.toLowerCase(),
                ),
              )
              .toList();

    return Scaffold(
      appBar: AppBarWidget(userId: widget.userId),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            bool success = await DeleteVideoService.deleteVideo(
              videoId: widget.videoDbId,
            );

            if (success) {
              if (!mounted) return;

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Video silindi")));

              Navigator.pop(context);
            }
          } catch (e) {
            if (!mounted) return;

            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Hata: $e")));
          }
        },
        child: const Icon(Icons.delete),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.video.title ?? "-",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text("Konu: ${widget.video.description ?? "-"}"),
                    const SizedBox(height: 8),
                    Text("Süre: ${widget.video.duration ?? "-"} sn"),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              decoration: InputDecoration(
                hintText: "Bayi ara...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),

            const SizedBox(height: 12),

            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text("Bayi")),
                            DataColumn(label: Text("İzlenme %")),
                            DataColumn(label: Text("Hatırlatma")),
                          ],
                          rows: filteredProgress.map((item) {
                            return DataRow(
                              cells: [
                                DataCell(Text(item.title)),
                                DataCell(
                                  Text(
                                    "${item.completionRate.toStringAsFixed(1)}%",
                                  ),
                                ),

                                DataCell(
                                  ElevatedButton(
                                    onPressed: () => sendReminder(item),
                                    child: const Text("Hatırlatma Gönder"),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
