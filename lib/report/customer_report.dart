// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:ornek/models/customer_report_model.dart';
import 'package:ornek/services/customer_report.dart';
import 'package:ornek/widgets/app_bar.dart';

// CustomerReport : müşteri raporlarının sayfası
class CustomerReport extends StatefulWidget {
  const CustomerReport({super.key});

  @override
  State<CustomerReport> createState() => _CustomerReportState();
}

class _CustomerReportState extends State<CustomerReport> {
  late Future<List<CustomerReportModel>> _future;

  @override
  void initState() {
    super.initState();
    _future = CustomerReportService.getCustomerReport();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(userId: null),

      body: FutureBuilder<List<CustomerReportModel>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return const Center(child: Text("Veri yok"));
          }

          final customers = snapshot.data!;

          final activeCount = customers.where((x) => x.score >= 50).length;
          final passiveCount = customers.where((x) => x.score < 50).length;

          final avgScore = customers.isEmpty
              ? 0
              : customers.map((e) => e.score).reduce((a, b) => a + b) /
                    customers.length;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const Text(
                  "Bu ayın müşteri aktivite analizi",
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
                        value: "${customers.length}",
                        icon: Icons.people,
                        color: Colors.blue,
                      ),
                      SummaryCard(
                        title: "Aktif",
                        value: "$activeCount",
                        icon: Icons.check_circle,
                        color: Colors.green,
                      ),
                      SummaryCard(
                        title: "Pasif",
                        value: "$passiveCount",
                        icon: Icons.cancel,
                        color: Colors.red,
                      ),
                      SummaryCard(
                        title: "Ort. Puan",
                        value: "%${avgScore.toInt()}",
                        icon: Icons.insights,
                        color: Colors.orange,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Müşteri Durum Dağılımı",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  height: 220,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 2,
                      centerSpaceRadius: 40,

                      sections: [
                        PieChartSectionData(
                          value: activeCount.toDouble(),
                          color: Colors.green,
                          title: "Aktif",
                          radius: 80,
                          titleStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        PieChartSectionData(
                          value: passiveCount.toDouble(),
                          color: Colors.red,
                          title: "Pasif",
                          radius: 80,
                          titleStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  "Müşteri Aktivite Sıralaması",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 12),

                ListView.builder(
                  itemCount: customers.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),

                  itemBuilder: (context, index) {
                    final c = customers[index];

                    final score = c.score;

                    Color color;
                    if (score >= 80) {
                      color = Colors.green;
                    } else if (score >= 50) {
                      color = Colors.orange;
                    } else {
                      color = Colors.red;
                    }

                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.only(bottom: 12),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(16),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: color.withOpacity(0.15),
                                  child: Icon(Icons.person, color: color),
                                ),

                                const SizedBox(width: 12),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        c.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        c.city,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Text(
                                  "${score.toInt()}",
                                  style: TextStyle(
                                    color: color,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                infoItem(
                                  Icons.calendar_month,
                                  "${c.appointment}",
                                  "Randevu",
                                ),
                                infoItem(
                                  Icons.access_time,
                                  c.lastActive,
                                  "Son Aktivite",
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            LinearProgressIndicator(
                              value: score / 100,
                              minHeight: 8,
                              borderRadius: BorderRadius.circular(10),
                              color: color,
                              backgroundColor: Colors.grey.shade300,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.picture_as_pdf),
                        label: const Text("PDF"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.table_chart),
                        label: const Text("Excel"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  static Widget infoItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const SummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 30),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(title),
        ],
      ),
    );
  }
}
