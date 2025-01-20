import 'package:flutter/material.dart';
import 'package:myapp/Components/main_frame.dart';
import 'package:myapp/Theme/app_colors.dart';
import 'package:myapp/Theme/app_text_styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainFrame(
      leftIcon: Icons.notifications_outlined,
      onLeftIconPressed: () {  },
      title: '',
      currentIndex: 0,
      onTabSelected: (int value) {  },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32.0),
              const Text(
                'Salut Username 👋',
                style: AppTextStyles.headline1,
              ),
              const SizedBox(height: 16.0),
              Container(
                height: 150,
                child: const Center(
                  child: Text(
                    'Ici map',
                    style: AppTextStyles.hintText,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Performances',
                style: AppTextStyles.headline2,
              ),
              const Text(
                'Janvier 2025',
                style: AppTextStyles.hintText,
              ),
              const SizedBox(height: 16.0),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.lightDark, // Couleur de fond
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildStatItem(
                            icon: Icons.timer_outlined,
                            value: '3h34',
                            label: 'Temps passé',
                            iconColor: AppColors.primary,
                          ),
                          Container(
                            height: 40,
                            width: 1,
                            color: Colors.grey.shade600, // Ligne de séparation
                          ),
                          _buildStatItem(
                            icon: Icons.local_fire_department_outlined,
                            value: '857',
                            label: 'Calories totales',
                            iconColor: AppColors.danger,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Container(
                      height: 150,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.lightDark, // Couleur de fond
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Ici graphique',
                          style: AppTextStyles.hintText,
                        ),
                      ),
                    ),
                  ],
                )
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Dernières actualités',
                    style: AppTextStyles.headline2,
                  ),
                  TextButton(
                    onPressed: () {  },
                    child: const Text(
                      'Voir tout',
                      style: AppTextStyles.hintText,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              const Card(
                color: AppColors.lightDark,
                child: ListTile(
                  title: Text(
                    'Ceci est une actualité',
                    style: AppTextStyles.bodyText1,
                  ),
                  subtitle: const Text(
                    'Descritpion de l\'actualité',
                    style: AppTextStyles.bodyText2,
                  ),
                  //Image de l'actualité
                  trailing: Image(image: NetworkImage('https://placehold.co/200x200.png')),
                ),
              ),
              const SizedBox(height: 2.0),
              const Card(
                color: AppColors.lightDark,
                child: ListTile(
                  title: Text(
                    'Ceci est une actualité',
                    style: AppTextStyles.bodyText1,
                  ),
                  subtitle: const Text(
                    'Descritpion de l\'actualité',
                    style: AppTextStyles.bodyText2,
                  ),
                  //Image de l'actualité
                  trailing: Image(image: NetworkImage('https://placehold.co/200x200.png')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
    required Color iconColor,
  }) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: iconColor.withOpacity(0.2),
          child: Icon(icon, color: iconColor),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}