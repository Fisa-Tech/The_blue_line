import 'package:flutter/material.dart';
import 'package:myapp/Components/form_text_field.dart';
import 'package:myapp/Components/main_frame.dart';
import 'package:myapp/Models/user_dto.dart';
import 'package:myapp/Services/toast_service.dart';
import 'package:myapp/Theme/app_colors.dart';
import 'package:myapp/Components/friendCard.dart';
import 'package:myapp/Theme/app_text_styles.dart';
import 'package:myapp/user_state.dart';
import '../Services/friends_service.dart';
import '../Models/add_friends_dto.dart';
import 'package:provider/provider.dart';

class AddFriendsPage extends StatefulWidget {
  const AddFriendsPage({super.key});

  @override
  State<AddFriendsPage> createState() => _AddFriendsPageState();
}

class _AddFriendsPageState extends State<AddFriendsPage>
    with SingleTickerProviderStateMixin {
  late UserState userState = Provider.of<UserState>(context, listen: false);
  final TextEditingController _friendIdController = TextEditingController();

  List<UserDto> friends = [];
  List<AddFriendsDto> pendingFriends = [];
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
      final friendsList = await FriendsService.getFriends(context);
      setState(() {
        friends = friendsList;
        pendingFriends = pendingList;
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

      await _fetchFriends();

      _friendIdController.clear();
    } catch (e) {
      ToastService.showError("L'ID de l'ami est invalide ou n'existe pas.");
    }
  }

  Future<void> _removeFriend(UserDto friend) async {
    try {
      await FriendsService.deleteRelationship(context, friend.id!);
      await _fetchFriends();
    } catch (e) {
      ToastService.showError("Erreur lors de la suppression de l'ami : $e");
    }
  }

  Future<void> _acceptFriend(AddFriendsDto friend) async {
    try {
      await FriendsService.updateRelationshipStatus(
          context, friend.id, 'ACCEPTED');
      await _fetchFriends();
    } catch (e) {
      ToastService.showError("Erreur lors de l'acceptation de l'ami : $e");
    }
  }

  Future<void> _rejectFriend(AddFriendsDto friend) async {
    try {
      await FriendsService.updateRelationshipStatus(
          context, friend.id, 'REFUSED');
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
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Row(
              children: [
                Expanded(
                  child: BLFormTextField(
                    controller: _friendIdController,
                    hintText: 'ID de l\'ami',
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
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(34, 48),
                      backgroundColor: AppColors.primary,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    child: const Text(
                      '+',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.lightDark,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Mon id: ${userState.currentUser?.friendId}',
                      style: const TextStyle(
                          color: AppColors.disabled, fontSize: 16),
                    ),
                  ),
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
              Tab(text: 'Amis'),
              Tab(text: 'Invitations'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildFriendsContent(),
                _buildPendingFriendsContent(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFriendsContent() {
    if (friends.isEmpty) {
      return const Center(
          child: Text('Aucun ami', style: AppTextStyles.bodyText1));
    }
    return ListView.builder(
      itemCount: friends.length,
      itemBuilder: (context, index) {
        final friend = friends[index];
        return FriendCard(
          friend: friend,
          onAddPressed: () => _removeFriend(friend),
          buttonText: '',
          onAcceptPressed: null,
          onRejectPressed: null,
        );
      },
    );
  }

  Widget _buildPendingFriendsContent() {
    if (pendingFriends.isEmpty) {
      return const Center(
          child: Text('Aucune invitation', style: AppTextStyles.bodyText1));
    }
    return ListView.builder(
      itemCount: pendingFriends.length,
      itemBuilder: (context, index) {
        final friend = pendingFriends[index];
        return FriendCard(
          friend: friend.userAsker,
          onAddPressed: null,
          buttonText: '',
          onAcceptPressed: () => _acceptFriend(friend),
          onRejectPressed: () => _rejectFriend(friend),
        );
      },
    );
  }
}
