// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:ornek/models/video_list_model.dart';
import 'package:ornek/services/video_list.dart';
import 'package:ornek/widgets/app_bar.dart';
import 'package:ornek/widgets/show_message.dart';
import 'package:ornek/widgets/video_player_page.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// BayiEdication : bayi eğitim videolarının gösterildiği sayfa
class BayiEdication extends StatefulWidget {
  final int userId;
  final int bayiId;

  const BayiEdication({super.key, required this.userId, required this.bayiId});

  @override
  State<BayiEdication> createState() => _BayiEdicationState();
}

class _BayiEdicationState extends State<BayiEdication> {
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

      showMessage(context, "Video listesi alınamadı");
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

                  // YouTube ID (string)
                  final youtubeId = video.url != null
                      ? YoutubePlayer.convertUrlToId(video.url!)
                      : null;

                  final thumbnail = youtubeId != null
                      ? "https://img.youtube.com/vi/$youtubeId/0.jpg"
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

                              const SizedBox(height: 14),

                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  icon: const Icon(Icons.play_arrow),
                                  label: const Text("İzle"),
                                  onPressed: () {
                                    if (youtubeId != null) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => VideoPlayerPage(
                                            videoId: video.videoId, // SQL INT
                                            youtubeId: youtubeId, // STRING
                                            bayiId: widget.bayiId,
                                          ),
                                        ),
                                      );
                                    } else {
                                      showMessage(context, "Video açılamadı");
                                    }
                                  },
                                ),
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
    );
  }
}
