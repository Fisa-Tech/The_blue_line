import 'package:flutter/material.dart';
import 'package:myapp/Components/main_frame.dart';
import 'package:myapp/Services/toast_service.dart';
import 'package:myapp/Theme/app_colors.dart';
import 'package:myapp/Components/friendCard.dart';
import '../Services/friends_service.dart';
import '../Models/add_friends_dto.dart';

class AddFriendsPage extends StatefulWidget {
  const AddFriendsPage({super.key});

  @override
  State<AddFriendsPage> createState() => _AddFriendsPageState();
}

class _AddFriendsPageState extends State<AddFriendsPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _friendIdController = TextEditingController();

  List<AddFriendsDto> sentFriends = [];
  List<AddFriendsDto> receivedFriends = [];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
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
      final pendingList = await FriendsService.getPendingRelationships(context);
      setState(() {
        sentFriends =
            pendingList.where((friend) => friend.status == 'pending').toList();
        receivedFriends =
            pendingList.where((friend) => friend.status == 'received').toList();
      });
    } catch (e) {
      ToastService.showError("Erreur lors du chargement des amis : $e");
    }
  }

  Future<void> _addFriend(String friendId) async {
    try {
      if (friendId.isEmpty) {
        throw Exception("L'ID de l'ami ne peut pas être vide.");
      }

      await FriendsService.createRelationship(context, friendId);

      setState(() {
        sentFriends.add(AddFriendsDto(
          id: DateTime.now().millisecondsSinceEpoch,
          idAsker: friendId, // Laisse en String
          idReceiver: "", // À définir selon ta logique
          status: 'En attente',
        ));
      });

      _friendIdController.clear();
    } catch (e) {
      ToastService.showError("L'ID de l'ami est invalide ou n'existe pas.");
    }
  }

  Future<void> _removeFriend(AddFriendsDto friend) async {
    try {
      await FriendsService.deleteRelationship(context, friend.id);
      await _fetchFriends();
    } catch (e) {
      ToastService.showError("Erreur lors de la suppression de l'ami : $e");
    }
  }

  Future<void> _acceptFriend(AddFriendsDto friend) async {
    try {
      await FriendsService.updateRelationshipStatus(
          context, friend.id, 'accepted');
      await _fetchFriends();
    } catch (e) {
      ToastService.showError("Erreur lors de l'acceptation de l'ami : $e");
    }
  }

  Future<void> _rejectFriend(AddFriendsDto friend) async {
    try {
      await FriendsService.updateRelationshipStatus(
          context, friend.id, 'rejected');
      await _fetchFriends();
    } catch (e) {
      ToastService.showError("Erreur lors du rejet de l'ami : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainFrame(
      appBarVariant: AppBarVariant.backAndProfile,
      currentIndex: 0,
      title: 'Ajout d\'amis',
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
                    style: const TextStyle(color: AppColors.textPrimary),
                    decoration: InputDecoration(
                      hintText: 'Entrez le friendID',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    final friendId = _friendIdController.text;
                    if (friendId.isNotEmpty) {
                      _addFriend(friendId);
                    }
                  },
                  child: const Text('Ajouter'),
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
