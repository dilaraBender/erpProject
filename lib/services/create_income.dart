import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek/models/create_income_model.dart';
import 'package:ornek/url.dart';

// Gelir oluşturmak için WebAi ile baglantı kurulan servis
class CreateIncomeService {
  static Future<bool> createIncome(CreateIncomeModel income) async {
    try {
      final response = await http.post(
        Uri.parse("${ApiConfig.baseUrl}/CreateIncome/CreateIncome"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(income.toJson()),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Gelir oluşturulamadı: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
