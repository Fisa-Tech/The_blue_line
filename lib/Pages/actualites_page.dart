import 'package:flutter/material.dart';
import 'package:myapp/Components/actu_card.dart';
import 'package:myapp/Components/main_frame.dart';
import 'package:myapp/Models/event_dto.dart';
import 'package:myapp/Services/event_service.dart';
import 'package:myapp/user_state.dart';
import 'package:provider/provider.dart';
import 'package:strava_client/strava_client.dart';

import '../Services/strava_service.dart';

class ActualitesPage extends StatefulWidget {
  const ActualitesPage({super.key});

  @override
  _ActualitesPageState createState() => _ActualitesPageState();
}

class _ActualitesPageState extends State<ActualitesPage> {
  late Future<List<EventDTO>> _eventsFuture;
  late Future<List<SummaryActivity>> _activitiesFuture;

  @override
  void initState() {
    super.initState();
    _eventsFuture = EventService().fetchEvents(context);
    _activitiesFuture = _loadStravaActivities();
  }

  Future<void> _refreshActivities() async {
    setState(() {
      _activitiesFuture = _loadStravaActivities();
    });
  }

  Future<List<SummaryActivity>> _loadStravaActivities() async {
    final isConnected = await StravaService().hasSavedToken();
    if (!isConnected) {
      return [];
    }
    return StravaService().getActivities(daysBefore: 30, perPage: 10);
  }

  @override
  Widget build(BuildContext context) {
    final userId =
        Provider.of<UserState>(context, listen: false).currentUser?.id ?? 0;

    return MainFrame(
      appBarVariant: AppBarVariant.notifAndProfile,
      title: 'Actualités',
      currentIndex: 2,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                FutureBuilder<List<EventDTO>>(
                  future: _eventsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text('Aucune actualité disponible'));
                    } else {
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: snapshot.data!.map((event) {
                            return Column(
                              children: [
                                ActuCard(
                                  event: event,
                                  userId: userId,
                                  //TODO: Créer une méthode dans le challenge_service pour vérifier si un événement à au moins un challenge
                                  challenge: true,
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 32),
                Text('Mes activités Strava (30 derniers jours)',
                    style: Theme.of(context).textTheme.titleLarge),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: _refreshActivities,
                ),
                FutureBuilder<List<SummaryActivity>>(
                  future: _activitiesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text(
                              'Erreur lors du chargement Strava: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      // Soit pas connecté, soit pas d’activités
                      return const Center(
                          child: Text('Aucune activité Strava'));
                    } else {
                      final activities = snapshot.data!;
                      return Column(
                        children: activities.map((act) {
                          return Card(
                            child: ListTile(
                              title: Text(act.name ?? 'Activité sans nom'),
                              subtitle: Text(
                                "Distance : ${(act.distance ?? 0 / 1000).toStringAsFixed(2)} km",
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }
                  },
                ),
                const SizedBox(height: 24),
              ]))),
    );
  }
}
