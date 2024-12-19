import 'package:flutter/material.dart';
import 'package:myapp/Models/user_dto.dart';

class UserState extends ChangeNotifier {
  UserDto? _currentUser; // Utilisateur actuel
  bool _isAuthenticated = false; // État d'authentification
  String? _token; // JWT Token

  // Getter pour l'utilisateur
  UserDto? get currentUser => _currentUser;

  // Getter pour l'état d'authentification
  bool get isAuthenticated => _isAuthenticated;

  // Getter pour le token
  String? get token => _token;

  // Méthode pour se connecter
  Future<void> login(String email, String password) async {
    try {
      // Appel API pour se connecter
      final response = await /* Appel HTTP pour POST /api/users/login */;
      final token = response['token'];
      final userResponse = await /* Appel HTTP pour GET /api/users/me avec le token */;
      _token = token;
      _currentUser = UserDto.fromJson(userResponse);
      _isAuthenticated = true;

      notifyListeners(); // Notification des changements
    } catch (error) {
      throw Exception("Erreur lors de la connexion : $error");
    }
  }

  // Méthode pour mettre à jour les informations de l'utilisateur
  Future<void> updateUser(UserDto updatedUser) async {
    try {
      final response = await /* Appel HTTP PUT /api/users/me avec updatedUser.toJson() */;
      _currentUser = UserDto.fromJson(response);
      notifyListeners(); // Notification des changements
    } catch (error) {
      throw Exception("Erreur lors de la mise à jour de l'utilisateur : $error");
    }
  }

  // Méthode pour changer le mot de passe
  Future<void> updatePassword(String oldPassword, String newPassword) async {
    try {
      await /* Appel HTTP PATCH /api/users/password avec les paramètres */;
    } catch (error) {
      throw Exception("Erreur lors du changement de mot de passe : $error");
    }
  }

  // Méthode pour se déconnecter
  void logout() {
    _currentUser = null;
    _isAuthenticated = false;
    _token = null;
    notifyListeners(); // Notification des changements
  }

  // Méthode pour enregistrer un utilisateur
  Future<void> register(UserDto user, String password) async {
    try {
      final response = await /* Appel HTTP POST /api/users/register avec les données */;
      _currentUser = UserDto.fromJson(response);
      _isAuthenticated = true;
      notifyListeners(); // Notification des changements
    } catch (error) {
      throw Exception("Erreur lors de l'enregistrement : $error");
    }
  }
}
