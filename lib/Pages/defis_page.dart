import 'package:flutter/material.dart';
import 'package:myapp/Components/main_frame.dart';
import 'package:myapp/Theme/app_colors.dart';
import 'package:myapp/Theme/app_text_styles.dart';

class DefisPage extends StatelessWidget {
  const DefisPage({super.key});

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 3,  // Le nombre de tabs
      child: MainFrame(
        leftIcon: Icons.notifications_outlined,
        onLeftIconPressed: () {},
        title: 'Défis',
        currentIndex: 0,
        onTabSelected: (int value) {},
        bottom: const TabBar(
          indicatorColor: AppColors.textPrimary,
          labelColor: AppColors.textPrimary,
          unselectedLabelColor: AppColors.lightGrey,
          dividerColor: AppColors.lightGrey,
          tabs: [
            Tab(
              text: "A relever",
            ),
            Tab(
              text: "En cours",
            ),
            Tab(
              text: "Terminés",
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: TabBarView(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    // Liste de cards avec une icone en leading, un titre, une description (la card est clickable)
                    Card(
                      color: AppColors.lightDark,
                      child: ListTile(
                        leading: const Icon(Icons.directions_run, color: AppColors.textPrimary),
                        title: const Text(
                          'Course à pied',
                          style: AppTextStyles.bodyText1,
                        ),
                        subtitle: const Text(
                          'Fais une course de 5km',
                          style: AppTextStyles.bodyText2,
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/defis_details');
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    // Liste de cards avec une icone en leading, un titre, une description (la card est clickable)
                    Card(
                      color: AppColors.lightDark,
                      child: ListTile(
                        leading: const Icon(Icons.directions_run, color: AppColors.textPrimary),
                        title: const Text(
                          'Course à pied',
                          style: AppTextStyles.bodyText1,
                        ),
                        subtitle: const Text(
                          'Fais une course de 5km',
                          style: AppTextStyles.bodyText2,
                        ),
                        onTap: () {
                          // Ouvrir la page du défi
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    // Liste de cards avec une icone en leading, un titre, une description (la card est clickable)
                    Card(
                      color: AppColors.lightDark,
                      child: ListTile(
                        leading: const Icon(Icons.directions_run, color: AppColors.textPrimary),
                        title: const Text(
                          'Course à pied',
                          style: AppTextStyles.bodyText1,
                        ),
                        subtitle: const Text(
                          'Fais une course de 5km',
                          style: AppTextStyles.bodyText2,
                        ),
                        onTap: () {
                          // Ouvrir la page du défi
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}