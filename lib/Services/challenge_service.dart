import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/user_state.dart';
import '../Models/challenge_dto.dart';
import 'package:provider/provider.dart';

class ChallengeService {
  static const String baseUrl =
      'https://blue-line-preprod.fisadle.fr/api/challenges';
  static const String completionsUrl =
      'https://blue-line-preprod.fisadle.fr/api/challenge-completions';

  // Récupérer les défis par état
  static Future<List<Challenge>> fetchDefisByEtat(
      BuildContext context, String etat) async {
    final userState = Provider.of<UserState>(context, listen: false);
    final token = userState.token;
    if (token == null) {
      throw Exception('Token non disponible. Connectez-vous pour continuer.');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/$etat'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => Challenge.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load defis');
    }
  }

  // Récupérer les détails d'un défi
  static Future<Challenge> fetchDefiDetails(
      BuildContext context, int id) async {
    final userState = Provider.of<UserState>(context, listen: false);
    final token = userState.token;
    if (token == null) {
      throw Exception('Token non disponible. Connectez-vous pour continuer.');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return Challenge.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load defi details');
    }
  }

  // Récupérer les participations d'un défi
  static Future<List<dynamic>> fetchDefiParticipants(
      BuildContext context, int challengeId) async {
    final userState = Provider.of<UserState>(context, listen: false);
    final token = userState.token;
    if (token == null) {
      throw Exception('Token non disponible. Connectez-vous pour continuer.');
    }

    final response = await http.get(
      Uri.parse('$completionsUrl/challenge/$challengeId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load participants');
    }
  }

  // Récupérer les défis pour un événement spécifique
  static Future<List<Challenge>> fetchDefisByEvent(
      BuildContext context, int eventId) async {
    final userState = Provider.of<UserState>(context, listen: false);
    final token = userState.token;
    if (token == null) {
      throw Exception('Token non disponible. Connectez-vous pour continuer.');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/event/$eventId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => Challenge.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load defis for event');
    }
  }

  // Créer un nouveau défi
  static Future<Challenge> createDefi(
      BuildContext context, Challenge defi) async {
    final userState = Provider.of<UserState>(context, listen: false);
    final token = userState.token;
    if (token == null) {
      throw Exception('Token non disponible. Connectez-vous pour continuer.');
    }

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Authorization': 'Bearer $token',
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
  static Future<Challenge> updateDefi(
      BuildContext context, Challenge defi) async {
    final userState = Provider.of<UserState>(context, listen: false);
    final token = userState.token;
    if (token == null) {
      throw Exception('Token non disponible. Connectez-vous pour continuer.');
    }

    final response = await http.put(
      Uri.parse('$baseUrl/${defi.id}'),
      headers: {
        'Authorization': 'Bearer $token',
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
  static Future<void> deleteDefi(BuildContext context, int id) async {
    final userState = Provider.of<UserState>(context, listen: false);
    final token = userState.token;
    if (token == null) {
      throw Exception('Token non disponible. Connectez-vous pour continuer.');
    }

    final response = await http.delete(
      Uri.parse('$baseUrl/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete defi');
    }
  }
}
