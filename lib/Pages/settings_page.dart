import 'package:flutter/material.dart';
import 'package:myapp/Components/button_widget.dart';
import 'package:myapp/Components/main_frame.dart';
import 'package:myapp/Components/setting_tile.dart';
import 'package:myapp/Components/switch.dart';
import 'package:myapp/Theme/app_colors.dart';
import 'package:myapp/Theme/app_text_styles.dart';
import 'package:myapp/user_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late UserState userState;
  bool switchValue1 = false;
  bool switchValue2 = false;
  bool switchValue3 = false;

  @override
  void initState() {
    super.initState();
    userState = Provider.of<UserState>(context, listen: false);
    _loadParams(); // Charger les valeurs des switches au démarrage
  }

  Future<void> _loadParams() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      switchValue1 = prefs.getBool('param1') ?? false; // Par défaut : false
      switchValue2 = prefs.getBool('param2') ?? false;
      switchValue3 = prefs.getBool('param3') ?? false;
    });
  }

  Future<void> _saveParam(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final avatarRadius =
        screenWidth * 0.15; // Taille de l'avatar ajustée au mobile

    return MainFrame(
      leftIcon: Icons.notifications_outlined,
      onActionButtonPressed: () {
        userState.logout();
        Navigator.pushNamed(context, '/welcome');
      },
      title: '',
      appBarVariant: AppBarVariant.backAndLogout,
      currentIndex: 0,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Section Profil
              CircleAvatar(
                radius: avatarRadius,
                backgroundImage: const NetworkImage(
                  'https://www.gravatar.com/avatar?s=2048',
                ),
              ),
              const SizedBox(height: 16),
              Text(
                  '${userState.currentUser!.firstname!} ${userState.currentUser!.lastname!}',
                  style: AppTextStyles.headline1),
              Text(userState.currentUser!.email, style: AppTextStyles.hintText),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: screenWidth * 0.5,
                  ),
                  child: BLElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/settings/profile_edit');
                    },
                    text: 'Modifier le profil',
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Section Paramètres
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Paramètres', style: AppTextStyles.hintText),
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
                      trailing: BLSwitch(
                        value: switchValue1,
                        onChanged: (value) {
                          setState(() {
                            switchValue1 = value;
                          });
                          _saveParam('param1', value);
                        },
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    BLSettingTile(
                      icon: Icons.settings_outlined,
                      title: 'Paramètre 2',
                      trailing: BLSwitch(
                        value: switchValue2,
                        onChanged: (value) {
                          setState(() {
                            switchValue2 = value;
                          });
                          _saveParam('param2', value);
                        },
                      ),
                    ),
                    BLSettingTile(
                      icon: Icons.settings_outlined,
                      title: 'Paramètre 3',
                      trailing: BLSwitch(
                        value: switchValue3,
                        onChanged: (value) {
                          setState(() {
                            switchValue3 = value;
                          });
                          _saveParam('param3', value);
                        },
                      ),
                    ),
                    BLSettingTile(
                      icon: Icons.notifications_outlined,
                      title: 'Notifications',
                      trailing: IconButton(
                        icon: const Icon(Icons.arrow_forward,
                            color: Colors.white),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, '/settings/notification_settings');
                        },
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
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
