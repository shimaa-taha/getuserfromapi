import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/getUserModel.dart';
///) retrieves character data from the Rick and Morty API. It makes an HTTP GET request to the API endpoint, decodes the JSON response, extracts the 'results' array, and maps each JSON object to a Results model using fromJson(). If the request fails (non-200 status), it throws an exception. The function returns a Future containing a list of Results objects.
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