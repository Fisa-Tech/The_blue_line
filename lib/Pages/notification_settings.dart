import 'package:flutter/material.dart';
import 'package:myapp/Components/button_widget.dart';
import 'package:myapp/Components/main_frame.dart';
import 'package:myapp/Components/setting_tile.dart';
import 'package:myapp/Components/switch.dart';
import 'package:myapp/Theme/app_colors.dart';
import 'package:myapp/Theme/app_text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  // Variables pour stocker les états des switches
  bool notifApp1 = false;
  bool notifApp2 = false;
  bool notifApp3 = false;
  bool notifAmis1 = false;
  bool notifAmis2 = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences(); // Charger les préférences au démarrage
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      notifApp1 = prefs.getBool('notifApp1') ?? false;
      notifApp2 = prefs.getBool('notifApp2') ?? false;
      notifApp3 = prefs.getBool('notifApp3') ?? false;
      notifAmis1 = prefs.getBool('notifAmis1') ?? false;
      notifAmis2 = prefs.getBool('notifAmis2') ?? false;
    });
  }

  Future<void> _savePreference(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return MainFrame(
      leftIcon: Icons.notifications_outlined,
      onActionButtonPressed: () {},
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
              // Notifications de l'application
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Notifications de l\'application',
                    style: AppTextStyles.hintText),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.lightDark,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    BLSettingTile(
                      icon: Icons.settings_outlined,
                      title: 'Notification app 1',
                      trailing: BLSwitch(
                        value: notifApp1,
                        onChanged: (value) {
                          setState(() {
                            notifApp1 = value;
                          });
                          _savePreference('notifApp1', value);
                        },
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    BLSettingTile(
                      icon: Icons.settings_outlined,
                      title: 'Notification app 2',
                      trailing: BLSwitch(
                        value: notifApp2,
                        onChanged: (value) {
                          setState(() {
                            notifApp2 = value;
                          });
                          _savePreference('notifApp2', value);
                        },
                      ),
                    ),
                    BLSettingTile(
                      icon: Icons.settings_outlined,
                      title: 'Notification app 3',
                      trailing: BLSwitch(
                        value: notifApp3,
                        onChanged: (value) {
                          setState(() {
                            notifApp3 = value;
                          });
                          _savePreference('notifApp3', value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Notifications des amis
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Notifications des amis',
                    style: AppTextStyles.hintText),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.lightDark,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    BLSettingTile(
                      icon: Icons.settings_outlined,
                      title: 'Notification amis 1',
                      trailing: BLSwitch(
                        value: notifAmis1,
                        onChanged: (value) {
                          setState(() {
                            notifAmis1 = value;
                          });
                          _savePreference('notifAmis1', value);
                        },
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    BLSettingTile(
                      icon: Icons.settings_outlined,
                      title: 'Notification amis 2',
                      trailing: BLSwitch(
                        value: notifAmis2,
                        onChanged: (value) {
                          setState(() {
                            notifAmis2 = value;
                          });
                          _savePreference('notifAmis2', value);
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
