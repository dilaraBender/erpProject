import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek/models/customer_filter_model.dart';
import 'package:ornek/models/customer_model.dart';
import 'package:ornek/url.dart';

// Müşterileri listelemek için WebApi ile bağlantı kurduğumuz servis
class CustomerListService {
  static Future<List<CustomerModel>> fetchCustomerList(
    CustomerFilterModel filter,
  ) async {
    final response = await http.post(
      Uri.parse("${ApiConfig.baseUrl}/CustomerList/CustomerList"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(filter.toJson()),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data.map((e) => CustomerModel.fromJson(e)).toList();
    }

    throw Exception("Müşteriler alınamadı: ${response.body}");
  }
}
