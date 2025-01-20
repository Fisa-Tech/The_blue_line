import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/Components/button_widget.dart';
import 'package:myapp/Components/group_card.dart';
import 'package:myapp/Components/main_frame.dart';
import 'package:myapp/Theme/app_colors.dart';
import 'package:myapp/Theme/app_text_styles.dart';
import 'package:myapp/Components/communaute_post_card.dart';

class CommunautePage extends StatelessWidget {
  const CommunautePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Deux onglets : Flux et Groupes
      child: MainFrame(
        leftIcon: Icons.person_add,
        onLeftIconPressed: () {
          // Action lorsque l'icône "Ajouter une personne" est pressée
          Navigator.pushNamed(context, '/add-friends'); // Redirection vers la page ajout d'amis
        },
        title: 'Communauté',
        currentIndex: 0,
        onTabSelected: (int value) {},
        bottom: const TabBar(
          indicatorColor: AppColors.textPrimary,
          labelColor: AppColors.textPrimary,
          unselectedLabelColor: AppColors.lightGrey,
          dividerColor: AppColors.lightGrey,
          tabs: [
            Tab(
              text: "Flux",
            ),
            Tab(
              text: "Groupes",
            ),
          ],
        ),
        child: TabBarView(
          children: [
            _buildFluxContent(context),
            _buildGroupesContent(),
          ],
        ),
      ),
    );
  }

  // Widget pour afficher les posts des amis
  static Widget _buildFluxContent(BuildContext context) {
    // Vérifiez ici si l'utilisateur a des amis (par exemple via une liste d'amis)
    bool hasFriends = false; // Remplacez par votre logique réelle

    if (!hasFriends) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/img/logo.svg",
            height: MediaQuery.of(context).size.height * 0.12, // Ajustez la taille du logo
          ),
          const SizedBox(height: 30), // Espacement entre le logo et le texte
          Container(
            width: MediaQuery.of(context).size.width * 0.9, // Par exemple, 90% de la largeur de l'écran
            child: const Text(
              'Abonnez-vous aux profils de vos amis pour voir leurs activités',
              style: AppTextStyles.bodyText1,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 60),
          Container(
            width: MediaQuery.of(context).size.width * 0.6, // Par exemple, 60% de la largeur de l'écran
            child: BLElevatedButton(
              onPressed: () {
                // Naviguer vers la page pour ajouter des amis
                Navigator.pushNamed(context, '/add-friends');
              },
              text: 'Ajouter des amis',
              variant: ButtonVariant.primary, // Choisissez la variante souhaitée
            ),
          ),
        ],
      );
    }

    // Si l'utilisateur a des amis, affichez leurs posts
    return ListView.builder(
      itemCount: 3, // Remplacez par le nombre de posts réels
      itemBuilder: (context, index) {
        // Exemple de données pour un post (tu peux remplacer par les vraies données)
        final post = {
          "profileName": "Ami $index",
          "postTitle": "Titre du post $index",
          "postSubtitle": "Sous-titre du post $index",
          "postText": "Ceci est le contenu du post $index. Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
          "postImageUrl": "https://as2.ftcdn.net/v2/jpg/01/30/27/55/1000_F_130275513_rISEfEpLEX5AGgUUBGbLsGMqgjL1JbP1.jpg", // Image temporaire
        };

        return CommunautePostCard(
          profileName: post["profileName"]!,
          postTitle: post["postTitle"]!,
          postSubtitle: post["postSubtitle"]!,
          postText: post["postText"]!,
          postImageUrl: post["postImageUrl"]!,
        );
      },
    );
  }

    // Widget pour afficher les groupes de l'utilisateur
  Widget _buildGroupesContent() {
    // Liste fictive des groupes (remplace par les données réelles)
    final groupes = [
      {"name": "Groupe 1", "slogan": "Un groupe pour les passionnés de sport"},
      //{"name": "Groupe 2", "slogan": "Les amoureux de la technologie"},
      //{"name": "Groupe 3", "slogan": "Communauté de photographes"},
    ];

    if (groupes.isEmpty) {
      return const Center(
        child: Text(
          'Vous n\'êtes inscrit à aucun groupe.',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.builder(
      itemCount: groupes.length,
      itemBuilder: (context, index) {
        final group = groupes[index];
        return GroupCard(
          groupName: group["name"]!,
          groupSlogan: group["slogan"]!, 
          onTap: () {  },
        );
      },
    );
  }

}
