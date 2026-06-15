import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek/models/user_list_model.dart';
import 'package:ornek/models/user_model.dart';
import 'package:ornek/url.dart';

// kullanıcıları listelemek için WebApi ile baglantı kurulan servis
class UserListService {
  static Future<List<UserModel>> fetchUsers(UserListModel filters) async {
    try {
      final response = await http.post(
        Uri.parse("${ApiConfig.baseUrl}/UserList/UserList"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(filters.toJson()),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => UserModel.fromJson(e)).toList();
      } else {
        throw Exception('Kullanıcılar alınamadı: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
