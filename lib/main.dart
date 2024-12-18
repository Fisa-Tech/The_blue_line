import 'package:flutter/material.dart';
import 'package:myapp/Theme/theme_provider.dart';
import 'package:myapp/Pages/profile_steup_page.dart';
import '/creer_compte.dart';
import '/LoginPage.dart';
import 'package:myapp/Pages/welcome_page.dart';
import '../Pages/register_page.dart';
import '../Pages/signin_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BlueLine',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WelcomePage(), // Page d'accueil
      routes: {
        '/register': (context) =>
            const RegisterPage(), // Route vers la page de création de compte
        '/login': (context) => const SigninPage(),
        '/profil': (context) => const ProfileSetupPage()
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                    context, '/login'); // Navigation vers le formulaire
                Navigator.pushNamed(
                    context, '/login'); // Navigation vers le formulaire
              },
              child: const Text('Authentification'),
            ),
            const SizedBox(height: 16), // Add some space between the buttons
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                    context, '/register'); // Navigation vers le formulaire
              },
              child: const Text('Créer un compte'),
            ),
            const SizedBox(height: 16), // Add some space between the buttons
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                    context, '/register'); // Navigation vers le formulaire
              },
              child: const Text('Créer un compte'),
            ),
            const SizedBox(height: 16), // Add some space between the buttons
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                    context, '/profil'); // Navigation vers le formulaire
              },
              child: const Text('profile'),
            ),
          ],
        ),
      ),
    );
  }
}
