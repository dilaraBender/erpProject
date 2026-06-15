import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek/models/customer_model.dart';
import 'package:ornek/url.dart';

// Müşteri bilgilerini güncellemek için WebApi ile bağlantı kurduğumuz servis
class UpdateCustomerService {
  static Future<bool> updateCustomer(CustomerModel customer) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/UpdateCustomer/UpdateCustomer'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(customer.toJson()),
      );

      return response.statusCode == 200;
    } catch (e) {
      throw Exception("Customer update hatası: $e");
    }
  }
}
