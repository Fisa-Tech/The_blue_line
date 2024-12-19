import 'package:flutter/material.dart';
import 'package:myapp/Theme/app_colors.dart';
import 'package:myapp/Theme/app_text_styles.dart';

class MainFrame extends StatelessWidget {
  final Widget child;
  final int currentIndex;
  final ValueChanged<int> onTabSelected;
  final String title;
  final IconData? leftIcon;
  final VoidCallback? onLeftIconPressed;

  const MainFrame({
    super.key,
    required this.child,
    required this.currentIndex,
    required this.onTabSelected,
    required this.title,
    this.leftIcon,
    this.onLeftIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark,
      appBar: AppBar(
        backgroundColor: AppColors.dark,
        leading: leftIcon != null
          ? IconButton(
              icon: Icon(leftIcon, color: Colors.white, size: 26),
              onPressed: onLeftIconPressed,
            )
          : Container(),
        title: Text(
          title,
          style: AppTextStyles.headline2,
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://www.gravatar.com/avatar'
              ),
            ),
          ),
        ],
      ),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.lightDark,
        currentIndex: currentIndex,
        onTap: onTabSelected,
        type: BottomNavigationBarType.fixed, // Force un style fixe
        showSelectedLabels: false, // Désactive les labels sélectionnés
        showUnselectedLabels: false, // Désactive les labels non sélectionnés
        selectedItemColor: AppColors.textPrimary, // Couleur des icônes sélectionnées
        unselectedItemColor: AppColors.textPrimary, // Couleur des icônes non sélectionnées
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
}
