import 'package:flutter/material.dart';
import 'package:myapp/Theme/app_colors.dart';

class ActuCard extends StatelessWidget {
  final String postTitle;
  final String postSubtitle;
  final String postText;
  final String postImageUrl;
  final bool challenge;

  const ActuCard({
    Key? key,
    required this.postTitle,
    required this.postSubtitle,
    required this.postText,
    required this.postImageUrl,
    this.challenge = false,
  }) : super(key: key);

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
              image: DecorationImage(
                image: NetworkImage(postImageUrl),
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
                  postTitle,
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  postSubtitle,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Text(
                  postText,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
          // Bouton de participation au défi s'il y en a un
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: challenge
                  ? TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Voir le défi',
                        style: TextStyle(color: AppColors.primary),
                      ),
                    )
                  : const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
