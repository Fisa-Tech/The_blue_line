import 'dart:convert';
import 'package:http/http.dart' as http;
import 'challenge_completion_dto.dart';

class ChallengeCompletionService {
  static const String baseUrl = "https://blue-line-preprod.fisadle.fr";

  // GET: Get all completions for a challenge
  Future<List<ChallengeCompletion>> getCompletionsForChallenge(int challengeId) async {
    final url = Uri.parse('$baseUrl/challenge/$challengeId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => ChallengeCompletion.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load challenge completions');
    }
  }

  // POST: Add a new completion for a given challenge
  Future<ChallengeCompletion> addCompletion(ChallengeCompletion completion) async {
    final url = Uri.parse('$baseUrl/challenge/${completion.challengeId}');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(completion.toJson()),
    );

    if (response.statusCode == 201) {
      return ChallengeCompletion.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add challenge completion');
    }
  }

  // PUT: Update an existing completion
  Future<ChallengeCompletion> updateCompletion(ChallengeCompletion completion) async {
    final url = Uri.parse('$baseUrl/${completion.id}');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(completion.toJson()),
    );

    if (response.statusCode == 200) {
      return ChallengeCompletion.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update challenge completion');
    }
  }

  // DELETE: Delete a completion
  Future<void> deleteCompletion(int completionId) async {
    final url = Uri.parse('$baseUrl/$completionId');
    final response = await http.delete(url);

    if (response.statusCode != 204) {
      throw Exception('Failed to delete challenge completion');
    }
  }
}
