import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/Theme/theme.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

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
                        const SizedBox(height: 8),
                        // Champ Mot de passe
                        TextField(
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
                              onPressed: () {
                                // Action pour "Mot de passe oublié ?"
                              },
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
                          // Action pour s'inscrire
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
