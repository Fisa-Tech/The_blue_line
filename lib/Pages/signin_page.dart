import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/Components/button_widget.dart';
import 'package:myapp/Components/form_text_field.dart';
import 'package:myapp/Pages/register_page.dart' as register_page;
import 'package:myapp/Theme/app_colors.dart';
import 'package:myapp/user_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  late UserState userState;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _email;
  String? _password;

  @override
  void initState() {
    super.initState();
    userState = Provider.of<UserState>(context, listen: false);
  }

  Future<void> _loginAccount() async {
    if (_formKey.currentState?.validate() ?? false) {
      final isSuccess = await userState.login(
        _emailController.text,
        _passwordController.text,
      );

      if (isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Connexion réussie')),
        );
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email ou mot de passe incorrect')),
        );
      }
    }
  }

  void _forgotPassword() {
    Navigator.pushNamed(context, '/forgotpassword');
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img/RunGirl.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: AppColors.dark.withOpacity(0.9),
            ),
            // Contenu principal
            SizedBox(
              height: double.infinity,
              child: SingleChildScrollView(
                child: SizedBox(
                  height: screenHeight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                      vertical: screenHeight * 0.05,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Logo
                        Padding(
                          padding: EdgeInsets.only(top: screenHeight * 0.05),
                          child: SvgPicture.asset(
                            "assets/img/logo.svg",
                            height: screenHeight * 0.1,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.05),
                        // Formulaire de connexion
                        Container(
                          padding: EdgeInsets.all(screenWidth * 0.05),
                          decoration: BoxDecoration(
                            color: AppColors.lightDark,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Heureux de te revoir ! 👋",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.03),
                                // Champ Email
                                BLFormTextField(
                                    hintText: "Email",
                                    controller: _emailController,
                                    onSaved: (value) => _email = value,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Veuillez entrer une adresse e-mail';
                                      }
                                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                          .hasMatch(value)) {
                                        return 'Veuillez entrer une adresse e-mail valide';
                                      }
                                      return null;
                                    }),
                                SizedBox(height: screenHeight * 0.02),
                                // Champ Mot de passe
                                BLFormTextField(
                                    hintText: "Mot de passe",
                                    isPassword: true,
                                    controller: _passwordController,
                                    onSaved: (value) => _password = value,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Veuillez entrer un mot de passe';
                                      }
                                      if (value.length < 6) {
                                        return 'Le mot de passe doit contenir au moins 6 caractères';
                                      }
                                      return null;
                                    }),
                                SizedBox(height: screenHeight * 0.02),
                                // Checkbox et Lien
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: userState.rememberMe,
                                          onChanged: (value) {
                                            setState(() {
                                              userState.setRememberMe(
                                                  value ?? false);
                                            });
                                          },
                                          activeColor: AppColors.primary,
                                        ),
                                        const Text(
                                          "Se souvenir",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    TextButton(
                                      onPressed: _forgotPassword,
                                      child: const Text(
                                        "Mot de passe oublié ?",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                // Bouton Connexion
                                BLElevatedButton(
                                    onPressed: _loginAccount,
                                    text: "Connexion",
                                    variant: ButtonVariant.primary),
                                SizedBox(height: screenHeight * 0.04),
                                // Icônes de connexion
                                Wrap(
                                  spacing: screenWidth * 0.02,
                                  children: List.generate(
                                    3,
                                    (index) => CircleAvatar(
                                      radius: screenWidth * 0.06,
                                      backgroundColor: AppColors.primary,
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.05),
                        // Footer : Lien pour s'inscrire
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Pas de compte ?",
                              style: TextStyle(color: Colors.white),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const register_page.RegisterPage()),
                                );
                              },
                              child: const Text(
                                "S'inscrire",
                                style: TextStyle(
                                  color: AppColors.primary,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
