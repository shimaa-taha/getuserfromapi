import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/getUserModel.dart';

Future<List<Results>> fetchUsers() async {
  final url = Uri.parse('https://rickandmortyapi.com/api/character');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final List<dynamic> usersJson = data['results'];
    print("all user data ${response.body}");
    return usersJson.map((json) => Results.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load users');
  }
}