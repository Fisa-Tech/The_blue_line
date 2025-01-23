import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/Components/friendCard.dart';
import 'package:myapp/Pages/ajouter_amis_page.dart';
import 'package:myapp/Pages/communaute_page.dart';
import 'package:myapp/Pages/group_flux_page.dart';
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
      home: const CommunautePage(), // Page d'accueil
      routes: {
        '/home': (context) => const CommunautePage(),
        '/register': (context) => const RegisterPage(), // Route vers la page de création de compte
        '/login': (context) => const GroupFeedPage(groupName: '',),
        '/profil': (context) => const AddFriendsPage(),
        '/forgotpassword': (context) => ResetpasswordPage(),
      },
    );
  }
}
