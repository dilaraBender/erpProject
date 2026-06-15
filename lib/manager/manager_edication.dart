// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:ornek/manager/manager_edication_add.dart';
import 'package:ornek/manager/manager_edication_details.dart';
import 'package:ornek/models/video_list_model.dart';
import 'package:ornek/services/video_list.dart';
import 'package:ornek/widgets/app_bar.dart';
import 'package:ornek/widgets/show_message.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// ManagerEdication : Eğitim videolarının listelendiği sayfa
class ManagerEdication extends StatefulWidget {
  final int userId;
  const ManagerEdication({super.key, required this.userId});

  @override
  State<ManagerEdication> createState() => _ManagerEdicationState();
}

class _ManagerEdicationState extends State<ManagerEdication> {
  List<VideoListModel> videos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchVideos();
  }

  void fetchVideos() async {
    try {
      final videoList = await VideoListService.fetchVideos();
      if (!mounted) return;

      setState(() {
        videos = videoList;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });
      showMessage(context, "Video listesi alınamadı: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(userId: widget.userId),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.separated(
                itemCount: videos.length,
                separatorBuilder: (_, _) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final video = videos[index];

                  final videoId = video.url != null
                      ? YoutubePlayer.convertUrlToId(video.url!)
                      : null;

                  final thumbnail = videoId != null
                      ? "https://img.youtube.com/vi/$videoId/0.jpg"
                      : null;

                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (thumbnail != null)
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                                child: Image.network(
                                  thumbnail,
                                  height: 180,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  // ignore: deprecated_member_use
                                  color: Colors.black.withOpacity(0.4),
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(12),
                                child: const Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                            ],
                          ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${index + 1}. ${video.title ?? ''}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text('Konu: ${video.description ?? '-'}'),
                              const SizedBox(height: 6),
                              Text(
                                'Süre: ${video.duration?.toString() ?? '-'} sn',
                              ),
                              const SizedBox(height: 12),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.visibility,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () {
                                      print(
                                        "SEÇİLEN VIDEO ID: ${video.videoId}",
                                      );

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              ManagerEdicationDetails(
                                                userId: widget.userId,
                                                videoDbId: video.videoId,
                                                video: video,
                                              ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ManagerEdicationAdd(userId: widget.userId),
            ),
          ).then((_) => fetchVideos());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
