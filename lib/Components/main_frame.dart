import 'package:flutter/material.dart';
import 'package:myapp/Theme/app_colors.dart';
import 'package:myapp/Theme/app_text_styles.dart';

enum AppBarVariant { notifAndProfile, backAndProfile, backAndLogout, backAndShare }

class MainFrame extends StatelessWidget {
  final Widget child;
  final int currentIndex;
  final String title;
  final PreferredSizeWidget? bottom;
  final AppBarVariant appBarVariant;

  const MainFrame({
    super.key,
    required this.child,
    required this.currentIndex,
    required this.title,
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
          if (index != currentIndex) { // Vérifie si l'index est différent avant de naviguer
            switch (index) {
              case 0:
                Navigator.pushNamed(context, '/home');
                break;
              case 1:
                Navigator.pushNamed(context, '/challenges');
                break;
              case 2:
                Navigator.pushNamed(context, '/news');
                break;
              case 3:
                Navigator.pushNamed(context, '/profile');
                break;
            }
          }
        },
        type: BottomNavigationBarType.fixed, // Style fixe
        showSelectedLabels: false, // Désactive les labels sélectionnés
        showUnselectedLabels: false, // Désactive les labels non sélectionnés
        selectedItemColor: AppColors.primary, // Couleur des icônes sélectionnées
        unselectedItemColor: AppColors.textPrimary, // Couleur des icônes non sélectionnées
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: '',
          ),
        ],
      ),
    );
  }

   _buildAppBar(BuildContext context) {
    if(appBarVariant == AppBarVariant.notifAndProfile) {
      return AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: AppColors.dark,
        bottom: bottom,
        elevation: 0, // Remove shadow
        leading: IconButton(
                icon: Icon(Icons.notifications_none_outlined, color: Colors.white, size: 26),
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
        scrolledUnderElevation: 0.0,
        backgroundColor: AppColors.dark,
        bottom: bottom,
        elevation: 0, // Remove shadow
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
              onPressed: (){}, 
              icon: const Icon(Icons.logout , color: AppColors.danger),
            ),
          ),
        ],
      );
    } else if(appBarVariant == AppBarVariant.backAndShare) {
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
              onPressed: (){}, 
              icon: const Icon(Icons.share , color: AppColors.textPrimary),
            ),
          ),
        ],
      );
    }
  }
}
