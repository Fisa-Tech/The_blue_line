import 'package:flutter/material.dart';
import 'package:myapp/Components/actu_card.dart';
import 'package:myapp/Components/main_frame.dart';

class ActualitesPage extends StatelessWidget {
  const ActualitesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainFrame(
      appBarVariant: AppBarVariant.backAndProfile,
      title: 'Actualités',
      currentIndex: 0,
      onTabSelected: (int value) {  },
      child: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32.0),
              ActuCard(
                postTitle: "Evènement", 
                postSubtitle: "Titre de l'évènement", 
                postText: "Description de l'évènement", 
                postImageUrl: "https://placehold.co/600x200.png",
                challenge: true,
              ),
              const SizedBox(height: 6.0),
              ActuCard(
                postTitle: "Actualité", 
                postSubtitle: "Titre de l'actualité", 
                postText: "Description de l'actualité", 
                postImageUrl: "https://placehold.co/600x200.png",
                challenge: false,
                ),
            ],
          ),
      ),
    );
  }
}