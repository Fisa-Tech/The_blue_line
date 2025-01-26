import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myapp/Models/event_dto.dart';
import 'package:myapp/Services/event_service.dart';
import 'package:myapp/Theme/app_colors.dart';

class ActuCard extends StatefulWidget {
  final EventDTO event;
  final int userId;
  final bool challenge;

  const ActuCard({
    super.key,
    required this.event,
    required this.userId,
    this.challenge = false,
  });

  @override
  _ActuCardState createState() => _ActuCardState();
}

class _ActuCardState extends State<ActuCard> {
  late bool isParticipating;
  late int participantsCount;

  @override
  void initState() {
    super.initState();
    isParticipating = widget.event.participantIds.contains(widget.userId);
    participantsCount = widget.event.participantIds.length;
  }

  void toggleParticipation() async {
    try {
      if (isParticipating) {
        await EventService().leaveEvent(context, widget.event.id);
        setState(() {
          isParticipating = false;
          participantsCount--;
        });
      } else {
        await EventService().joinEvent(context, widget.event.id);
        setState(() {
          isParticipating = true;
          participantsCount++;
        });
      }
    } catch (e) {
      // Afficher une snackbar en cas d'erreur
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Une erreur est survenue : $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void navigateToChallenges() {
    Navigator.pushNamed(
      context,
      '/challenges',
      arguments: {'filter': widget.event.id},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      color: AppColors.lightDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image du post
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[400], // Couleur de placeholder pour l'image
              image: const DecorationImage(
                image: AssetImage('assets/img/event_default.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Contenu : Titre, sous-titre et texte
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  utf8.decode(widget.event.name.runes.toList()),
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  EventService().formatEventDates(widget.event.startDate, widget.event.endDate),
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Text(
                  utf8.decode(widget.event.description.runes.toList()),
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
          // Boutons et compteur de participants
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Compteur de participants avec icône
                Row(
                  children: [
                    const Icon(
                      Icons.person,
                      color: Colors.grey,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      participantsCount.toString(),
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
                // Boutons alignés à droite
                Row(
                  children: [
                    // Bouton "Voir le défi"
                    if (widget.challenge)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: navigateToChallenges,
                        child: const Text(
                          'Défis',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    const SizedBox(width: 8), // Espacement entre les boutons
                    // Bouton "Participer" ou "Annuler participation"
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isParticipating ? AppColors.danger : AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: toggleParticipation,
                      child: Text(
                        isParticipating ? 'Annuler' : 'Participer',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
