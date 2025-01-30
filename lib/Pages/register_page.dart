import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/Components/button_widget.dart';
import 'package:myapp/Components/form_text_field.dart';
import 'package:myapp/Pages/signin_page.dart';
import 'package:myapp/Theme/app_colors.dart';
import 'package:myapp/user_state.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Future<void> _createAccount() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();

      // Utilisation de UserState pour gérer l'inscription
      final userState = Provider.of<UserState>(context, listen: false);

      final isSuccess = await userState.register(_email!, _password!);

      if (isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Compte créé avec succès !')),
        );
        Navigator.pushNamed(context, '/profil');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Erreur lors de la création du compte.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img/welcome.jpg"),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Stack(
          children: [
            // Overlay pour assombrir l'image
            Container(
              width: double.infinity,
              height: double.infinity,
              color: AppColors.dark.withOpacity(0.9),
            ),
            // Contenu de la page avec défilement
            SizedBox(
                height: height,
                child: SingleChildScrollView(
                    child: SizedBox(
                  height: height,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.05, // 5% de marge horizontale
                      vertical: height * 0.05, // 5% de marge verticale
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Logo Container
                        SizedBox(height: height * 0.05), // Espacement dynamique
                        SvgPicture.asset(
                          "assets/img/logo.svg",
                          height: height * 0.12, // Taille relative à la hauteur
                        ),
                        SizedBox(height: height * 0.05), // Espacement dynamique
                        // Formulaire de connexion
                        Container(
                          padding:
                              EdgeInsets.all(width * 0.05), // 5% de padding
                          decoration: BoxDecoration(
                            color: AppColors.lightDark,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Bienvenue ! 👋",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width * 0.06, // 6% de la largeur
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: height * 0.02),
                                BLFormTextField(
                                  hintText: "Email",
                                  onSaved: (value) => _email = value,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Veuillez entrer un email';
                                    }
                                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                        .hasMatch(value)) {
                                      return 'Veuillez entrer un email valide';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: height * 0.01),
                                BLFormTextField(
                                  hintText: "Mot de passe",
                                  onSaved: (value) => _password = value,
                                  isPassword: true,
                                  controller: _passwordController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Veuillez entrer un mot de passe';
                                    }
                                    if (value.length < 6) {
                                      return 'Le mot de passe doit contenir au moins 6 caractères';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: height * 0.01),
                                BLFormTextField(
                                  controller: _confirmPasswordController,
                                  hintText: "Confirmation mot de passe",
                                  isPassword: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Veuillez confirmer votre mot de passe';
                                    }
                                    if (value !=
                                        _passwordController.value.text) {
                                      return 'Les mots de passe ne correspondent pas';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: height * 0.03),
                                // Bouton Inscription
                                BLElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      _createAccount();
                                    }
                                  },
                                  text: "S'inscrire",
                                  variant: ButtonVariant.primary,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.03),
                        // Footer : Lien pour s'inscrire
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Déjà inscrit ?",
                              style: TextStyle(color: Colors.white),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SigninPage()),
                                );
                              },
                              child: const Text(
                                "Connecte-toi",
                                style: TextStyle(
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )))
          ],
        ),
      ),
    );
  }
}
