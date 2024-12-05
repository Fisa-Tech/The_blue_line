import 'package:flutter/material.dart';
import 'package:myapp/ForgotPasswordPage.dart';
import 'package:myapp/theme/theme_provider.dart';
import '/creer_compte.dart';
import '/LoginPage.dart';
import 'package:myapp/Pages/welcome_page.dart';


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
      theme: ThemeProvider.myTheme,
      home: const HomePage(), // Page d'accueil
      routes: {
        '/register': (context) =>
            const RegistrationPage(), // Route vers la page de création de compte
        '/login': (context) => const LoginPage(),
        '/welcome': (context) => const WelcomePage(),
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
                    context, '/welcome'); // Navigation vers le formulaire
              },
              child: const Text('welcome demo'),
            ),
          ],
        ),
      ),
    );
  }
}
