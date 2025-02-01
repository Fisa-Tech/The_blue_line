import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/Services/toast_service.dart';
import 'package:myapp/user_state.dart';
import '../Models/add_friends_dto.dart';
import 'package:provider/provider.dart';

class FriendsService {
  static const String baseUrl = 'https://blue-line-preprod.fisadle.fr';

  // Créer une demande de relation
  static Future<void> createRelationship(
      BuildContext context, String userReceiverId) async {
    final userState = Provider.of<UserState>(context, listen: false);
    final token = userState.token;

    final url = Uri.parse('$baseUrl/api/relationships/$userReceiverId');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 201) {
      ToastService.showSuccess("Relationship request created successfully.");
    } else {
      throw Exception("Failed to create relationship: ${response.body}");
    }
  }

  // Mettre à jour le statut d'une relation
  static Future<void> updateRelationshipStatus(
      BuildContext context, int relationshipId, String status) async {
    final userState = Provider.of<UserState>(context, listen: false);
    final token = userState.token;

    final url = Uri.parse('$baseUrl/api/relationships/$relationshipId/status');
    final body = jsonEncode({'status': status});
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.patch(url, body: body, headers: headers);

    if (response.statusCode == 200) {
      ToastService.showError("Relationship status updated successfully.");
    } else {
      throw Exception("Failed to update relationship status: ${response.body}");
    }
  }

  // Obtenir les demandes de relations en attente
  static Future<List<AddFriendsDto>> getPendingRelationships(
      BuildContext context) async {
    final userState = Provider.of<UserState>(context, listen: false);
    final token = userState.token;

    final url = Uri.parse('$baseUrl/api/relationships/pending');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => AddFriendsDto.fromJson(json)).toList();
    } else {
      throw Exception(
          "Failed to fetch pending relationships: ${response.body}");
    }
  }

  // Obtenir la liste des amis
  static Future<List<AddFriendsDto>> getFriends(BuildContext context) async {
    final userState = Provider.of<UserState>(context, listen: false);
    final token = userState.token;

    final url = Uri.parse('$baseUrl/api/relationships/friends');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => AddFriendsDto.fromJson(json)).toList();
    } else {
      throw Exception("Failed to fetch friends: ${response.body}");
    }
  }

  // Supprimer une relation
  static Future<void> deleteRelationship(
      BuildContext context, int friendId) async {
    final userState = Provider.of<UserState>(context, listen: false);
    final token = userState.token;

    final url = Uri.parse('$baseUrl/api/relationships/$friendId');
    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 204) {
      ToastService.showSuccess("Relationship deleted successfully.");
    } else {
      throw Exception("Failed to delete relationship: ${response.body}");
    }
  }
}
