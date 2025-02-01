import 'package:flutter/material.dart';
import 'package:myapp/Components/button_widget.dart';
import 'package:myapp/Components/main_frame.dart';
import 'package:myapp/Theme/app_colors.dart';
import 'package:myapp/Theme/app_text_styles.dart';
import '../Services/challenge_service.dart';
import '../Services/challenge_completion_service.dart';
import '../Services/user_service.dart';

class DetailsDefisPage extends StatefulWidget {
  final int challengeId;

  const DetailsDefisPage({super.key, required this.challengeId});

  @override
  State<DetailsDefisPage> createState() => _DetailsDefisPageState();
}

class _DetailsDefisPageState extends State<DetailsDefisPage> {
  Map<String, dynamic>? challengeDetails;
  List<Map<String, dynamic>> participants = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchChallengeDetails();
    fetchParticipants();
  }

  Future<void> fetchChallengeDetails() async {
    try {
      final challenge =
          await ChallengeService.fetchDefiDetails(context, widget.challengeId);
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
      final challengeCompletions =
          await ChallengeService.fetchDefiParticipants(context, widget.challengeId);
      
      List<Map<String, dynamic>> updatedParticipants = [];

      for (var completion in challengeCompletions) {
        int userId = completion['userId'];
        Map<String, dynamic> user = await UserService.getUserById(userId);

        updatedParticipants.add({
          'firstname': user['firstname'] ?? 'Inconnu',
          'lastname': user['lastname'] ?? '',
          'score': completion['time'] ?? completion['distance'] ?? 'N/A',
        });
      }

      setState(() {
        participants = updatedParticipants;
      });
    } catch (e) {
      print('Erreur lors de la récupération des participants : $e');
    }
  }

  int _calculateDaysLeft(dynamic deadline) {
    try {
      final deadlineDate =
          deadline is String ? DateTime.parse(deadline) : deadline;
      final currentDate = DateTime.now();
      final difference = deadlineDate.difference(currentDate).inDays;
      return difference > 0 ? difference : 0;
    } catch (e) {
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
      onActionButtonPressed: () {},
      title: challengeDetails?['titre'] ?? 'Détails Défi',
      currentIndex: 0,
      child: DefaultTabController(
        length: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: screenWidth,
              child: Image.network(
                challengeDetails?['imageUrl'] ?? 'https://contents.mediadecathlon.com/s885269/k\$7baab7fd8d7bb51d45ef4a9fadace27a/1200x0/1.91cr1/run.png?format=auto',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
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
            Expanded(
              child: TabBarView(
                children: [
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
                                Map<String, dynamic> requestBody = {
                                  'distanceAchieved': 0,
                                  'timeAchieved': 0,
                                  'completionDate': DateTime.now().toIso8601String(),
                                };

                                await ChallengeCompletionService
                                    .addCompletionForChallenge(widget.challengeId, requestBody);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Participation réussie au défi !')),
                                );

                                await fetchParticipants();
                              } catch (e) {
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
                              Text(
                                '${index + 1}',
                                style: AppTextStyles.hintText,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Row(
                                  children: [
                                    const Icon(Icons.person_2_outlined, color: AppColors.primary),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${participant['firstname']} ${participant['lastname']}',
                                      style: AppTextStyles.bodyText1,
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                participant['score'].toString(),
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
