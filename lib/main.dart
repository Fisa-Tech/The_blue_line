import 'package:flutter/material.dart';
import '/creer_compte.dart';
import '/LoginPage.dart';

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

class HomePage extends StatelessWidget {
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