import 'dart:convert';
import 'package:http/http.dart' as http;
import 'defi_dto.dart';

class DefiService {
  static const String baseUrl = 'https://blue-line-preprod.fisadle.fr';

// Récupérer les défis par état
  static Future<List<Defi>> fetchDefisByEtat(String etat) async {
    final response = await http.get(Uri.parse('$baseUrl/$etat'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => Defi.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load defis');
    }
  }

  // Récupérer les détails d'un défi
  static Future<Defi> fetchDefiDetails(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      return Defi.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load defi details');
    }
  }

  // Récupérer les défis pour un événement spécifique
  static Future<List<Defi>> fetchDefisByEvent(int eventId) async {
    final response = await http.get(Uri.parse('$baseUrl/event/$eventId'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => Defi.fromJson(item)).toList();
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
  static Future<Defi> createDefi(Defi defi) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(defi.toJson()),
    );

    if (response.statusCode == 201) {
      return Defi.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create defi');
    }
  }

  // Mettre à jour un défi existant
  static Future<Defi> updateDefi(Defi defi) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${defi.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(defi.toJson()),
    );

    if (response.statusCode == 200) {
      return Defi.fromJson(json.decode(response.body));
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