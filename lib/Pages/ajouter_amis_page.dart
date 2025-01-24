import 'package:flutter/material.dart';
import 'package:myapp/Components/main_frame.dart';
import 'package:myapp/Theme/app_colors.dart';
import 'package:myapp/Theme/app_text_styles.dart';
import 'package:myapp/Components/friendCard.dart';
import 'add_friends_service.dart';
import 'add_friends_dto.dart'; 

class AddFriendsPage extends StatefulWidget {
  const AddFriendsPage({super.key});

  @override
  _AddFriendsPageState createState() => _AddFriendsPageState();
}

class _AddFriendsPageState extends State<AddFriendsPage> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late AddFriendsService _addFriendsService;

  List<AddFriendsDto> friends = [];
  List<AddFriendsDto> displayedFriends = [];
  List<AddFriendsDto> pendingFriends = [];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _addFriendsService = AddFriendsService(baseUrl: 'https://example.com'); // Base URL à remplacer
    _tabController = TabController(length: 2, vsync: this);

    _fetchFriends();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _fetchFriends() async {
    try {
      final friendsList = await _addFriendsService.getFriends();
      final pendingList = await _addFriendsService.getPendingRelationships();
      setState(() {
        friends = friendsList;
        displayedFriends = friendsList;
        pendingFriends = pendingList;
      });
    } catch (e) {
      print("Erreur lors du chargement des amis : $e");
    }
  }

  Future<void> _addFriend(AddFriendsDto friend) async {
    try {
      await _addFriendsService.createRelationship(friend.idReceiver);
      setState(() {
        displayedFriends.remove(friend);
        pendingFriends.add(AddFriendsDto(
          id: friend.id,
          idAsker: friend.idAsker,
          idReceiver: friend.idReceiver,
          status: 'En attente',
        ));
      });
    } catch (e) {
      print("Erreur lors de l'ajout de l'ami : $e");
    }
  }

  Future<void> _removeFriend(AddFriendsDto friend) async {
    try {
      await _addFriendsService.deleteRelationship(friend.idReceiver);
      setState(() {
        pendingFriends.remove(friend);
        displayedFriends.add(AddFriendsDto(
          id: friend.id,
          idAsker: friend.idAsker,
          idReceiver: friend.idReceiver,
          status: 'Ajouter',
        ));
      });
    } catch (e) {
      print("Erreur lors de la suppression de l'ami : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainFrame(
      appBarVariant: AppBarVariant.backAndProfile,
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
                    return friend.idAsker.toString().contains(value) ||
                           friend.idReceiver.toString().contains(value);
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
      currentIndex: 0,
      onTabSelected: (index) {
        Navigator.pushNamed(context, index == 0 ? '/home' : '/defis');
      },
      title: 'Ajout d\'amis',
    );
  }

  Widget _buildAddFriendsContent() {
    return ListView.builder(
      itemCount: displayedFriends.length,
      itemBuilder: (context, index) {
        final friend = displayedFriends[index];
        return FriendCard(
          friend: {
            'first_name': friend.idAsker.toString(), // Modifier en fonction des données réelles
            'last_name': friend.idReceiver.toString(),
            'image_url': '', // Ajouter une URL si disponible
          },
          onAddPressed: friend.status == 'Ajouter'
              ? () => _addFriend(friend)
              : null,
          buttonText: friend.status ?? 'Ajouter',
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
          friend: {
            'first_name': friend.idAsker.toString(),
            'last_name': friend.idReceiver.toString(),
            'image_url': '',
          },
          onAddPressed: () => _removeFriend(friend),
          buttonText: 'Supprimer',
        );
      },
    );
  }
}
