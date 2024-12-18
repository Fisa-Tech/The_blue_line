import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/Theme/app_colors.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

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
            // Overlay pour assombrir l'image de fond
            Container(
              width: double.infinity,
              height: double.infinity,
              color: AppColors.dark.withOpacity(0.9),
            ),
            // Contenu principal
            Column(
              children: [
                // Partie supérieure : Logo
                Expanded(
                  flex: 1, // Prend 50% de la hauteur
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/img/logo.svg",
                      height: 100,
                    ),
                  ),
                ),
                // Partie inférieure : Titres et boutons
                Expanded(
                  flex: 1, // Prend 50% de la hauteur
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Titres
                        const Text(
                          "Welcome BG",
                          style: TextStyle(
                            height: 0.8,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const Text(
                          "Ce soir c'est running tacos",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        // Boutons
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              // Bouton "Se connecter"
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context,
                                      '/login'); // Navigation vers le formulaire
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      AppColors.primary, // Couleur de fond
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        12), // Coins arrondis
                                  ),
                                  minimumSize: const Size(
                                      double.infinity, 40), // Taille minimum
                                ),
                                child: const Text(
                                  'Se connecter',
                                  style: TextStyle(
                                    color: Colors.white, // Couleur du texte
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              // Bouton "S'inscrire"
                              // Bouton "Se connecter"
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context,
                                      '/register'); // Navigation vers le formulaire
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      AppColors.grey, // Couleur de fond
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        12), // Coins arrondis
                                  ),
                                  minimumSize: const Size(
                                      double.infinity, 40), // Taille minimum
                                ),
                                child: const Text(
                                  "S'inscrire",
                                  style: TextStyle(
                                    color: Colors.white, // Couleur du texte
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
