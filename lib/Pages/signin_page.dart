import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/Components/button_widget.dart';
import 'package:myapp/Pages/register_page.dart';
import 'package:myapp/Pages/resetpassword_page.dart';
import 'package:myapp/Theme/theme.dart';
import '../api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _email;
  String? _password;
  bool _rememberMe = false;
  final apiService = ApiService(); // Instance de la classe ApiService
  
  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  Future<void> _loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _emailController.text = prefs.getString('email') ?? '';
      _passwordController.text = prefs.getString('password') ?? '';
      _rememberMe = _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;
    });
  }

  Future<void> _saveUserCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    if (_rememberMe) {
      await prefs.setString('email', _email ?? '');
      await prefs.setString('password', _password ?? '');
    } else {
      await prefs.remove('email');
      await prefs.remove('password');
    }
  }

  Future<void> _loginAccount() async {
    if (_formKey.currentState == null) {
      print('Le formulaire n\'est pas initialisé correctement');
      return;
    }
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        final userData = {
          'email': _email,
          'password': _password,
        };

        if (_email != null && _password != null) {
          String url = 'api/users/login?email=$_email&password=$_password';
          final response = await apiService.post(url, userData);

          print('Code de statut: ${response.statusCode}');
          print('Corps de la réponse: ${response.body}');

          if (response.statusCode == 200) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Connexion réussie')),
            );

            await _saveUserCredentials();
            Navigator.pushNamed(context, '/home');
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Erreur: ${response.body}')),
            );
          }
        }
      } catch (e) {
        print("Erreur lors de la connexion: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erreur lors de la connexion, réessayez plus tard')),
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
              color: dark.withOpacity(0.9),
            ),
            // Contenu principal
            SizedBox(
              height: double.infinity,
              child: SingleChildScrollView(
              child: SizedBox(
                height: screenHeight,
                child :Padding(
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
                        color: lightDark,
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
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: "Email",
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                filled: true,
                                fillColor: grey,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 12.0,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (value) => _email = value,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez entrer une adresse e-mail';
                                }
                                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                  return 'Veuillez entrer une adresse e-mail valide';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            // Champ Mot de passe
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "Mot de passe",
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                filled: true,
                                fillColor: grey,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 12.0,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              onSaved: (value) => _password = value,
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
                            SizedBox(height: screenHeight * 0.02),
                            // Checkbox et Lien
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                     Checkbox(
                                    value: _rememberMe,
                                    onChanged: (value) {
                                      setState(() {
                                        _rememberMe = value!;
                                      });
                                    },
                                    activeColor: primary,
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
                            BLElevatedButton(onPressed: _loginAccount, text: "Connexion", variant: ButtonVariant.primary),
                            SizedBox(height: screenHeight * 0.04),
                            // Icônes de connexion
                            Wrap(
                              spacing: screenWidth * 0.02,
                              children: List.generate(
                                3,
                                (index) => CircleAvatar(
                                  radius: screenWidth * 0.06,
                                  backgroundColor: primary,
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
                              MaterialPageRoute(builder: (context) => const RegisterPage()),
                            );
                          },
                          child: const Text(
                            "S'inscrire",
                            style: TextStyle(
                              color: primary,
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
