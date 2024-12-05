import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/Theme/theme.dart';

class ResetpasswordPage extends StatelessWidget {
  const ResetpasswordPage({super.key});

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
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: lightDark,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Mot de passe oublié ! 🔐",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 24),
                            // Champ Email
                            TextField(
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
                            ),

                            const SizedBox(height: 16),
                            // Bouton Connexion
                            ElevatedButton(
                              onPressed: () {
                                // Action pour se connecter
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primary,
                                minimumSize: const Size(double.infinity, 42),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                "Envoyer",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            // Bouton Connexion
                            ElevatedButton(
                              onPressed: () {
                                // Action pour se connecter
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: grey,
                                minimumSize: const Size(double.infinity, 42),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                "Annuler",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
