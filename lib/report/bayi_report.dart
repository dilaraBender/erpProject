import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:ornek/models/bayi_report_model.dart';
import 'package:ornek/services/bayi_report.dart';
import 'package:ornek/widgets/app_bar.dart';

import '../widgets/summary.dart';

// BayiReport : Bayi raporlarının sayfası
class BayiReport extends StatefulWidget {
  const BayiReport({super.key});

  @override
  State<BayiReport> createState() => _BayiReportState();
}

class _BayiReportState extends State<BayiReport> {
  late Future<List<BayiReportModel>> _future;

  @override
  void initState() {
    super.initState();
    _future = BayiReportService.fetchReports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(userId: null),

      body: FutureBuilder<List<BayiReportModel>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text("Veri alınamadı"));
          }

          final dealers = snapshot.data!;

          dealers.sort(
            (a, b) => b.appointmentCount.compareTo(a.appointmentCount),
          );

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Bu ayın bayi randevu analizi",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      SummaryCard(
                        title: "Toplam Bayi",
                        value: "${dealers.length}",
                        icon: Icons.store,
                        color: Colors.blue,
                      ),
                      SummaryCard(
                        title: "Toplam Randevu",
                        value:
                            "${dealers.fold(0, (sum, e) => sum + e.appointmentCount)}",
                        icon: Icons.calendar_month,
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Bayi Randevu Grafiği",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  height: 220,
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
                              final i = value.toInt();
                              if (i < 0 || i >= dealers.length) {
                                return const Text('');
                              }
                              return Text(dealers[i].city);
                            },
                          ),
                        ),
                      ),

                      barGroups: List.generate(dealers.length, (i) {
                        final dealer = dealers[i];

                        return BarChartGroupData(
                          x: i,
                          barRods: [
                            BarChartRodData(
                              toY: dealer.appointmentCount.toDouble(),
                              width: 14,
                              color: Colors.blue,
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  "Randevu Sıralaması",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 12),

                ListView.builder(
                  itemCount: dealers.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final dealer = dealers[index];

                    return Card(
                      child: ListTile(
                        title: Text(dealer.bayiName),
                        subtitle: Text(dealer.city),
                        trailing: Text("${dealer.appointmentCount} randevu"),
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
