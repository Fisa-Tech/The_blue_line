import 'package:flutter/material.dart';
import 'package:myapp/Components/main_frame.dart';
import 'package:myapp/Theme/app_colors.dart';
import 'package:myapp/Theme/app_text_styles.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainFrame(
      appBarVariant: AppBarVariant.backAndProfile,
      title: 'Notifications',
      currentIndex: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32.0),
              Card(
                color: AppColors.lightDark,
                child: ListTile(
                  leading: const Icon(
                    Icons.notifications_none_outlined,
                    color: AppColors.primary,
                  ),
                  title: const Text(
                    'Ceci est une notification',
                    style: AppTextStyles.bodyText1,
                  ),
                  subtitle: const Text(
                    'Ligne 2 de la notification',
                    style: AppTextStyles.bodyText2,
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.close, color: AppColors.textPrimary),
                    onPressed: () {  },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}