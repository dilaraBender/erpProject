import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek/url.dart';

// Gelir kaydını silmek için WebApi ile baglantı kurulan servis
class DeleteIncomeService {
  static Future<bool> deleteIncome(int incomeId) async {
    try {
      final response = await http.post(
        Uri.parse("${ApiConfig.baseUrl}/DeleteIncome/DeleteIncome"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"incomeId": incomeId}),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("Gelir silinemedi: ${response.body}");
      }
    } catch (e) {
      rethrow;
    }
  }
}
