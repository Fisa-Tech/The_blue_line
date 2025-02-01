import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static const String baseUrl = 'https://blue-line-preprod.fisadle.fr/api/users'; // Remplace par ton URL réelle

  /// 🔐 Stocker le token d'authentification
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  /// 🔑 Récupérer le token d'authentification
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  /// 🏷 Supprimer le token (déconnexion)
  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  /// 🔍 Vérifier si l'utilisateur est authentifié
  static Future<bool> isAuthenticated() async {
    final token = await getToken();
    if (token == null) return false;

    final response = await http.get(
      Uri.parse('$baseUrl/auth/verify'),
      headers: {'Authorization': 'Bearer $token'},
    );

    return response.statusCode == 200;
  }

  /// 📝 Inscription d'un utilisateur
  static Future<bool> register(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Erreur d\'inscription: ${response.body}');
    }
  }

  /// 🔐 Connexion d'un utilisateur
  static Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await saveToken(data['token']);
      return true;
    } else {
      throw Exception('Erreur de connexion: ${response.body}');
    }
  }

  /// 🔄 Mettre à jour le profil de l'utilisateur authentifié
  static Future<void> updateUser(Map<String, dynamic> updatedData) async {
    final token = await getToken();
    if (token == null) throw Exception('Utilisateur non authentifié');

    final response = await http.put(
      Uri.parse('$baseUrl/me'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(updatedData),
    );

    if (response.statusCode != 200) {
      throw Exception('Erreur mise à jour: ${response.body}');
    }
  }

  /// 📥 Récupérer l'utilisateur authentifié
  static Future<Map<String, dynamic>> getUser() async {
    final token = await getToken();
    if (token == null) throw Exception('Utilisateur non authentifié');

    final response = await http.get(
      Uri.parse('$baseUrl/me'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erreur récupération utilisateur: ${response.body}');
    }
  }

  /// 🔄 Modifier le mot de passe de l'utilisateur
  static Future<void> updatePassword(String newPassword) async {
    final token = await getToken();
    if (token == null) throw Exception('Utilisateur non authentifié');

    final response = await http.patch(
      Uri.parse('$baseUrl/password'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'password': newPassword}),
    );

    if (response.statusCode != 200) {
      throw Exception('Erreur modification mot de passe: ${response.body}');
    }
  }

  /// 🚫 Supprimer le compte utilisateur
  static Future<void> deleteUser() async {
    final token = await getToken();
    if (token == null) throw Exception('Utilisateur non authentifié');

    final response = await http.delete(
      Uri.parse('$baseUrl/me'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 200) {
      throw Exception('Erreur suppression utilisateur: ${response.body}');
    }

    await clearToken(); // Supprime le token après suppression
  }

  /// 👥 Récupérer tous les utilisateurs (Admin)
  static Future<List<dynamic>> getAllUsers() async {
    final token = await getToken();
    if (token == null) throw Exception('Utilisateur non authentifié');

    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erreur récupération utilisateurs: ${response.body}');
    }
  }

  /// 🔍 Récupérer un utilisateur par ID
  static Future<Map<String, dynamic>> getUserById(int id) async {
    final token = await getToken();
    if (token == null) throw Exception('Utilisateur non authentifié');

    final response = await http.get(
      Uri.parse('$baseUrl/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erreur récupération utilisateur: ${response.body}');
    }
  }
}
