import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/getUserModel.dart';
Future<List<User>> fetchUsers(int page) async {

  final url = Uri.parse('https://reqres.in/api/users?page=$page');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final List<dynamic> usersJson = data['data'];
    print("all user data ${response.body}");
    return usersJson.map((json) => User.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load users');
  }
}


