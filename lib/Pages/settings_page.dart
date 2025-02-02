import 'package:avatar_maker/avatar_maker.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Components/button_widget.dart';
import 'package:myapp/Components/main_frame.dart';
import 'package:myapp/Components/setting_tile.dart';
import 'package:myapp/Components/switch.dart';
import 'package:myapp/Theme/app_colors.dart';
import 'package:myapp/Theme/app_text_styles.dart';
import 'package:myapp/user_state.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Services/strava_service.dart';

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
  bool isStravaConnected = false;

  @override
  void initState() {
    super.initState();
    userState = Provider.of<UserState>(context, listen: false);
    _loadParams();
    _checkStravaConnection();
  }

  Future<void> _checkStravaConnection() async {
    final connected = await StravaService().hasSavedToken();
    setState(() {
      isStravaConnected = connected;
    });
  }

  Future<void> _connectOrDisconnectStrava() async {
    if (!isStravaConnected) {
      final result = await StravaService().connectToStrava();
      if (result) {
        setState(() => isStravaConnected = true);
      }
    } else {
      await StravaService().disconnectFromStrava();
      setState(() => isStravaConnected = false);
    }
  }

  Future<void> _loadParams() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      switchValue1 = prefs.getBool('param1') ?? false;
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
    final avatarRadius = screenWidth * 0.15;

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
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/avatar');
                },
                child: AvatarMakerAvatar(
                  radius: avatarRadius,
                  backgroundColor: AppColors.lightDark,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                  '${userState.currentUser?.firstname ?? 'Prénom inconnu'} ${userState.currentUser?.lastname ?? 'Nom inconnu'}',
                  style: AppTextStyles.headline1),
              Text(userState.currentUser?.email ?? 'Email inconnu', style: AppTextStyles.hintText),
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
                      title: 'Convertir en Mile',
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
                      title: 'Afficher l\'altitude',
                      trailing: BLSwitch(
                        value: true,
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
                      title: 'Thème clair',
                      trailing: BLSwitch(
                        value: true,
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
                    BLSettingTile(
                      icon: Icons.directions_run,
                      title: 'Synchronisation Strava',
                      trailing: ElevatedButton(
                        onPressed: _connectOrDisconnectStrava,
                        child: Text(
                          isStravaConnected ? 'Se déconnecter' : 'Se connecter',
                        ),
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
