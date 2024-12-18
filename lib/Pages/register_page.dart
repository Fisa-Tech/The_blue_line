import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/Pages/signin_page.dart';
import 'package:myapp/Theme/theme.dart';
import '../api_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _password;
  String? _gender;
  final apiService = ApiService(); // Crée une instance de la classe ApiService
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

    Future<void> _createAccount() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        // Préparer les données utilisateur
        final userData = {
          'lastname': _lastName,
          'firstname': _firstName,
          'email': _email,
          'password': _password,
          'sex': _gender,
        };

        // Envoyer les données à l'API avec la valeur password dans le corps de la requête
        if (_password != null) {
          final url = 'api/users/register?password=$_password';
          final response = await apiService.post(url, userData);
        
        // Gérer la réponse
        if (response != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Compte créé avec succès !')),
          );
          Navigator.pushNamed(context, '/login');
          // Navigate to another page if needed
        }
        }
      } catch (e) {
        print("Erreur lors de la création du compte");
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'Erreur lors de la création du compte, réessayer plus tard')),
        );
      }
    }
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
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Bienvenue ! 👋",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Champ Email
                        TextFormField(
                          style: TextStyle(color: Colors.grey[400]),
                          decoration: InputDecoration(
                            hintText: "Nom",
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
                          onSaved: (value) => _lastName = value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre nom';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          style: TextStyle(color: Colors.grey[400]),
                          decoration: InputDecoration(
                            hintText: "Prénom",
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
                          onSaved: (value) => _firstName = value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre prénom';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 8),
                        // Champ Mot de passe
                        TextFormField(
                          style: TextStyle(color: Colors.grey[400]),
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
                              return 'Veuillez entrer votre email';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                              return 'Veuillez entrer un email valide';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 8),
                        // Champ Mot de passe
                        TextFormField(
                          controller: _passwordController,
                          style: TextStyle(color: Colors.grey[400]),
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

                        const SizedBox(height: 8),

                        // Champ Confirmation du mot de passe
                        TextFormField(
                          controller: _confirmPasswordController,
                          style: TextStyle(color: Colors.grey[400]),
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Confirmation mot de passe",
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez confirmer votre mot de passe';
                            }
                            if (value != _passwordController.text) {
                              return 'Les mots de passe ne correspondent pas';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 8),
                        // Dropdown pour sélectionner le sexe
                        DropdownButtonFormField<String>(
                          style: TextStyle(color: Colors.grey[400]),
                          decoration: InputDecoration(
                            hintText: 'Sexe', // Équivalent à labelText pour cohérence
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
                          items: ['MALE', 'FEMALE', 'OTHER']
                              .map((gender) => DropdownMenuItem(
                                    value: gender,
                                    child: Text(gender),
                                  ))
                              .toList(),
                          onChanged: (value) => setState(() {
                            _gender = value; // Assurez-vous que `_gender` est défini dans votre classe
                          }),
                          validator: (value) {
                            if (value == null) {
                              return 'Veuillez sélectionner votre sexe';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        // Bouton Connexion
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              // Traitez les données du formulaire
                              print('Nom: $_lastName');
                              print('Prénom: $_firstName');
                              print('Email: $_email');
                              print('Mot de passe: $_password');
                              print('Sexe: $_gender');
                              _createAccount();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primary,
                            minimumSize: const Size(double.infinity, 42),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "S'incrire",
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
                        "Déjà inscrit ?",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SigninPage()),
                          );
                        },
                        child: const Text(
                          "connect toi",
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