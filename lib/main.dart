import 'package:flutter/material.dart';
import '/creer_compte.dart';

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
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/register'); // Navigation vers le formulaire
          },
          child: Text('Créer un compte'),
        ),
      ),
    );
  }
}
