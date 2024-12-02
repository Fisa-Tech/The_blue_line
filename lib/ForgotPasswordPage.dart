import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  ForgotPasswordPage({super.key});

  void _sendResetLink(BuildContext context) {
    String email = _emailController.text.trim();

    if (email.isEmpty || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez entrer une adresse e-mail valide')),
      );
    } else {
      // Simuler l'envoi d'un e-mail de réinitialisation
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lien de réinitialisation envoyé à $email')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Réinitialiser le mot de passe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Entrez votre adresse e-mail pour recevoir un lien de réinitialisation.',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Adresse e-mail',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _sendResetLink(context),
              child: const Text('Envoyer le lien'),
            ),
          ],
        ),
      ),
    );
  }
}