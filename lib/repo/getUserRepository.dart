import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/getUserModel.dart';
///function fetchUsers retrieves user data from a REST API endpoint. It takes a page number parameter, makes an HTTP GET request to 'https://reqres.in/api/users', decodes the JSON response, extracts the user data array, and maps each JSON object to a User model instance. If the request fails (non-200 status), it throws an exception. The function returns a Future containing a list of User objects.
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


