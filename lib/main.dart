import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/Pages/edit_password_page.dart';
import 'package:myapp/Pages/home_page.dart';
import 'package:myapp/Pages/notification_settings.dart';
import 'package:myapp/Pages/resetpassword_page.dart';
import 'package:myapp/Pages/profile_setup_page.dart';
import 'package:myapp/Pages/settings_page.dart';
import 'package:myapp/Pages/welcome_page.dart';
import '../Pages/register_page.dart';
import '../Pages/signin_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
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
        '/home': (context) => const HomePage(),
        '/register': (context) => const RegisterPage(), // Route vers la page de création de compte
        '/login': (context) => const SigninPage(),
        '/profil': (context) => const ProfileSetupPage(),
        '/forgotpassword': (context) => ResetpasswordPage(),
        '/settings': (context) => const SettingsPage(),
        '/settings/profile_edit': (context) => const ProfileSetupPage(),
        '/settings/edit_password': (context) => const EditPasswordPage(),
        '/settings/notification_settings': (context) => const NotificationSettingsPage(),
      },
    );
  }
}
