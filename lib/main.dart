import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/Pages/defi_details_page.dart';
import 'package:myapp/Pages/defis_page.dart';
import 'package:myapp/Pages/home_page.dart';
import 'package:myapp/Pages/resetpassword_page.dart';
import 'package:myapp/Pages/profile_setup_page.dart';
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
        '/defis': (context) => const DefisPage(),
        '/defis_details': (context) => const DetailsDefisPage(),
      },
    );
  }
}
