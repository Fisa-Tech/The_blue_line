import 'dart:convert';
import 'package:http/http.dart' as http;
import 'add_friends_dto.dart';

class AddFriendsService {
  final String baseUrl; // Base URL de l'API

  AddFriendsService({required this.baseUrl});

  // Créer une demande de relation
  Future<void> createRelationship(String userReceiverId) async {
    final url = Uri.parse('$baseUrl/api/relationships/$userReceiverId');
    final response = await http.post(url);

    if (response.statusCode == 201) {
      print("Relationship request created successfully.");
    } else {
      throw Exception("Failed to create relationship: ${response.body}");
    }
  }

  // Mettre à jour le statut d'une relation
  Future<void> updateRelationshipStatus(int relationshipId, String status) async {
    final url = Uri.parse('$baseUrl/api/relationships/$relationshipId/status');
    final body = jsonEncode({'status': status});
    final headers = {'Content-Type': 'application/json'};

    final response = await http.patch(url, body: body, headers: headers);

    if (response.statusCode == 200) {
      print("Relationship status updated successfully.");
    } else {
      throw Exception("Failed to update relationship status: ${response.body}");
    }
  }

  // Obtenir les demandes de relations en attente
  Future<List<AddFriendsDto>> getPendingRelationships() async {
    final url = Uri.parse('$baseUrl/api/relationships/pending');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => AddFriendsDto.fromJson(json)).toList();
    } else {
      throw Exception("Failed to fetch pending relationships: ${response.body}");
    }
  }

  // Obtenir la liste des amis
  Future<List<AddFriendsDto>> getFriends() async {
    final url = Uri.parse('$baseUrl/api/relationships/friends');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => AddFriendsDto.fromJson(json)).toList();
    } else {
      throw Exception("Failed to fetch friends: ${response.body}");
    }
  }

  // Supprimer une relation
  Future<void> deleteRelationship(int friendId) async {
    final url = Uri.parse('$baseUrl/api/relationships/$friendId');
    final response = await http.delete(url);

    if (response.statusCode == 204) {
      print("Relationship deleted successfully.");
    } else {
      throw Exception("Failed to delete relationship: ${response.body}");
    }
  }
}
