import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:strava_client/strava_client.dart';

import '../secret.dart';

class StravaService {
  static final StravaService _instance = StravaService._internal();

  factory StravaService() => _instance;

  late StravaClient _client;

  TokenResponse? _tokenInMemory;

  StravaService._internal() {
    _client = StravaClient(
        secret: secret, clientId: clientId, applicationName: 'BlueLine');
  }

  Future<bool> hasSavedToken() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('strava_auth_token');
    if (jsonString == null) return false;

    try {
      final map = jsonDecode(jsonString);
      final token = TokenResponse(
        accessToken: map['accessToken'] as String,
        refreshToken: map['refreshToken'] as String,
        tokenType: map['tokenType'] as String,
        expiresAt: map['expiresAt'] as int,
        expiresIn: map['expiresIn'] as int,
      );

      _tokenInMemory = token;

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> connectToStrava() async {
    try {
      final token = await _client.authentication.authenticate(
        scopes: [AuthenticationScope.activity_read_all],
        redirectUrl: 'stravaflutter://redirect',
        callbackUrlScheme: 'stravaflutter',
      );

      if (token.accessToken.isNotEmpty) {
        await _saveToken(token);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _saveToken(TokenResponse token) async {
    final prefs = await SharedPreferences.getInstance();

    final map = {
      'accessToken': token.accessToken,
      'refreshToken': token.refreshToken,
      'tokenType': token.tokenType,
      'expiresAt': token.expiresAt,
      'expiresIn': token.expiresIn,
    };
    final jsonString = jsonEncode(map);

    await prefs.setString('strava_auth_token', jsonString);
  }

  Future<void> disconnectFromStrava() async {
    try {
      await _client.authentication.deAuthorize();
    } catch (e) {
      //
    }
  }

  Future<List<SummaryActivity>> getActivities({
    int daysBefore = 30,
    int page = 1,
    int perPage = 10,
  }) async {
    if (_tokenInMemory == null) {
      final success = await hasSavedToken();
      if (!success || _tokenInMemory == null) {
        throw Exception("Pas de token Strava disponible");
      }
    }
    
    return _client.activities.listLoggedInAthleteActivities(
      DateTime.now(),
      DateTime.now().subtract(Duration(days: daysBefore)),
      page,
      perPage,
    );
  }
}
