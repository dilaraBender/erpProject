import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek/models/create_expense_model.dart';
import 'package:ornek/url.dart';

// Gider oluşturmak için WebApi ile baglantı kurulan servis
class CreateExpenseService {
  static Future<bool> createExpense(CreateExpenseModel expense) async {
    try {
      final response = await http.post(
        Uri.parse("${ApiConfig.baseUrl}/CreateExpense/CreateExpense"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(expense.toJson()),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Gider oluşturulamadı: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
