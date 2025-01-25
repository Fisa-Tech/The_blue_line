import 'package:flutter/material.dart';
import 'package:myapp/Theme/app_colors.dart';
import 'package:myapp/Theme/app_text_styles.dart';

enum AppBarVariant { notifAndProfile, backAndProfile, backAndLogout, backAndShare, friendsAndProfile }

class MainFrame extends StatelessWidget {
  final Widget child;
  final int currentIndex;
  final ValueChanged<int> onTabSelected;
  final String title;
  final IconData? leftIcon;
  final VoidCallback? onLeftIconPressed;
  final PreferredSizeWidget? bottom;
  final AppBarVariant appBarVariant;

  const MainFrame({
    super.key,
    required this.child,
    required this.currentIndex,
    required this.onTabSelected,
    required this.title,
    this.leftIcon,
    this.onLeftIconPressed,
    this.bottom,
    this.appBarVariant = AppBarVariant.notifAndProfile,
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
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home');
              break;
            case 1:
              Navigator.pushNamed(context, '/defis');
              break;
            case 2:
              Navigator.pushNamed(context, '/login');
              break;
            case 3:
              Navigator.pushNamed(context, '/profil');
              break;
          }
        },
        type: BottomNavigationBarType.fixed, // Style fixe
        showSelectedLabels: false, // Désactive les labels sélectionnés
        showUnselectedLabels: false, // Désactive les labels non sélectionnés
        selectedItemColor: AppColors.textPrimary, // Couleur des icônes sélectionnées
        unselectedItemColor: AppColors.textPrimary, // Couleur des icônes non sélectionnées
        items: const [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.timer),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.group),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_add),
            label: '',
          ),
        ],
      ),
    );
  }

   _buildAppBar(BuildContext context) {
    if(appBarVariant == AppBarVariant.notifAndProfile) {
      return AppBar(
        backgroundColor: AppColors.dark,
        bottom: bottom,
        leading: leftIcon != null
            ? IconButton(
                icon: Icon(leftIcon, color: Colors.white, size: 26),
                onPressed: () {
                  
                },
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
    } else if(appBarVariant == AppBarVariant.backAndProfile) {
      return AppBar(
        backgroundColor: AppColors.dark,
        bottom: bottom,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
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
    } else if(appBarVariant == AppBarVariant.backAndLogout) {
      return AppBar(
        backgroundColor: AppColors.dark,
        bottom: bottom,
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
              onPressed: (){}, 
              icon: const Icon(Icons.logout , color: AppColors.danger),
            ),
          ),
        ],
      );
    } else if(appBarVariant == AppBarVariant.backAndShare) {
      return AppBar(
        backgroundColor: AppColors.dark,
        bottom: bottom,
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
              onPressed: (){}, 
              icon: const Icon(Icons.share , color: AppColors.textPrimary),
            ),
          ),
        ],
      );
    } else if(appBarVariant == AppBarVariant.friendsAndProfile) {
      return AppBar(
        backgroundColor: AppColors.dark,
        bottom: bottom,
        leading: IconButton(
          icon: const Icon(Icons.person_add, color: Colors.white),
          onPressed: () =>  Navigator.pushNamed(context, '/add-friends'),
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
    }
  }
}