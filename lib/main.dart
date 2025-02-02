import 'package:avatar_maker/avatar_maker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:myapp/Pages/avatar_customing_page.dart';
import 'package:myapp/Pages/edit_password_page.dart';
import 'package:myapp/Pages/actualites_page.dart';
import 'package:myapp/Pages/blue_line_page.dart';
import 'package:myapp/Pages/defi_details_page.dart';
import 'package:myapp/Pages/defis_page.dart';
import 'package:myapp/Pages/home_page.dart';
import 'package:myapp/Pages/notification_settings.dart';
import 'package:myapp/Pages/profile_edit.dart';
import 'package:myapp/Pages/notifications_page.dart';
import 'package:myapp/Pages/resetpassword_page.dart';
import 'package:myapp/Pages/profile_setup_page.dart';
import 'package:myapp/Pages/settings_page.dart';
import 'package:myapp/Pages/welcome_page.dart';
import '../Pages/register_page.dart';
import '../Pages/signin_page.dart';
import '../user_state.dart';
import 'package:provider/provider.dart';

void main() {
  Get.lazyPut(() => AvatarMakerController(customizedPropertyCategories: []));
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
    return ChangeNotifierProvider(
        create: (_) => UserState(), // Fournir l'état utilisateur
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'BlueLine',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const AuthRedirectPage(), // Page de redirection initiale
          onGenerateRoute: (settings) {
            if (settings.name == '/home') {
              return PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const HomePage());
            }
            if (settings.name == '/register') {
              return PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const RegisterPage());
            }
            if (settings.name == '/login') {
              return PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const SigninPage());
            }
            if (settings.name == '/profil') {
              return PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const ProfileSetupPage());
            }
            if (settings.name == '/forgotpassword') {
              return PageRouteBuilder(
                  pageBuilder: (_, __, ___) => ResetpasswordPage());
            }
            if (settings.name == '/welcome') {
              return PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const WelcomePage());
            }
            if (settings.name == '/notifications') {
              return PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const NotificationsPage());
            }
            if (settings.name == '/news') {
              return PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const ActualitesPage());
            }
            if (settings.name == '/blueline') {
              return PageRouteBuilder(
                  pageBuilder: (_, __, ___) => BlueLinePage());
            }
            if (settings.name == '/settings') {
              return PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const SettingsPage());
            }
            if (settings.name == '/settings/profile_edit') {
              return PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const ProfileEditPage());
            }
            if (settings.name == '/settings/edit_password') {
              return PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const EditPasswordPage());
            }
            if (settings.name == '/settings/notification_settings') {
              return PageRouteBuilder(
                  pageBuilder: (_, __, ___) =>
                      const NotificationSettingsPage());
            }
            if (settings.name == '/defi_details') {
              final challengeId = settings.arguments as int;
              return MaterialPageRoute(
                builder: (context) =>
                    DetailsDefisPage(challengeId: challengeId),
              );
            }
            if (settings.name == '/defis') {
              return MaterialPageRoute(builder: (context) => const DefisPage());
            }
            if (settings.name == '/avatar') {
              return MaterialPageRoute(builder: (context) => AvatarCustomingPage());
            }

            // Retourner null si aucune route correspondante n'est trouvée
            return null;
          },
        ));
  }
}

/// Page de redirection en fonction de l'état de l'utilisateur
class AuthRedirectPage extends StatelessWidget {
  const AuthRedirectPage({super.key});

  Future<String> _determineRoute(BuildContext context) async {
    final userState = Provider.of<UserState>(context, listen: false);

    try {
      // Tenter de récupérer l'utilisateur authentifié
      final user = await userState.fetchAuthenticatedUser();

      // Si l'utilisateur est connecté mais le profil est incomplet
      if (user != null && (!user.profilCompleted())) {
        return '/profil'; // Rediriger vers la page de configuration de profil
      }

      // Si l'utilisateur est connecté et le profil est complet
      if (user != null) {
        return '/home'; // Rediriger vers la page d'accueil
      }

      // Si aucun utilisateur n'est connecté
      return '/welcome'; // Rediriger vers la page de connexion
    } catch (e) {
      // En cas d'erreur, rediriger vers la page de bienvenue
      return '/welcome';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _determineRoute(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Afficher un écran de chargement pendant la vérification
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasData) {
          // Redirection vers la route déterminée
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed(snapshot.data!);
          });
        }

        // Retourner un widget vide car la redirection est en cours
        return const SizedBox.shrink();
      },
    );
  }
}
