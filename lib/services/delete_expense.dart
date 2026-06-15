import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek/url.dart';

// Gider silmek için WebApi ile baglantı kurulan servis
class DeleteExpenseService {
  static Future<bool> deleteExpense(int expenseId) async {
    try {
      final response = await http.post(
        Uri.parse("${ApiConfig.baseUrl}/DeleteExpense/DeleteExpense"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"expenseId": expenseId}),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("Gider silinemedi: ${response.body}");
      }
    } catch (e) {
      rethrow;
    }
  }
}
