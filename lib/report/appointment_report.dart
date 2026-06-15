import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:ornek/services/appointment_report.dart';
import 'package:ornek/widgets/app_bar.dart';
import '../models/appointment_report_model.dart';
import '../widgets/summary.dart';

// AppointmentReport : randevu raporları sayfası
class AppointmentReport extends StatefulWidget {
  const AppointmentReport({super.key});

  @override
  State<AppointmentReport> createState() => _AppointmentReportState();
}

class _AppointmentReportState extends State<AppointmentReport> {
  late Future<List<AppointmentReportModel>> _future;

  @override
  void initState() {
    super.initState();
    _future = AppointmentReportService.getReport();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(userId: null),

      body: FutureBuilder<List<AppointmentReportModel>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Hata: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Veri bulunamadı"));
          }

          final data = snapshot.data!;

          final completed = data
              .where((e) => e.status.toLowerCase() == "completed")
              .length;
          final pending = data
              .where((e) => e.status.toLowerCase() == "pending")
              .length;
          final cancelled = data
              .where((e) => e.status.toLowerCase() == "cancelled")
              .length;

          final int total = completed + pending + cancelled;

          final ratedItems = data.where((e) => e.rating != null).toList();

          final double avgRating = ratedItems.isEmpty
              ? 0
              : ratedItems.map((e) => e.rating!).reduce((a, b) => a + b) /
                    ratedItems.length;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Bu ayın randevu analiz raporu",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      SummaryCard(
                        title: "Toplam",
                        value: "${data.length}",
                        icon: Icons.event,
                        color: Colors.blue,
                      ),
                      SummaryCard(
                        title: "Tamamlanan",
                        value: "$completed",
                        icon: Icons.check_circle,
                        color: Colors.green,
                      ),
                      SummaryCard(
                        title: "Bekleyen",
                        value: "$pending",
                        icon: Icons.schedule,
                        color: Colors.orange,
                      ),
                      SummaryCard(
                        title: "İptal",
                        value: "$cancelled",
                        icon: Icons.cancel,
                        color: Colors.red,
                      ),

                      // ⭐ RATING CARD
                      SummaryCard(
                        title: "Ortalama Rating",
                        value: avgRating.toStringAsFixed(1),
                        icon: Icons.star,
                        color: Colors.amber,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Randevu Durum Dağılımı",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  height: 220,
                  child: PieChart(
                    PieChartData(
                      centerSpaceRadius: 40,
                      sectionsSpace: 2,
                      startDegreeOffset: -90,
                      sections: total == 0
                          ? [
                              PieChartSectionData(
                                value: 1,
                                color: Colors.grey,
                                title: "No Data",
                                radius: 80,
                              ),
                            ]
                          : [
                              PieChartSectionData(
                                value: completed.toDouble(),
                                color: Colors.green,
                                title: "Tam",
                                radius: 80,
                              ),
                              PieChartSectionData(
                                value: pending.toDouble(),
                                color: Colors.orange,
                                title: "Bek",
                                radius: 80,
                              ),
                              PieChartSectionData(
                                value: cancelled.toDouble(),
                                color: Colors.red,
                                title: "İpt",
                                radius: 80,
                              ),
                            ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  "Randevu Listesi",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 12),

                ListView.builder(
                  itemCount: data.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final a = data[index];

                    final status = a.status.toLowerCase();

                    Color color;
                    String statusText;

                    if (status == "completed") {
                      color = Colors.green;
                      statusText = "Tamamlandı";
                    } else if (status == "pending") {
                      color = Colors.orange;
                      statusText = "Bekliyor";
                    } else {
                      color = Colors.red;
                      statusText = "İptal";
                    }

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: Icon(Icons.event, color: color),

                        title: Text(a.customerName),

                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${a.dealerName} • ${a.appDateTime}"),

                            const SizedBox(height: 4),

                            Row(
                              children: [
                                const Text("Rating: "),
                                const SizedBox(width: 4),

                                Icon(Icons.star, color: Colors.amber, size: 18),

                                Text(
                                  a.rating != null ? a.rating.toString() : "-",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        trailing: Text(
                          statusText,
                          style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.bold,
                          ),
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
