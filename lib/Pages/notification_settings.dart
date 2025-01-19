import 'package:flutter/material.dart';
import 'package:myapp/Components/button_widget.dart';
import 'package:myapp/Components/main_frame.dart';
import 'package:myapp/Components/setting_tile.dart';
import 'package:myapp/Components/switch.dart';
import 'package:myapp/Theme/app_colors.dart';
import 'package:myapp/Theme/app_text_styles.dart';

class NotificationSettingsPage extends StatelessWidget {
  const NotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final avatarRadius = screenWidth * 0.15; // Taille de l'avatar ajustée au mobile

    return MainFrame(
      leftIcon: Icons.notifications_outlined,
      onLeftIconPressed: () {},
      title: '',
      appBarVariant: AppBarVariant.backAndLogout,
      currentIndex: 0,
      onTabSelected: (int value) {},
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Notifications de l\'application', style: AppTextStyles.hintText),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.lightDark,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    BLSettingTile(
                      icon: Icons.settings_outlined,
                      title: 'Paramètre 1',
                      trailing: BLSwitch(value: true, onChanged: (value) {}),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    BLSettingTile(
                      icon: Icons.settings_outlined,
                      title: 'Paramètre 2',
                      trailing: BLSwitch(value: false, onChanged: (value) {}),
                    ),
                    BLSettingTile(
                      icon: Icons.settings_outlined,
                      title: 'Paramètre 3',
                      trailing: BLSwitch(value: false, onChanged: (value) {}),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Notifications des amis', style: AppTextStyles.hintText),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.lightDark,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    BLSettingTile(
                      icon: Icons.settings_outlined,
                      title: 'Paramètre 1',
                      trailing: BLSwitch(value: true, onChanged: (value) {}),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    BLSettingTile(
                      icon: Icons.settings_outlined,
                      title: 'Paramètre 2',
                      trailing: BLSwitch(value: false, onChanged: (value) {}),
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