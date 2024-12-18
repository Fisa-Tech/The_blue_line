import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://blue-line-preprod.fisadle.fr';

  // Méthode GET
  Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    final url = Uri.parse('$_baseUrl/$endpoint');
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Retourne les données JSON
    } else {
      throw Exception('Erreur ${response.statusCode}: ${response.body}');
    }
  }

  // Méthode POST
  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('$_baseUrl/$endpoint');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Erreur ${response.statusCode}: ${response.body}');
    }
  }

  // Méthode DELETE
  Future<dynamic> delete(String endpoint) async {
    final url = Uri.parse('$_baseUrl/$endpoint');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erreur ${response.statusCode}: ${response.body}');
    }
  }

  // Méthode PUT
  Future<dynamic> put(String endpoint, Map<String, dynamic> data,
    {Map<String, String>? headers}) async {
  final url = Uri.parse('$_baseUrl/$endpoint');
  
  // Ajouter ou fusionner les headers
  final updatedHeaders = {
    'Content-Type': 'application/json', // Obligatoire pour JSON
    ...?headers, // Fusionne les headers existants si fournis
  };

  print('PUT URL: $url');
  print('PUT Data: $data');
  print('PUT Headers: $updatedHeaders');

  final response = await http.put(
    url,
    body: jsonEncode(data), // S'assurer que les données sont encodées en JSON
    headers: updatedHeaders,
  );

  print('PUT Response Code: ${response.statusCode}');
  print('PUT Response Body: ${response.body}');

  if (response.statusCode == 200 || response.statusCode == 204) {
    return response.body.isNotEmpty ? jsonDecode(response.body) : null;
  } else {
    throw Exception('Erreur ${response.statusCode}: ${response.body}');
  }
}

}
