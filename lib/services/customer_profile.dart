import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek/models/customer_model.dart';
import 'package:ornek/url.dart';

// Müşteri kişisel bilgilerini göstermek için WebApi ile bağlantı kurduğumuz servis
class CustomerProfileService {
  static Future<CustomerModel?> fetchCustomerProfile(int userId) async {
    try {
      final response = await http.get(
        Uri.parse(
          '${ApiConfig.baseUrl}/CustomerProfile/CustomerProfile/$userId',
        ),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return CustomerModel.fromJson(data);
      } else {
        throw Exception('Profil bilgileri alınamadı: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
