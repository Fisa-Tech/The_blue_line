import 'package:flutter/material.dart';
import 'package:myapp/Components/button_widget.dart';
import 'package:myapp/Components/main_frame.dart';
import 'package:myapp/Theme/app_colors.dart';
import 'package:myapp/Theme/app_text_styles.dart';
import '../Services/challenge_service.dart';
import '../Models/challenge_dto.dart';
import '../Models/challenge_completion_dto.dart';
import '../Services/challenge_completion_service.dart';

class DetailsDefisPage extends StatefulWidget {
  final int challengeId;

  const DetailsDefisPage({Key? key, required this.challengeId}) : super(key: key);

  @override
  _DetailsDefisPageState createState() => _DetailsDefisPageState();
}

class _DetailsDefisPageState extends State<DetailsDefisPage> {
  Map<String, dynamic>? challengeDetails;
  List<dynamic> participants = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchChallengeDetails();
    fetchParticipants();
  }

  Future<void> fetchChallengeDetails() async {
    try {
      final challenge = await ChallengeService.fetchDefiDetails(widget.challengeId);
      setState(() {
        challengeDetails = challenge.toJson();
        isLoading = false;
      });
    } catch (e) {
      print('Erreur lors de la récupération des détails : $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchParticipants() async {
    try {
      final response = await ChallengeService.fetchDefiParticipants(widget.challengeId);
      setState(() {
        participants = response;
      });
    } catch (e) {
      print('Erreur lors de la récupération des participants : $e');
    }
  }

  int _calculateDaysLeft(dynamic deadline) {
  try {
    // Si deadline est une chaîne, le convertir en DateTime
    final deadlineDate = deadline is String ? DateTime.parse(deadline) : deadline;
    final currentDate = DateTime.now();

    // Calculer la différence en jours
    final difference = deadlineDate.difference(currentDate).inDays;

    // Retourner les jours restants, minimum 0 si déjà dépassé
    return difference > 0 ? difference : 0;
  } catch (e) {
    // En cas d'erreur, retourner un message par défaut
    debugPrint('Erreur lors du calcul du délai : $e');
    return 0;
  }
}

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return MainFrame(
      leftIcon: Icons.notifications_outlined,
      appBarVariant: AppBarVariant.backAndShare,
      onLeftIconPressed: () {},
      title: challengeDetails?['titre'] ?? 'Détails Défi',
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
                challengeDetails?['imageUrl'] ?? 'https://placehold.co/600x400.png',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
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
                  // Onglet Détails
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          challengeDetails?['titre'] ?? '',
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
                                  challengeDetails?['distance'] != 0
                                      ? '${challengeDetails?['distance']} km'
                                      : challengeDetails?['time'] != 0
                                          ? '${challengeDetails?['time']} heures'
                                          : 'Objectif inconnu',
                                  style: const TextStyle(fontSize: 16, color: Colors.white),
                                ),
                                Text(
                                  challengeDetails?['type'] ?? 'Type inconnu',
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
                              challengeDetails?['deadline'] != null
                                  ? 'Fin dans ${_calculateDaysLeft(challengeDetails?['deadline'])} jours'
                                  : 'Fin dans N/A jours',
                              style: const TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Icon(Icons.people, color: Colors.white),
                            const SizedBox(width: 8),
                            Text(
                              '${participants.length} participants actuellement',
                              style: const TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),
                        const Spacer(),
                        SizedBox(
                          width: double.infinity,
                          child: BLElevatedButton(
                            text: 'Participer',
                            onPressed: () async {
                              try {
                                // Construire le corps de la requête
                                Map<String, dynamic> requestBody = {
                                  'distanceAchieved': 0,
                                  'timeAchieved': 0,
                                  'completionDate': DateTime.now().toIso8601String(),
                                };

                                // Appel de l'API pour participer au défi
                                await ChallengeCompletionService.addCompletionForChallenge(widget.challengeId, requestBody);

                                // Affichage d'un message de succès
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Participation réussie au défi !')),
                                );

                                // Optionnel : Mettre à jour la liste des participants
                                await fetchParticipants();
                              } catch (e) {
                                // Affichage d'un message d'erreur
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Erreur : ${e.toString()}')),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Onglet Classement
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: ListView.builder(
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
                                      participant['name'] ?? 'Anonyme',
                                      style: AppTextStyles.bodyText1,
                                    ),
                                  ],
                                ),
                              ),
                              // Temps réalisé
                              Text(
                                participant['time'] ?? 'N/A',
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
