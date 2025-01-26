import 'package:flutter/material.dart';
import 'package:myapp/Components/actu_card.dart';
import 'package:myapp/Components/main_frame.dart';
import 'package:myapp/Models/event_dto.dart';
import 'package:myapp/Services/event_service.dart';
import 'package:myapp/user_state.dart'; // Import your event service
import 'package:provider/provider.dart';


class ActualitesPage extends StatefulWidget {
  const ActualitesPage({super.key});

  @override
  _ActualitesPageState createState() => _ActualitesPageState();
}

class _ActualitesPageState extends State<ActualitesPage> {
  late Future<List<EventDTO>> _eventsFuture;

  @override
  void initState() {
    super.initState();
    _eventsFuture = EventService().fetchEvents(context); // Fetch events from the service
  }

  @override
  Widget build(BuildContext context) {

    final userId = Provider.of<UserState>(context, listen: false).currentUser?.id ?? 0;

    return MainFrame(
      appBarVariant: AppBarVariant.backAndProfile,
      title: 'Actualités',
      currentIndex: 0,
      onTabSelected: (int value) {},
      child: FutureBuilder<List<EventDTO>>(
        future: _eventsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucune actualité disponible'));
          } else {
            return SingleChildScrollView( 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: snapshot.data!.map((event) {
                  return Column(
                    children: [
                      const SizedBox(height: 32.0),
                      ActuCard(
                        event: event,
                        userId: userId,
                        //TODO: Créer une méthode dans le challenge_service pour vérifier si un événement à au moins un challenge
                        challenge: true,
                      ),
                      const SizedBox(height: 6.0),
                    ],
                  );
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}