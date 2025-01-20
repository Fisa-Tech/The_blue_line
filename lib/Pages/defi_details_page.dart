import 'package:flutter/material.dart';
import 'package:myapp/Components/button_widget.dart';
import 'package:myapp/Components/main_frame.dart';
import 'package:myapp/Theme/app_colors.dart';
import 'package:myapp/Theme/app_text_styles.dart';

class DetailsDefisPage extends StatelessWidget {
  const DetailsDefisPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return MainFrame(
      leftIcon: Icons.notifications_outlined,
      appBarVariant: AppBarVariant.backAndShare,
      onLeftIconPressed: () {},
      title: 'Défis course à pied',
      currentIndex: 0,
      onTabSelected: (int value) {}, 
      child: DefaultTabController(
          length: 2, 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image prenant toute la largeur de l'écran
              SizedBox(
                width: screenWidth,
                child: Image.network(
                  'https://placehold.co/600x400.png', // Remplace par ton image
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16), // Espacement entre l'image et les tabs

              // TabBar pour sélectionner Détails et Classement
              const TabBar(
                indicatorColor: AppColors.textPrimary,
                labelColor: AppColors.textPrimary,
                unselectedLabelColor: AppColors.lightGrey,
                dividerColor: AppColors.lightGrey,
                tabs: [
                  Tab(text: 'Détails'),
                  Tab(text: 'Classement'),
                ],
              ),

              // Contenu des tabs
              Expanded(
                child: TabBarView(
                  children: [
                    // Contenu de l'onglet Détails
                    Padding(
                      padding: const EdgeInsets.only(left: 32, right: 32, top: 16, bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Défi 10km',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Row(
                            children: [
                              Icon(Icons.directions_walk, color: Colors.white),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    '10km au total',
                                    style: TextStyle(fontSize: 16, color: Colors.white),
                                  ),
                                  Text(
                                    'Marche, course ou trail',
                                    style: TextStyle(fontSize: 14, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Row(
                            children: [
                              Icon(Icons.access_time, color: Colors.white),
                              const SizedBox(width: 8),
                              const Text(
                                'Fin dans 10 jours',
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Row(
                            children: [
                              Icon(Icons.people, color: Colors.white),
                              SizedBox(width: 8),
                              Text(
                                '25 participants actuellement',
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                            ],
                          ),
                          const Spacer(),
                          SizedBox(
                            width: double.infinity,
                            child: BLElevatedButton(
                              text: 'Participer',
                              onPressed: () {},
                              ),
                          ),
                        ],
                      ),
                    ),
                    // Contenu de l'onglet Classement (temporaire)
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: ListView.builder(
                        itemCount: 7, // Nombre d'entrées
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Position du participant
                                Text(
                                  '${index + 1}', 
                                  style: AppTextStyles.hintText,
                                ),
                                const SizedBox(width: 16),

                                // Icône et nom du participant
                                const Expanded(
                                  child: Row(
                                    children: [
                                      Icon(Icons.person_2_outlined, color: AppColors.primary),
                                      SizedBox(width: 8),
                                      Text(
                                        'Maxime',
                                        style: AppTextStyles.bodyText1,
                                      ),
                                    ],
                                  ),
                                ),

                                // Temps réalisé
                                const Text(
                                  '42 min 35 sec',
                                  style: AppTextStyles.hintText,
                                ),
                              ],
                            ),
                          );
                        },
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
