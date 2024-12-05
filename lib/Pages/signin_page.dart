import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/Pages/register_page.dart';
import 'package:myapp/Pages/resetpassword_page.dart';
import 'package:myapp/Theme/theme.dart';
import '../api_service.dart';

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
  final apiService = ApiService(); // Crée une instance de la classe ApiService

  Future<void> _loginAccount() async {
      if (_formKey.currentState == null) {
    // Ajouter un log ou un gestionnaire d'erreurs si nécessaire
        print('Le formulaire n\'est pas initialisé correctement');
        return;
      }
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        try {
          // Préparer les données utilisateur
          final userData = {
            'email': _email,
            'password': _password,
          };

          if (_password != null && _email != null) {
            String url = 'api/users/login?email=$_email&password=$_password';
            url = url.replaceAll('@', '%40');
            final response = await apiService.post(url, userData);
            print(response);

          }
        } catch (e) {
          if(e is FormatException){
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Connexion réussie')),
            );
            // Navigate to another page if needed
            Navigator.pushNamed(context, '/');
          }else{
          print("Erreur lors de la connexion");
          print(e);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Erreur lors de la connexion, réessayer plus tard')),
          );
        }
      }
    }
    }
    void _forgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResetpasswordPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            // Overlay pour assombrir l'image
            Container(
              width: double.infinity,
              height: double.infinity,
              color: dark.withOpacity(0.9),
            ),
            // Contenu de la page
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo Container
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: SvgPicture.asset(
                      "assets/img/logo.svg",
                      height: 100,
                    ),
                  ),
                  // Formulaire de connexion
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: lightDark,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Form(
                    key: _formKey, // Associe le formulaire à votre GlobalKey
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
                        const SizedBox(height: 24),
                        // Champ Email
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            filled: true,
                            fillColor: grey,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 12.0),
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
                        const SizedBox(height: 8),
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
                                vertical: 4.0, horizontal: 12.0),
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
                        // Checkbox et Lien
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: false,
                                  onChanged: (value) {
                                    // Action sur checkbox
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
                        const SizedBox(height: 8),
                        // Bouton Connexion
                        ElevatedButton(
                          onPressed: _loginAccount,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primary,
                            minimumSize: const Size(double.infinity, 42),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Connexion",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        // Icônes de connexion
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            3,
                            (index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: CircleAvatar(
                                radius: 24,
                                backgroundColor: primary,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ),
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
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}