import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/user_state.dart';
import 'package:provider/provider.dart';



class ChallengeCompletionService {
  static const String baseUrl = "https://blue-line-preprod.fisadle.fr";

  // Mettre à jour une participation existante
  static Future<void> updateCompletion(BuildContext context, int completionId, Map<String, dynamic> data) async {
    final userState = Provider.of<UserState>(context, listen: false);
    final token = userState.token;

    final response = await http.put(
      Uri.parse('$baseUrl/api/challenge-completions/$completionId'),
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
  static Future<void> deleteCompletion(BuildContext context, int completionId) async {
    final userState = Provider.of<UserState>(context, listen: false);
    final token = userState.token;

    final response = await http.delete(
      Uri.parse('$baseUrl/api/challenge-completions/$completionId'),
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
  static Future<List<dynamic>> getCompletionsForChallenge(BuildContext context, int challengeId) async {
    final userState = Provider.of<UserState>(context, listen: false);
    final token = userState.token;


    final response = await http.get(
      Uri.parse('$baseUrl/api/challenge-completions/challenge/$challengeId'),
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
  static Future<void> addCompletionForChallenge(BuildContext context, int challengeId, Map<String, dynamic> data) async {
    final userState = Provider.of<UserState>(context, listen: false);
    final token = userState.token;

    final response = await http.post(
      Uri.parse('$baseUrl/api/challenge-completions/challenge/$challengeId'),
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
