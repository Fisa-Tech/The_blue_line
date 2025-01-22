import 'dart:convert';
import 'package:http/http.dart' as http;
import 'challenge_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token'); // La clé doit correspondre à celle utilisée pour sauvegarder le token
  }
}

class ChallengeService {
  static const String baseUrl = 'https://blue-line-preprod.fisadle.fr/api/challenges';

  // Récupérer les défis par état
  static Future<List<Challenge>> fetchDefisByEtat(String etat) async {
    final token = await AuthHelper.getToken();

    if (token == null) {
      throw Exception('Token non disponible. Connectez-vous pour continuer.');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/$etat'),
      headers: {
        'Authorization': 'Bearer $token', // Ajouter le token ici
        'Content-Type': 'application/json',
      },
    );

    print('Request URL: ${response.request?.url}');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => Challenge.fromJson(item)).toList();
    } else {
      print('Error: Unexpected status code ${response.statusCode}');
      throw Exception('Failed to load defis');
    }
  }

  // Récupérer les détails d'un défi
  static Future<Challenge> fetchDefiDetails(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      return Challenge.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load defi details');
    }
  }

  // Récupérer les défis pour un événement spécifique
  static Future<List<Challenge>> fetchDefisByEvent(int eventId) async {
    final response = await http.get(Uri.parse('$baseUrl/event/$eventId'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => Challenge.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load defis for event');
    }
  }

  // Récupérer les participants d'un défi
  static Future<List<dynamic>> fetchDefiParticipants(int challengeId) async {
    final response = await http.get(Uri.parse('$baseUrl/$challengeId/participants'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load defi participants');
    }
  }

  // Créer un nouveau défi
  static Future<Challenge> createDefi(Challenge defi) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(defi.toJson()),
    );

    if (response.statusCode == 201) {
      return Challenge.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create defi');
    }
  }

  // Mettre à jour un défi existant
  static Future<Challenge> updateDefi(Challenge defi) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${defi.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(defi.toJson()),
    );

    if (response.statusCode == 200) {
      return Challenge.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update defi');
    }
  }

  // Supprimer un défi
  static Future<void> deleteDefi(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete defi');
    }
  }
}