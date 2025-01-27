import 'package:flutter/material.dart';
import 'package:myapp/Theme/app_colors.dart';
import 'package:myapp/Theme/app_text_styles.dart';

enum AppBarVariant { notifAndProfile, backAndProfile, backAndLogout }

class MainFrame extends StatelessWidget {
  final Widget child;
  final int currentIndex;
  final ValueChanged<int> onTabSelected;
  final String title;
  final IconData? leftIcon;
  final VoidCallback? onActionButtonPressed;
  final AppBarVariant appBarVariant;

  const MainFrame({
    super.key,
    required this.child,
    required this.currentIndex,
    required this.onTabSelected,
    required this.title,
    required this.appBarVariant,
    this.leftIcon,
    this.onActionButtonPressed,
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
        onTap: onTabSelected,
        type: BottomNavigationBarType.fixed, // Force un style fixe
        showSelectedLabels: false, // Désactive les labels sélectionnés
        showUnselectedLabels: false, // Désactive les labels non sélectionnés
        selectedItemColor:
            AppColors.textPrimary, // Couleur des icônes sélectionnées
        unselectedItemColor:
            AppColors.textPrimary, // Couleur des icônes non sélectionnées
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '',
          ),
        ],
      ),
    );
  }

  _buildAppBar(BuildContext context) {
    if (appBarVariant == AppBarVariant.notifAndProfile) {
      return AppBar(
        backgroundColor: AppColors.dark,
        leading: leftIcon != null
            ? IconButton(
                icon: Icon(leftIcon, color: Colors.white, size: 26),
                onPressed: onActionButtonPressed,
              )
            : Container(),
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
              child: const CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://www.gravatar.com/avatar',
                ),
              ),
            ),
          ),
        ],
      );
    } else if (appBarVariant == AppBarVariant.backAndProfile) {
      return AppBar(
        backgroundColor: AppColors.dark,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
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
              child: const CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://www.gravatar.com/avatar',
                ),
              ),
            ),
          ),
        ],
      );
    } else if (appBarVariant == AppBarVariant.backAndLogout) {
      return AppBar(
        backgroundColor: AppColors.dark,
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
    }
  }
}
