import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/Components/button_widget.dart';
import 'package:myapp/Components/form_text_field.dart';
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
  final size = MediaQuery.of(context).size;
  final width = size.width;
  final height = size.height;

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
          // Contenu de la page avec défilement
          SizedBox(
            height: height,
            child: SingleChildScrollView(
              child: SizedBox(
                height: height,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05, // 5% de marge horizontale
                vertical: height * 0.02, // 2% de marge verticale
              ),
              child: Column(
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
                    padding: EdgeInsets.all(width * 0.05), // 5% de padding
                    decoration: BoxDecoration(
                      color: lightDark,
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
                          // Champs de formulaire (généralisation possible)
                          BLFormTextField(
                            hintText: "Nom", 
                            onSaved: (value) => _lastName = value,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre nom';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: height * 0.01),
                          BLFormTextField(
                            hintText: "Prénom", 
                            onSaved: (value) => _firstName = value,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre prénom';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: height * 0.01),
                          BLFormTextField(
                            hintText: "Email", 
                            onSaved: (value) => _email = value,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer un email';
                              }
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                return 'Veuillez entrer un email valide';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: height * 0.01),
                          BLFormTextField(hintText: "Mot de passe", 
                            onSaved: (value) => _password = value,
                            isPassword: true,
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
                            hintText: "Confirmation mot de passe",
                            onSaved: (value) => _password = value,
                            isPassword: true,
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
                          SizedBox(height: height * 0.02),
                          // Dropdown Sexe
                          DropdownButtonFormField<String>(
                            style: TextStyle(color: Colors.grey[400]),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: grey,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: height * 0.01, // Ajustez si besoin
                                horizontal: width * 0.02,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            hint: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Sexe',
                                style: TextStyle(color: Colors.grey[400]),
                              ),
                            ),
                            items: ['MALE', 'FEMALE', 'OTHER']
                                .map((gender) => DropdownMenuItem(
                                      value: gender,
                                      child: Text(gender),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _gender = value;
                              });
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Veuillez sélectionner votre sexe';
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
                            variant: ButtonVariant.primary
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
                          style: TextStyle(color: primary),
                        ),
                      ),
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

Widget _buildTextField(String hintText, Function(String?)? onSaved,
    {bool isPassword = false, bool isEmail = false}) {
  return TextFormField(
    style: TextStyle(color: Colors.grey[400]),
    obscureText: isPassword,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey[400]),
      filled: true,
      fillColor: grey,
      contentPadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
    keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
    onSaved: onSaved,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Veuillez entrer $hintText';
      }
      if (isEmail &&
          !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
        return 'Veuillez entrer un email valide';
      }
      return null;
    },
  );
}

}