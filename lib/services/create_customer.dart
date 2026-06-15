import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek/url.dart';
import '../models/customer_model.dart';

// Müşteri oluşturmak için WebApi ile bağlantı kurduğumuz servis
class CreateCustomerService {
  static Future<String?> createCustomer(CustomerModel customer) async {
    final url = Uri.parse("${ApiConfig.baseUrl}/CreateCustomer/CreateCustomer");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "mail": customer.email,
        "name": customer.name.split(" ").first,
        "lastName": customer.lastName.split(" ").length > 1
            ? customer.lastName.split(" ")[1]
            : "",
        "phone": customer.phone,
        "status": "active",
        "role": "customer",
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["password"];
    } else {
      throw Exception("Müşteri oluşturulamadı: ${response.body}");
    }
  }
}
