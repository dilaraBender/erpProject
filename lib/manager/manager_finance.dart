// ignore_for_file: use_build_context_synchronously, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:ornek/manager/manager_finance_add.dart';
import 'package:ornek/models/finance_model.dart';
import 'package:ornek/models/finance_list_model.dart';
import 'package:ornek/services/delete_expense.dart';
import 'package:ornek/services/delete_income.dart';
import 'package:ornek/services/finance_list.dart';
import 'package:ornek/widgets/app_bar.dart';
import 'package:ornek/widgets/show_message.dart';

// ManagerFinance : finans işlemlerinin listelendiği sayfa

class ManagerFinance extends StatefulWidget {
  final int userId;
  const ManagerFinance({super.key, required this.userId});

  @override
  State<ManagerFinance> createState() => _ManagerFinanceState();
}

class _ManagerFinanceState extends State<ManagerFinance> {
  String selectedDateFilter = "Tümü";
  String selectedFinanceFilter = "Tümü";

  List<FinanceModel> financeList = [];
  bool isLoading = true;

  double totalIncome = 0;
  double totalExpense = 0;

  @override
  void initState() {
    super.initState();
    fetchFinanceList();
  }

  Future<void> fetchFinanceList() async {
    setState(() {
      isLoading = true;
    });

    try {
      final data = await FinanceListService.fetchFinanceList(
        FinanceListModel(
          userId: widget.userId,
          financeType: selectedFinanceFilter,
          dateFilter: selectedDateFilter,
        ),
      );

      double income = 0;
      double expense = 0;

      for (var item in data) {
        if (item.type == "Income") {
          income += item.price;
        } else {
          expense += item.price;
        }
      }

      setState(() {
        financeList = data;
        totalIncome = income;
        totalExpense = expense;
      });
    } catch (e) {
      showMessage(context, "API Hatası: $e");
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double net = totalIncome - totalExpense;

    return Scaffold(
      appBar: AppBarWidget(userId: widget.userId),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ManagerFinanceAdd(userId: widget.userId),
            ),
          );
          fetchFinanceList();
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: selectedFinanceFilter,
                    items: ["Tümü", "Income", "Expense"]
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e == "Income"
                                  ? "Gelir"
                                  : e == "Expense"
                                  ? "Gider"
                                  : "Tümü",
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedFinanceFilter = value ?? "Tümü";
                      });
                      fetchFinanceList();
                    },
                    decoration: InputDecoration(
                      labelText: "Tür",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: selectedDateFilter,
                    items: ["Tümü", "Bugün", "Bu Hafta", "Bu Ay"]
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedDateFilter = value ?? "Tümü";
                      });
                      fetchFinanceList();
                    },
                    decoration: InputDecoration(
                      labelText: "Tarih",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: buildCard(
                    "Gelir",
                    "${totalIncome.toStringAsFixed(2)} ₺",
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: buildCard(
                    "Gider",
                    "${totalExpense.toStringAsFixed(2)} ₺",
                    Colors.red,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            buildCard("Net Kazanç", "${net.toStringAsFixed(2)} ₺", Colors.blue),

            const SizedBox(height: 20),

            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : financeList.isEmpty
                  ? const Center(child: Text("Veri bulunamadı"))
                  : ListView.builder(
                      itemCount: financeList.length,
                      itemBuilder: (context, index) {
                        final item = financeList[index];
                        bool isIncome = item.type == "Income";

                        return Card(
                          margin: const EdgeInsets.only(bottom: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: isIncome
                                  ? Colors.green.shade100
                                  : Colors.red.shade100,
                              child: Icon(
                                isIncome
                                    ? Icons.arrow_downward
                                    : Icons.arrow_upward,
                                color: isIncome ? Colors.green : Colors.red,
                              ),
                            ),
                            title: Text(
                              item.description,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(item.date.toString()),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,

                              children: [
                                Text(
                                  "${isIncome ? '+' : '-'}${item.price} ₺",
                                  style: TextStyle(
                                    color: isIncome ? Colors.green : Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(width: 10),

                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () async {
                                    bool success = false;

                                    if (isIncome) {
                                      success =
                                          await DeleteIncomeService.deleteIncome(
                                            item.id,
                                          );
                                    } else {
                                      success =
                                          await DeleteExpenseService.deleteExpense(
                                            item.id,
                                          );
                                    }

                                    if (success) {
                                      fetchFinanceList();
                                      showMessage(context, "Kayıt silindi");
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),

      child: Column(
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),

          const SizedBox(height: 8),

          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
