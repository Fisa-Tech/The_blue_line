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
  final TextEditingController _friendIdController = TextEditingController();
  late AddFriendsService _addFriendsService;

  List<AddFriendsDto> sentFriends = [];
  List<AddFriendsDto> receivedFriends = [];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _addFriendsService = AddFriendsService(baseUrl: 'https://example.com');
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
      final sentList = await _addFriendsService.getPendingRelationships();
      final receivedList = await _addFriendsService.getPendingRelationships();
      setState(() {
        sentFriends = sentList;
        receivedFriends = receivedList;
      });
    } catch (e) {
      print("Erreur lors du chargement des amis : $e");
    }
  }

  Future<void> _addFriend(String friendId) async {
    try {
      await _addFriendsService.createRelationship(int.parse(friendId));
      setState(() {
        sentFriends.add(AddFriendsDto(
          id: DateTime.now().millisecondsSinceEpoch,
          idAsker: int.parse(friendId),
          idReceiver: 0, // À définir en fonction de votre logique
          status: 'En attente',
        ));
      });
      _friendIdController.clear();
    } catch (e) {
      print("Erreur lors de l'ajout de l'ami : $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("L'ami n'existe pas.")),
      );
    }
  }

  Future<void> _removeFriend(AddFriendsDto friend) async {
    try {
      await _addFriendsService.deleteRelationship(friend.idReceiver);
      setState(() {
        sentFriends.remove(friend);
      });
    } catch (e) {
      print("Erreur lors de la suppression de l'ami : $e");
    }
  }

  Future<void> _acceptFriend(AddFriendsDto friend) async {
    try {
      await _addFriendsService.updateRelationshipStatus(friend.id, 'accepted');
      setState(() {
        receivedFriends.remove(friend);
      });
    } catch (e) {
      print("Erreur lors de l'acceptation de l'ami : $e");
    }
  }

  Future<void> _rejectFriend(AddFriendsDto friend) async {
    try {
      await _addFriendsService.updateRelationshipStatus(friend.id, 'rejected');
      setState(() {
        receivedFriends.remove(friend);
      });
    } catch (e) {
      print("Erreur lors du rejet de l'ami : $e");
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
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _friendIdController,
                    style: TextStyle(color: AppColors.textPrimary),
                    decoration: InputDecoration(
                      hintText: 'Entrez le friendID',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    final friendId = _friendIdController.text;
                    if (friendId.isNotEmpty) {
                      _addFriend(friendId);
                    }
                  },
                  child: Text('Ajouter'),
                ),
              ],
            ),
          ),
          TabBar(
            controller: _tabController,
            indicatorColor: AppColors.textPrimary,
            labelColor: AppColors.textPrimary,
            unselectedLabelColor: AppColors.lightGrey,
            dividerColor: AppColors.lightGrey,
            tabs: const [
              Tab(text: 'Envoyé'),
              Tab(text: 'Reçu'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildSentFriendsContent(),
                _buildReceivedFriendsContent(),
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

  Widget _buildSentFriendsContent() {
    return ListView.builder(
      itemCount: sentFriends.length,
      itemBuilder: (context, index) {
        final friend = sentFriends[index];
        return FriendCard(
          friend: {
            'first_name': friend.idAsker.toString(),
            'last_name': friend.idReceiver.toString(),
            'image_url': '',
          },
          onAddPressed: () => _removeFriend(friend),
          buttonText: 'Supprimer',
          onAcceptPressed: null,
          onRejectPressed: null,
        );
      },
    );
  }

  Widget _buildReceivedFriendsContent() {
    return ListView.builder(
      itemCount: receivedFriends.length,
      itemBuilder: (context, index) {
        final friend = receivedFriends[index];
        return FriendCard(
          friend: {
            'first_name': friend.idAsker.toString(),
            'last_name': friend.idReceiver.toString(),
            'image_url': '',
          },
          onAddPressed: null,
          buttonText: '',
          onAcceptPressed: () => _acceptFriend(friend),
          onRejectPressed: () => _rejectFriend(friend),
        );
      },
    );
  }
}
