import 'package:flutter/material.dart';
import 'package:myapp/Components/button_widget.dart';
import 'package:myapp/Components/main_frame.dart';
import 'package:myapp/Pages/challenge_completion_service.dart';
import 'package:myapp/Pages/challenge_service.dart';
import 'package:myapp/Theme/app_colors.dart';
import 'package:myapp/Theme/app_text_styles.dart';
import 'challenge_completion_dto.dart';
import 'challenge_dto.dart';

class DetailsDefisPage extends StatelessWidget {
  final Challenge challenge;

  // Constructeur pour passer un défi spécifique
  DetailsDefisPage({required this.challenge});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return MainFrame(
      leftIcon: Icons.notifications_outlined,
      appBarVariant: AppBarVariant.backAndShare,
      onLeftIconPressed: () {
        Navigator.pop(context); // Retour
      },
      title: challenge.titre, // Titre du défi
      currentIndex: 0,
      onTabSelected: (int value) {}, 
      child: DefaultTabController(
        length: 2, 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image prenant toute la largeur de l'écran
            // SizedBox(
            //   width: screenWidth,
            //   child: Image.network(
            //     challenge.imageUrl, // Image du défi
            //     fit: BoxFit.cover,
            //   ),
            // ),
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
                        Text(
                          challenge.titre, // Titre du défi
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Icon(Icons.directions_walk, color: Colors.white),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${challenge.distance} km au total', // Distance totale
                                  style: const TextStyle(fontSize: 16, color: Colors.white),
                                ),
                                Text(
                                  challenge.description, // Description du défi
                                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Icon(Icons.access_time, color: Colors.white),
                            const SizedBox(width: 8),
                            Text(
                              'Fin dans ${challenge.deadline} jours', // Durée restante
                              style: const TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Row(
                        //   children: [
                        //     const Icon(Icons.people, color: Colors.white),
                        //     const SizedBox(width: 8),
                        //     Text(
                        //       '${challenge.participantsCount} participants actuellement', // Nombre de participants
                        //       style: const TextStyle(fontSize: 16, color: Colors.white),
                        //     ),
                        //   ],
                        // ),
                        // const Spacer(),
                        // SizedBox(
                        //   width: double.infinity,
                        //   child: BLElevatedButton(
                        //     text: 'Participer',
                        //     onPressed: () {
                        //       ChallengeService.participateInChallenge(challenge.id);
                        //     },
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  // Contenu de l'onglet Classement
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: FutureBuilder<List<dynamic>>(
                      future: ChallengeService.fetchDefiParticipants(challenge.id),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Erreur: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text('Aucun participant'));
                        } else {
                          final participants = snapshot.data!;
                          return ListView.builder(
                            itemCount: participants.length,
                            itemBuilder: (context, index) {
                              final participant = participants[index];
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
                                    Expanded(
                                      child: Row(
                                        children: [
                                          const Icon(Icons.person_2_outlined, color: AppColors.primary),
                                          const SizedBox(width: 8),
                                          Text(
                                            participant['name'], // Nom du participant
                                            style: AppTextStyles.bodyText1,
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Temps réalisé
                                    Text(
                                      participant['time'], // Temps du participant
                                      style: AppTextStyles.hintText,
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
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