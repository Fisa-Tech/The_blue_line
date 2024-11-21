import 'package:flutter/material.dart';
import 'package:myapp/ForgotPasswordPage.dart';
import '/creer_compte.dart';
import '/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ForgotPasswordPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mon App Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(), // Page d'accueil
      routes: {
        '/register': (context) => RegistrationPage(), // Route vers la page de création de compte
        '/login': (context) => LoginPage(), // Route vers la page de connexion
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
     @override
  void initState() {
    super.initState();
    _checkSession(); // Vérifie la session au démarrage de la page
  }

  // Méthode pour vérifier si un token est présent dans SharedPreferences
  Future<void> _checkSession() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token == null || token.isEmpty) {
      // Si aucun token, rediriger vers la page de connexion
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()), // Redirection vers la page de connexion
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login'); // Navigation vers le formulaire
              },
              child: Text('Authentification'),
            ),
            SizedBox(height: 16), // Add some space between the buttons
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register'); // Navigation vers le formulaire
              },
              child: Text('Créer un compte'),
            ),
          ],
        ),
      ),
    );
  }
}