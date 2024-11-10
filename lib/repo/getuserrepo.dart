import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/getusermodel.dart';
import '../model/supportmodel.dart';

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
Future<UserDetails> fetchUserDetails(int userId) async {
  final response = await http.get(Uri.parse('https://reqres.in/api/users/$userId'));

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    print("user details ${response.body}");
    return UserDetails.fromJson(jsonData);
  } else {
    throw Exception('Failed to load user details');
  }
}

