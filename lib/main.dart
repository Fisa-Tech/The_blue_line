import 'package:flutter/material.dart';
import 'package:myapp/Pages/resetpassword_page.dart';
import 'package:myapp/theme/theme_provider.dart';
import '/creer_compte.dart';
import '/LoginPage.dart';
import 'package:myapp/Pages/welcome_page.dart';
import '../Pages/register_page.dart';
import '../Pages/signin_page.dart';
import 'notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisation du service de notifications
  await NotificationService.initialize();
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
      home: const HomePage(), // Page d'accueil
      routes: {
        '/home': (context) => const WelcomePage(),
        '/register': (context) => const RegisterPage(), // Route vers la page de création de compte
        '/login': (context) => const SigninPage(),
        '/forgotpassword': (context) => ResetpasswordPage(),
        '/test-notifications': (context) => const TestNotificationsPage(),
      },
    );
  }
}

// Page pour tester les notifications
class TestNotificationsPage extends StatelessWidget {
  const TestNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test des Notifications'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Planifier une notification pour dans 1 minute
            NotificationService.showNotification(
              id: 1,
              title: 'Notification Test',
              body: 'Ceci est un test de notification locale.',
            );
          },
          child: const Text('Planifier une notification'),
        ),
      ),
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
            const SizedBox(height: 16), // Add some space between the buttons
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                    context, '/test-notifications'); // Aller à la page de test des notifications
              },
              child: const Text('Tester les notifications'),
            ),
          ],
        ),
      ),
    );
  }
}
