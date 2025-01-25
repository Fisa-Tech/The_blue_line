import 'package:flutter/material.dart';
import 'package:myapp/Models/user_dto.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserState extends ChangeNotifier {
  static const String _baseUrl = "https://blue-line-preprod.fisadle.fr/api";

  UserDto? _currentUser; // Utilisateur actuel
  String? _token; // JWT Token
  bool _rememberMe = false;

  // Getter pour l'utilisateur
  UserDto? get currentUser => _currentUser;
  bool get rememberMe => _rememberMe;

  // Getter pour l'état d'authentification
  bool get isAuthenticated => _token != null;

  // Getter pour le token
  String? get token => _token;

  /// Set the authentication token
  void setToken(String token) {
    _token = token;
    notifyListeners();
  }

  /// Clear user state
  void logout() {
    _token = null;
    _currentUser = null;
    _clearUserCredentials();
    notifyListeners();
  }

  /// Login user
  Future<bool> login(String email, String password) async {
    final url = Uri.parse("$_baseUrl/users/login");
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      _token = response.body; // Token is returned as a plain string
      await fetchAuthenticatedUser(); // Fetch authenticated user

      if (_rememberMe) {
        await _saveUserCredentials(
            password); // Enregistrer les données si "Se souvenir de moi" est activé
      }
      notifyListeners();
      return true;
    } else {
      throw Exception("Failed to login: ${response.body}");
    }
  }

  Future<bool> tryLoginFromSharedPreference() async {
    String pass = await loadSavedCredentials();

    if (_currentUser == null) return false;

    return await login(_currentUser!.email!, pass);
  }

  /// Register user
  Future<bool> register(String email, String password) async {
    final url = Uri.parse("$_baseUrl/users/register");
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception("Failed to register user: ${response.body}");
    }
  }

  /// Get authenticated user
  Future<UserDto?> fetchAuthenticatedUser() async {
    if (_token == null) {
      if (!await tryLoginFromSharedPreference()) return null;
    }

    final url = Uri.parse("$_baseUrl/users/me");
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      },
    );

    if (response.statusCode == 200) {
      _currentUser = UserDto.fromJson(json.decode(response.body));
      notifyListeners();
      return _currentUser;
    } else if (response.statusCode == 401) {
      logout();
      throw Exception("Unauthorized: ${response.body}");
    } else {
      throw Exception("Failed to fetch user: ${response.body}");
    }
  }

  /// Update authenticated user
  Future<UserDto?> updateUser(UserDto updatedUser) async {
    if (_token == null) return null;

    final url = Uri.parse("$_baseUrl/users/me");
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      },
      body: json.encode(updatedUser.toJson()),
    );

    if (response.statusCode == 200) {
      _currentUser = UserDto.fromJson(json.decode(response.body));
      notifyListeners();
      return _currentUser;
    } else {
      throw Exception("Failed to update user: ${response.body}");
    }
  }

  /// Delete authenticated user
  Future<void> deleteUser() async {
    if (_token == null) return;

    final url = Uri.parse("$_baseUrl/users/me");
    final response = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer $_token',
      },
    );

    if (response.statusCode == 204) {
      logout();
    } else {
      throw Exception("Failed to delete user: ${response.body}");
    }
  }

  /// Update password
  Future<void> updatePassword(String oldPassword, String newPassword) async {
    if (_token == null) return;

    final url = Uri.parse("$_baseUrl/users/password");
    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      },
      body: json.encode({
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to update password: ${response.body}");
    }
  }

  // Charger les données utilisateur enregistrées
  Future<String> loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    _currentUser = prefs.containsKey('profil')
        ? UserDto.fromJson(jsonDecode(prefs.getString('profil')!))
        : null;

    return prefs.getString('password') ?? '';
  }

  // Sauvegarder les données utilisateur
  Future<void> _saveUserCredentials(String pass) async {
    final prefs = await SharedPreferences.getInstance();
    if (currentUser != null) {
      String user = jsonEncode(currentUser!.toJson());
      prefs.setString('profil', user);
      prefs.setString('password', pass);
    }
  }

  // Supprimer les données utilisateur
  Future<void> _clearUserCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('profil');
    await prefs.remove('password');
  }

  // Setter pour "Se souvenir de moi"
  void setRememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }
}
