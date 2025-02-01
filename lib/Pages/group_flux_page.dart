import 'package:flutter/material.dart';
import 'package:myapp/Components/communaute_post_card.dart';
import 'package:myapp/Components/main_frame.dart';
import 'package:myapp/Theme/app_colors.dart';
import 'package:myapp/Theme/app_text_styles.dart';

class GroupFeedPage extends StatelessWidget {
  final String groupName;

  const GroupFeedPage({super.key, required this.groupName});

  @override
  Widget build(BuildContext context) {
    final posts = List.generate(4, (index) {
      return {
        "profileName": "Ami $index",
        "postTitle": "Titre $index",
        "postSubtitle": "Sous-titre $index",
        "postText":
            "Ceci est le contenu du post $index. Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        "postImageUrl":
            "https://as2.ftcdn.net/v2/jpg/01/30/27/55/1000_F_130275513_rISEfEpLEX5AGgUUBGbLsGMqgjL1JbP1.jpg", // Placeholder image
      };
    });

    return MainFrame(
      leftIcon: Icons.arrow_back,
      onActionButtonPressed: () {
        // Action lorsque l'icône "Ajouter une personne" est pressée
        Navigator.pushNamed(
            context, '/home'); // Redirection vers la page ajout d'amis
      },
      child: ListView.builder(
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
      currentIndex: 0,
      title: '$groupName',
      appBarVariant: AppBarVariant.backAndProfile,
    );
  }
}
