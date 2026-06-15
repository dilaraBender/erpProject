import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek/models/drop_down_bayi_model.dart';
import 'package:ornek/models/drop_down_customer_model.dart';
import 'package:ornek/models/drop_down_building_model.dart';
import 'package:ornek/url.dart';

// DropDownları doldurmak için WebApi ile baglantı kurulan servis
class DropdownService {
  /// Bayi listesi çek
  static Future<List<DropDownBayiModel>> fetchBayiler() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/DropDownBayi/DropDownBayi'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => DropDownBayiModel.fromJson(e)).toList();
      } else {
        throw Exception('Bayi çekme hatası: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Müşteri listesi çek
  static Future<List<DropDownCustomerModel>> fetchCustomers() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/DropDownCustomer/DropDownCustomer'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => DropDownCustomerModel.fromJson(e)).toList();
      } else {
        throw Exception('Müşteri çekme hatası: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Bina listesi çek
  static Future<List<DropDownBuildingModel>> fetchBuildings(int userId) async {
    try {
      final response = await http.get(
        Uri.parse(
          '${ApiConfig.baseUrl}/DropDownBuilding/DropDownBuilding/$userId',
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => DropDownBuildingModel.fromJson(e)).toList();
      } else {
        throw Exception('Bina çekme hatası: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
