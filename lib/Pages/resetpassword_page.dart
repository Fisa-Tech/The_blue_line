import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/Theme/theme.dart';

class ResetpasswordPage extends StatelessWidget {
  ResetpasswordPage({super.key});
  final TextEditingController _emailController = TextEditingController();

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
  final mediaQuery = MediaQuery.of(context);
  final screenHeight = mediaQuery.size.height;
  final screenWidth = mediaQuery.size.width;

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
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.02,
              horizontal: screenWidth * 0.04,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo Container
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.05),
                  child: SvgPicture.asset(
                    "assets/img/logo.svg",
                    height: screenHeight * 0.1,
                  ),
                ),
                // Formulaire de connexion
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                        padding: EdgeInsets.all(screenWidth * 0.06),
                        decoration: BoxDecoration(
                          color: lightDark,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Mot de passe oublié ! 🔐",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenHeight * 0.03,
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
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: screenHeight * 0.015,
                                  horizontal: screenWidth * 0.03,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            // Bouton Envoyer
                            ElevatedButton(
                               onPressed: () => _sendResetLink(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primary,
                                minimumSize: Size(double.infinity, screenHeight * 0.05),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                "Envoyer",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenHeight * 0.02,
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            // Bouton Annuler
                            ElevatedButton(
                              onPressed: () {
                                // Action pour se connecter
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: grey,
                                minimumSize: Size(double.infinity, screenHeight * 0.05),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                "Annuler",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenHeight * 0.02,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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