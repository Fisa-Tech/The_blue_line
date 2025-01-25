import 'package:flutter/material.dart';
import 'package:myapp/Theme/app_colors.dart';
import 'package:myapp/Theme/app_text_styles.dart';
import 'challenge_service.dart';

class DetailsDefisPage extends StatefulWidget {
  final int challengeId;

  const DetailsDefisPage({Key? key, required this.challengeId}) : super(key: key);

  @override
  State<DetailsDefisPage> createState() => _DetailsDefisPageState();
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
    // Remplace avec ton service d'API
    final response = await ChallengeService.fetchDefiDetails(widget.challengeId);
    setState(() {
      challengeDetails = response as Map<String, dynamic>?;
      isLoading = false;
    });
  }

  Future<void> fetchParticipants() async {
    // Remplace avec ton service d'API
    final response = await ChallengeService.fetchDefiDetails(widget.challengeId);
    setState(() {
      participants = response as List;
    });
  }

  int getParticipantsCount() {
    return participants.length;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(challengeDetails?['title'] ?? 'Détails Défi'),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              indicatorColor: AppColors.textPrimary,
              labelColor: AppColors.textPrimary,
              unselectedLabelColor: AppColors.lightGrey,
              tabs: [
                Tab(text: 'Détails'),
                Tab(text: 'Classement'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Onglet Détails
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          challengeDetails?['title'] ?? '',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('Objectif: ${challengeDetails?['goal'] ?? ''}'),
                        const SizedBox(height: 8),
                        Text('Date limite: ${challengeDetails?['deadline'] ?? ''}'),
                        const SizedBox(height: 8),
                        Text('Nombre de participants: ${getParticipantsCount()}'),
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
                        return ListTile(
                          leading: Text('${index + 1}'),
                          title: Text(participant['name'] ?? 'Anonyme'),
                          trailing: Text(participant['time'] ?? ''),
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
