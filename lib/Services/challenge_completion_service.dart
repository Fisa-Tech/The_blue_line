import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/challenge_completion_dto.dart';

class AuthHelper {
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token'); // La clé doit correspondre à celle utilisée pour sauvegarder le token
  }
}

class ChallengeCompletionService {
  static const String baseUrl = "https://blue-line-preprod.fisadle.fr";

   // Mettre à jour une participation existante
  static Future<void> updateCompletion(int completionId, Map<String, dynamic> data) async {
    final token = await AuthHelper.getToken();
    if (token == null) {
      throw Exception('Token non disponible. Connectez-vous pour continuer.');
    }

    final response = await http.put(
      Uri.parse('$baseUrl/$completionId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update completion');
    }
  }

  // Supprimer une participation
  static Future<void> deleteCompletion(int completionId) async {
    final token = await AuthHelper.getToken();
    if (token == null) {
      throw Exception('Token non disponible. Connectez-vous pour continuer.');
    }

    final response = await http.delete(
      Uri.parse('$baseUrl/$completionId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete completion');
    }
  }

  // Récupérer toutes les participations pour un défi donné
  static Future<List<dynamic>> getCompletionsForChallenge(int challengeId) async {
    final token = await AuthHelper.getToken();
    if (token == null) {
      throw Exception('Token non disponible. Connectez-vous pour continuer.');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/challenge/$challengeId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to get completions for challenge');
    }
  }

  // Ajouter une nouvelle participation pour un défi donné
  static Future<void> addCompletionForChallenge(int challengeId, Map<String, dynamic> data) async {
    final token = await AuthHelper.getToken();
    if (token == null) {
      throw Exception('Token non disponible. Connectez-vous pour continuer.');
    }

    final response = await http.post(
      Uri.parse('$baseUrl/challenge/$challengeId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add completion for challenge');
    }
  }

}