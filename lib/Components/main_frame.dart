import 'package:avatar_maker/avatar_maker.dart';
import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:fluttermoji/fluttermojiController.dart';
import 'package:fluttermoji/fluttermojiSaveWidget.dart';
import 'package:myapp/Models/user_dto.dart';
import 'package:myapp/Pages/avatar_customing_page.dart';
import 'package:myapp/Services/user_service.dart';
import 'package:myapp/Theme/app_colors.dart';
import 'package:myapp/Theme/app_text_styles.dart';
import 'package:myapp/user_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';


enum AppBarVariant {
  notifAndProfile,
  backAndProfile,
  backAndLogout,
  backAndShare,
  backAndSave,
}

class MainFrame extends StatelessWidget {
  final Widget child;
  final int currentIndex;
  final String title;
  final PreferredSizeWidget? bottom;
  final AppBarVariant appBarVariant;
  final IconData? leftIcon;
  final VoidCallback? onActionButtonPressed;

  const MainFrame({
    super.key,
    required this.child,
    required this.currentIndex,
    required this.title,
    required this.appBarVariant,
    this.leftIcon,
    this.onActionButtonPressed,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark,
      appBar: _buildAppBar(context),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.lightDark,
        currentIndex: currentIndex,
        onTap: (index) {
          if (index != currentIndex) {
            // Vérifie si l'index est différent avant de naviguer
            switch (index) {
              case 0:
                Navigator.pushNamed(context, '/home');
                break;
              case 1:
                Navigator.pushNamed(context, '/defis');
                break;
              case 2:
                Navigator.pushNamed(context, '/news');
                break;
              case 3:
                Navigator.pushNamed(context, '/friends');
                break;
              case 4:
                Navigator.pushNamed(context, '/blueline');
                break;
            }
          }
        },
        type: BottomNavigationBarType.fixed, // Style fixe
        showSelectedLabels: false, // Désactive les labels sélectionnés
        showUnselectedLabels: false, // Désactive les labels non sélectionnés
        selectedItemColor:
            AppColors.primary, // Couleur des icônes sélectionnées
        unselectedItemColor:
            AppColors.textPrimary, // Couleur des icônes non sélectionnées
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: 'Défis',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'Actualités',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Amis',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Ligne Bleue',
          ),
        ],
      ),
    );
  }

  _buildAppBar(BuildContext context) {
    if (appBarVariant == AppBarVariant.notifAndProfile) {
      return AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: AppColors.dark,
        bottom: bottom,
        elevation: 0, // Remove shadow
        leading: IconButton(
          icon: const Icon(Icons.notifications_none_outlined,
              color: Colors.white, size: 26),
          onPressed: () {
            Navigator.pushNamed(context, '/notifications');
          },
        ),
        title: Text(
          title,
          style: AppTextStyles.headline2,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
              child: AvatarMakerAvatar(
                radius: 20,
                backgroundColor: AppColors.lightDark,
              ),
            ),
          ),
        ],
      );
    } else if (appBarVariant == AppBarVariant.backAndProfile) {
      return AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: AppColors.dark,
        bottom: bottom,
        elevation: 0, // Remove shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded,
              color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          title,
          style: AppTextStyles.headline2,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
              child: AvatarMakerAvatar(
                radius: 20,
                backgroundColor: AppColors.lightDark,
              ),
            ),
          ),
        ],
      );
    } else if (appBarVariant == AppBarVariant.backAndLogout) {
      return AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: AppColors.dark,
        bottom: bottom,
        elevation: 0, // Remove shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          title,
          style: AppTextStyles.headline2,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: onActionButtonPressed,
              icon: const Icon(Icons.logout, color: AppColors.danger),
            ),
          ),
        ],
      );
    } else if (appBarVariant == AppBarVariant.backAndShare) {
      return AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: AppColors.dark,
        bottom: bottom,
        elevation: 0, // Remove shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          title,
          style: AppTextStyles.headline2,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.share, color: AppColors.textPrimary),
            ),
          ),
        ],
      );
    } else if (appBarVariant == AppBarVariant.backAndSave) {
      return AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: AppColors.dark,
        bottom: bottom,
        elevation: 0, // Remove shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          title,
          style: AppTextStyles.headline2,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: AvatarMakerSaveWidget(
              theme: AvatarMakerThemeData(
                iconColor: AppColors.textPrimary
              ),
              onTap: () {
                AvatarMakerController.getJsonOptions().then((value) {
                  UserState userState = Provider.of<UserState>(context, listen: false);
                  UserDto user = userState.currentUser!;
                  UserDto updatedUser = UserDto(
                    id: user.id,
                    email: user.email,
                    firstname: user.firstname,
                    lastname: user.lastname,
                    gender: user.gender,
                    avatar: value,
                    status: user.status,
                  );
                  userState.updateUser(updatedUser).then((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Avatar mis à jour avec succès')),
                    );
                    Navigator.pop(context);
                  }).catchError((error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Erreur lors de la mise à jour')),
                    );
                  });
                }).catchError((error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Erreur lors de l\'encodage de l\'avatar')),
                  );
                });
              }
          ),
          ),
        ],
      );
    }
  }
}
