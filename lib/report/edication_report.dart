import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:ornek/services/video_report.dart';
import 'package:ornek/widgets/app_bar.dart';
import '../models/video_report_model.dart';
import '../widgets/summary.dart';

// EducaitionVideoReport : eğitim videolarının rapor sayfası
class EducationVideoReport extends StatefulWidget {
  const EducationVideoReport({super.key});

  @override
  State<EducationVideoReport> createState() => _EducationVideoReportState();
}

class _EducationVideoReportState extends State<EducationVideoReport> {
  late Future<List<VideoReportModel>> _futureVideos;

  @override
  void initState() {
    super.initState();
    _futureVideos = VideoReportService.getVideoReport();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(userId: null),

      body: FutureBuilder<List<VideoReportModel>>(
        future: _futureVideos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Hata: ${snapshot.error}"));
          }

          final videos = snapshot.data ?? [];

          if (videos.isEmpty) {
            return const Center(child: Text("Veri bulunamadı"));
          }

          final totalViews = videos.fold<int>(0, (sum, v) => sum + v.views);

          final avgCompletion = videos.isNotEmpty
              ? videos.map((e) => e.avgCompletion).reduce((a, b) => a + b) /
                    videos.length
              : 0;

          final completed = videos.where((e) => e.avgCompletion >= 80).length;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Eğitim videoları performans analizi",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      SummaryCard(
                        title: "Toplam Video",
                        value: videos.length.toString(),
                        icon: Icons.video_library,
                        color: Colors.blue,
                      ),
                      SummaryCard(
                        title: "Toplam İzlenme",
                        value: totalViews.toString(),
                        icon: Icons.visibility,
                        color: Colors.green,
                      ),
                      SummaryCard(
                        title: "Tamamlanan",
                        value: completed.toString(),
                        icon: Icons.check_circle,
                        color: Colors.orange,
                      ),
                      SummaryCard(
                        title: "Ort. Tamamlanma",
                        value: "%${avgCompletion.toStringAsFixed(0)}",
                        icon: Icons.analytics,
                        color: Colors.purple,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Video Performans Grafiği",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  height: 250,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      borderData: FlBorderData(show: false),
                      gridData: const FlGridData(show: false),

                      titlesData: FlTitlesData(
                        leftTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),

                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              final index = value.toInt();
                              if (index >= videos.length) {
                                return const Text("");
                              }

                              return Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  videos[index].title,
                                  style: const TextStyle(fontSize: 10),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      barGroups: videos.asMap().entries.map((entry) {
                        final i = entry.key;
                        final v = entry.value;

                        return BarChartGroupData(
                          x: i,
                          barRods: [
                            BarChartRodData(
                              toY: v.views.toDouble(),
                              color: Colors.blue,
                              width: 10,
                            ),
                            BarChartRodData(
                              toY: v.avgCompletion,
                              color: Colors.green,
                              width: 10,
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  "Video Listesi",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 12),

                ListView.builder(
                  itemCount: videos.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),

                  itemBuilder: (context, index) {
                    final v = videos[index];

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),

                      child: ListTile(
                        leading: const Icon(Icons.play_circle_fill),

                        title: Text(v.title),

                        subtitle: Text(
                          "İzlenme: ${v.views} • Tamamlanma: %${v.avgCompletion.toStringAsFixed(0)}",
                        ),

                        trailing: Text(
                          "${v.completedCount} kişi",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
