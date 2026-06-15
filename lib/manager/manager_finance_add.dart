// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:ornek/services/create_expense.dart';
import 'package:ornek/services/create_income.dart';
import 'package:ornek/widgets/app_bar.dart';
import 'package:ornek/models/create_income_model.dart';
import 'package:ornek/models/create_expense_model.dart';

// ManagerFinanceAdd : Finans işlemlerinin oluşturulduğu sayfa
class ManagerFinanceAdd extends StatefulWidget {
  final int userId;
  const ManagerFinanceAdd({super.key, required this.userId});

  @override
  State<ManagerFinanceAdd> createState() => _ManagerFinanceAddState();
}

class _ManagerFinanceAddState extends State<ManagerFinanceAdd> {
  // Controller
  final TextEditingController dateController = TextEditingController();
  final TextEditingController moneyController = TextEditingController();
  final TextEditingController processController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    dateController.dispose();
    moneyController.dispose();
    processController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  String selectedType = "Income";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(userId: widget.userId),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: processController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'İşlem',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "İşlem boş bırakılamaz!" : null,
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: dateController,
                  keyboardType: TextInputType.datetime,
                  decoration: const InputDecoration(
                    labelText: 'Tarih (yyyy-mm-dd)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Tarih boş bırakılamaz!" : null,
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: moneyController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Fiyat',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Fiyat boş bırakılamaz";
                    }
                    if (double.tryParse(value) == null) {
                      return "Geçerli bir sayı girin";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: descriptionController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Açıklama',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),

                DropdownButtonFormField<String>(
                  initialValue: selectedType,
                  items: const [
                    DropdownMenuItem(value: "Income", child: Text("Gelir")),
                    DropdownMenuItem(value: "Expense", child: Text("Gider")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedType = value!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Gelir / Gider',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) return;

                      final price = double.parse(moneyController.text);

                      bool success = false;

                      if (selectedType == "Income") {
                        final income = CreateIncomeModel(
                          userId: widget.userId,
                          appointmentId: 1,
                          paymentId: 1,
                          createdAt: DateTime.now().toIso8601String(),
                          price: price,
                          description: descriptionController.text,
                          incomeDate: dateController.text,
                        );

                        success = await CreateIncomeService.createIncome(
                          income,
                        );
                      } else {
                        final expense = CreateExpenseModel(
                          userId: widget.userId,
                          paymentId: 1, // default / placeholder
                          title: processController.text,
                          createdAt: DateTime.now().toIso8601String(),
                          price: price,
                          description: descriptionController.text,
                          expenseDate: dateController.text,
                        );

                        success = await CreateExpenseService.createExpense(
                          expense,
                        );
                      }

                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Başarıyla kaydedildi!"),
                          ),
                        );
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Bir hata oluştu!")),
                        );
                      }
                    },
                    child: const Text("Kaydet"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
