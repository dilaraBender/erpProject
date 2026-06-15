// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:ornek/services/start_video_progress.dart';
import 'package:ornek/services/update_video_progress.dart';
import 'package:ornek/widgets/show_message.dart';
import 'package:ornek/widgets/app_bar.dart';

class VideoPlayerPage extends StatefulWidget {
  final int videoId; // SQL ID
  final String youtubeId; // YouTube ID
  final int bayiId;

  const VideoPlayerPage({
    super.key,
    required this.videoId,
    required this.youtubeId,
    required this.bayiId,
  });

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late YoutubePlayerController _controller;
  int lastSentSecond = -1;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: widget.youtubeId,
      flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
    );

    _controller.addListener(videoListener);

    startVideoProgress();
  }

  // START
  void startVideoProgress() async {
    final result = await StartVideoProgressService.startVideoProgress(
      bayiId: widget.bayiId,
      videoId: widget.videoId,
    );

    if (result) {
      showMessage(context, "Video izleme başlatıldı");
    } else {
      showMessage(context, "Başlatılamadı");
    }
  }

  // LISTENER
  void videoListener() {
    final position = _controller.value.position.inSeconds;
    final duration = _controller.metadata.duration.inSeconds;

    if (duration == 0) return;

    if (position % 5 == 0 && position != lastSentSecond) {
      lastSentSecond = position;
      updateVideoProgress(position, duration);
    }
  }

  // UPDATE
  void updateVideoProgress(int watched, int total) async {
    final result = await UpdateVideoProgressService.updateVideoProgress(
      bayiId: widget.bayiId,
      videoId: widget.videoId,
      watchedDuration: watched,
      totalDuration: total,
    );

    if (result) {
      showMessage(context, "Progress: $watched / $total");
    } else {
      showMessage(context, "Progress güncellenemedi");
    }
  }

  @override
  void dispose() {
    final position = _controller.value.position.inSeconds;
    final duration = _controller.metadata.duration.inSeconds;

    updateVideoProgress(position, duration);

    _controller.removeListener(videoListener);
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(userId: null),
      body: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
      ),
    );
  }
}
