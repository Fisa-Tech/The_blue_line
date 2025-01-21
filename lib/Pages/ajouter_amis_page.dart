import 'package:flutter/material.dart';
import 'package:myapp/Components/main_frame.dart';
import 'package:myapp/Theme/app_colors.dart';
import 'package:myapp/Theme/app_text_styles.dart';
import 'package:myapp/Components/friendCard.dart'; // Je suppose que tu as un dossier widgets

class AddFriendsPage extends StatefulWidget {
  const AddFriendsPage({super.key});

  @override
  _AddFriendsPageState createState() => _AddFriendsPageState();
}

class _AddFriendsPageState extends State<AddFriendsPage> with SingleTickerProviderStateMixin {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> friends = []; // Liste des amis, tu peux la remplacer par des données réelles.
  List<Map<String, String>> displayedFriends = []; // Liste des amis affichés
  List<Map<String, String>> pendingFriends = []; // Liste des demandes en cours
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Exemple de données d'amis
    friends = [
      {'first_name': 'Rafa', 'last_name': 'Nadal', 'image_url': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRClykP2AdMI6Ifav78RmO6iCBQ1GVMoW8yZB6oijRwqbL9r1ktazq1d0TYoUltNyGqCIK7hA8-yspWnV8T5UJYSg'},
      {'first_name': 'Iga', 'last_name': 'Swiatek', 'image_url': 'https://media.ouest-france.fr/v1/pictures/MjAyNTAxNzM2MWMwN2U0ZTBiN2NjZjMzMTY2YjczZWYyMWNkZTM?width=1260&height=708&focuspoint=50%2C25&cropresize=1&client_id=bpeditorial&sign=8180d92713f939d6b7c0618a1215dfe32f101e22aa5e4c947a680167f2a64bf0'},
      // Ajoutez plus d'amis ici
    ];
    // Initialiser la liste affichée avec les 10 premiers amis
    displayedFriends = friends.take(4).toList();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _addFriend(Map<String, String> friend) {
    setState(() {
      displayedFriends.remove(friend);
      pendingFriends.add({...friend, 'status': 'En attente'});
    });
  }

  void _removeFriend(Map<String, String> friend) {
    setState(() {
      pendingFriends.remove(friend);
      displayedFriends.add({...friend, 'status': 'Ajouter'});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainFrame(
      leftIcon: Icons.arrow_back,
      onLeftIconPressed: () {
        // Action lorsque l'icône "Ajouter une personne" est pressée
        Navigator.pushNamed(context, '/communaute-page'); // Redirection vers la page ajout d'amis
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              style: TextStyle(color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: 'Rechercher par prénom ou nom',
                prefixIcon: Icon(Icons.search, color: AppColors.textPrimary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  displayedFriends = friends.where((friend) {
                    return friend['first_name']!.toLowerCase().contains(value.toLowerCase()) ||
                           friend['last_name']!.toLowerCase().contains(value.toLowerCase());
                  }).toList();
                });
              },
            ),
          ),
          TabBar(
            controller: _tabController,
            indicatorColor: AppColors.textPrimary,
            labelColor: AppColors.textPrimary,
            unselectedLabelColor: AppColors.lightGrey,
            dividerColor: AppColors.lightGrey,
            tabs: const [
              Tab(text: 'Ajouter'),
              Tab(text: 'En cours'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAddFriendsContent(),
                _buildPendingFriendsContent(),
              ],
            ),
          ),
        ],
      ),
      currentIndex: 0, // Par exemple, l'index pour l'onglet actif
      onTabSelected: (index) {
        // Logique de navigation par onglets
        Navigator.pushNamed(context, index == 0 ? '/home' : '/defis');
      },
      title: 'Ajout d\'amis',
      appBarVariant: AppBarVariant.notifAndProfile,
    );
  }

  Widget _buildAddFriendsContent() {
    return ListView.builder(
      itemCount: displayedFriends.length,
      itemBuilder: (context, index) {
        final friend = displayedFriends[index];
        return FriendCard(
          friend: friend,
          onAddPressed: friend['status'] == 'Ajouter'
              ? () => _addFriend(friend)
              : null,
          buttonText: friend['status'] ?? 'Ajouter',
        );
      },
    );
  }

  Widget _buildPendingFriendsContent() {
    return ListView.builder(
      itemCount: pendingFriends.length,
      itemBuilder: (context, index) {
        final friend = pendingFriends[index];
        return FriendCard(
          friend: friend,
          onAddPressed: () => _removeFriend(friend),
          buttonText: 'Supprimer',
        );
      },
    );
  }
}
