// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:ornek/widgets/app_bar.dart';

// FinanceReport : finans raporları sayfası
class FinanceReport extends StatelessWidget {
  const FinanceReport({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions = [
      {"title": "Bayi Komisyonu", "amount": 12000, "type": "income"},
      {"title": "Eğitim Geliri", "amount": 5000, "type": "income"},
      {"title": "Sistem Gideri", "amount": 2000, "type": "expense"},
    ];

    return Scaffold(
      appBar: AppBarWidget(userId: null),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              "Aylık finansal özet analiz",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,

                children: const [
                  SummaryCard(
                    title: "Toplam Gelir",
                    value: "₺17.000",
                    icon: Icons.trending_up,
                    color: Colors.green,
                  ),

                  SummaryCard(
                    title: "Toplam Gider",
                    value: "₺2.000",
                    icon: Icons.trending_down,
                    color: Colors.red,
                  ),

                  SummaryCard(
                    title: "Net Kazanç",
                    value: "₺15.000",
                    icon: Icons.account_balance_wallet,
                    color: Colors.blue,
                  ),

                  SummaryCard(
                    title: "İşlem",
                    value: "3",
                    icon: Icons.receipt_long,
                    color: Colors.orange,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Gelir - Gider Dağılımı",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            SizedBox(
              height: 220,

              child: PieChart(
                PieChartData(
                  centerSpaceRadius: 40,
                  sectionsSpace: 2,

                  sections: [
                    PieChartSectionData(
                      value: 17000,
                      color: Colors.green,
                      title: "Gelir",
                      radius: 80,
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    PieChartSectionData(
                      value: 2000,
                      color: Colors.red,
                      title: "Gider",
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
              "Finans İşlemleri",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            ListView.builder(
              itemCount: transactions.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),

              itemBuilder: (context, index) {
                final t = transactions[index];
                final bool isIncome = t["type"] == "income";

                final color = isIncome ? Colors.green : Colors.red;
                final icon = isIncome
                    ? Icons.arrow_upward
                    : Icons.arrow_downward;

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),

                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: color.withOpacity(0.15),
                      child: Icon(icon, color: color),
                    ),

                    title: Text(t["title"].toString()),
                    subtitle: Text(isIncome ? "Gelir" : "Gider"),

                    trailing: Text(
                      "₺${t["amount"]}",
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
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
      ),
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
          Icon(icon, color: color),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(title),
        ],
      ),
    );
  }
}
