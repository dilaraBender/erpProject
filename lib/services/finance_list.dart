import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek/models/finance_list_model.dart';
import 'package:ornek/models/finance_model.dart';
import 'package:ornek/url.dart';

//Gelir-gider listelemek için WebApi ile baglantı kurulan servis
class FinanceListService {
  static Future<List<FinanceModel>> fetchFinanceList(
    FinanceListModel financeList,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("${ApiConfig.baseUrl}/FinanceList/FinanceList"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(financeList.toJson()),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => FinanceModel.fromJson(e)).toList();
      } else {
        throw Exception('Finans listesi alınamadı: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
