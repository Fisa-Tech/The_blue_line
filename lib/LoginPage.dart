import 'package:flutter/material.dart';
import 'ForgotPasswordPage.dart';
import 'api_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _email;
  String? _password;
  final apiService = ApiService(); // Crée une instance de la classe ApiService

   Future<void> _loginAccount() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        // Préparer les données utilisateur
        final userData = {
          'email': _email,
          'mot_de_passe': _password,
        };

        // Envoyer les données à l'API
        final response = await apiService.post('https://blue-line-preprod.fisadle.fr/api/users/login', userData);

        // Gérer la réponse
        if (response != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Connexion réussie')),
          );
          // Navigate to another page if needed
        }
      } catch (e) {
        print("Erreur lors de la connexion");
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la connexion, réessayer plus tard')),
        );
      }
    }
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Récupérer les valeurs des champs
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      // Simuler une connexion (remplacer par votre logique d'authentification)
      print("E-mail : $email");
      print("Mot de passe : $password");

      // Exemple : Redirection après la connexion
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Connexion réussie pour $email')),
      );

      // Exemple : Redirection après la connexion
      Navigator.pushNamed(context, '/'); // Redirection vers la page d'accueil
    }
  }

  void _forgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Adresse e-mail',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
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
              SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
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
              SizedBox(height: 8.0),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _forgotPassword,
                  child: Text('Mot de passe oublié ?'),
                ),
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _login,
                child: Text('Se connecter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}