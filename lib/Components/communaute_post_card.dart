import 'package:flutter/material.dart';
import 'package:myapp/Theme/app_colors.dart';

class CommunautePostCard extends StatelessWidget {
  final String profileName;
  final String postTitle;
  final String postSubtitle;
  final String postText;
  final String postImageUrl;

  const CommunautePostCard({
    super.key,
    required this.profileName,
    required this.postTitle,
    required this.postSubtitle,
    required this.postText,
    required this.postImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      color: AppColors.lightDark, // Couleur similaire à l'exemple
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête : Profil et nom
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey,
              child: Text(
                profileName[0].toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(
              profileName,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          // Image du post
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
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
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  postSubtitle,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 8),
                Text(
                  postText,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Exemple d'utilisation dans une liste
class CommunautePage extends StatelessWidget {
  const CommunautePage({super.key});

  @override
  Widget build(BuildContext context) {
    final posts = List.generate(10, (index) {
      return {
        "profileName": "Ami $index",
        "postTitle": "Titre $index",
        "postSubtitle": "Sous-titre $index",
        "postText":
            "Ceci est le contenu du post $index. Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        "postImageUrl": "https://via.placeholder.com/150", // Placeholder image
      };
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Communauté"),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return CommunautePostCard(
            profileName: post["profileName"]!,
            postTitle: post["postTitle"]!,
            postSubtitle: post["postSubtitle"]!,
            postText: post["postText"]!,
            postImageUrl: post["postImageUrl"]!,
          );
        },
      ),
    );
  }
}
