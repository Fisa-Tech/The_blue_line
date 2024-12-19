import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/Theme/theme.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtenir les dimensions de l'écran
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
            // Overlay pour assombrir l'image de fond
            Container(
              width: double.infinity,
              height: double.infinity,
              color: dark.withOpacity(0.9),
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
                      height: height * 0.12, // 12% de la hauteur de l'écran
                    ),
                  ),
                ),
                // Partie inférieure : Titres et boutons
                Expanded(
                  flex: 1, // Prend 50% de la hauteur
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.06),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Titres
                        Text(
                          "Welcome BG",
                          style: TextStyle(
                            height: 1.2,
                            fontSize: width * 0.1, // 10% de la largeur de l'écran
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Ce soir c'est running tacos",
                          style: TextStyle(
                            fontSize: width * 0.04, // 4% de la largeur de l'écran
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: height * 0.04), // Espacement dynamique
                        // Boutons
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                          child: Column(
                            children: [
                              // Bouton "Se connecter"
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, '/login'); // Navigation vers le formulaire
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primary, // Couleur de fond
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        12), // Coins arrondis
                                  ),
                                  minimumSize: Size(
                                      double.infinity, height * 0.06), // Taille dynamique
                                ),
                                child: Text(
                                  'Se connecter',
                                  style: TextStyle(
                                    color: Colors.white, // Couleur du texte
                                    fontSize: width * 0.045, // Taille dynamique
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(height: height * 0.02), // Espacement dynamique
                              // Bouton "S'inscrire"
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, '/register'); // Navigation vers le formulaire
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: grey, // Couleur de fond
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        12), // Coins arrondis
                                  ),
                                  minimumSize: Size(
                                      double.infinity, height * 0.06), // Taille dynamique
                                ),
                                child: Text(
                                  "S'inscrire",
                                  style: TextStyle(
                                    color: Colors.white, // Couleur du texte
                                    fontSize: width * 0.045, // Taille dynamique
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
