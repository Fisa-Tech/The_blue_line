import 'package:flutter/material.dart';
import 'package:myapp/Components/button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myapp/Theme/app_colors.dart';
import 'package:myapp/Theme/app_text_styles.dart';
import 'package:myapp/Components/main_frame.dart';

class BlueLinePage extends StatefulWidget {
  @override
  _BlueLinePageState createState() => _BlueLinePageState();
}

class _BlueLinePageState extends State<BlueLinePage> {
  bool _isFirstTime = true;

  @override
  void initState() {
    super.initState();
    _checkFirstTime();
  }

  Future<void> _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTimeBlueLine') ?? true;

    if (isFirstTime) {
      await prefs.setBool('isFirstTimeBlueLine', false);
    }

    setState(() {
      _isFirstTime = isFirstTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isFirstTime ? _buildIntroContent(context) : _buildMainContent();
  }

  Widget _buildIntroContent(BuildContext context) {
    return MainFrame(
      currentIndex: 4,
      title: 'Ligne Bleue',
      appBarVariant: AppBarVariant.notifAndProfile,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FractionallySizedBox(
                widthFactor: 0.75,
                child: Image(image: AssetImage('assets/img/ligne_bleue_all.png')),
              ),
              const Text(
                'Bienvenue sur la Ligne Bleue !',
                style: AppTextStyles.headline1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                'C\'est ici que tu pourras visualiser tous les parcours disponibles sur la Ligne Bleue du campus de l\'UPHF Valenciennes.',
                style: AppTextStyles.bodyText1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              BLElevatedButton(
                onPressed: () {
                  setState(() {
                    _isFirstTime = false;
                  });
                },
                text: 'Découvrir les parcours',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent() {
     return DefaultTabController(
      length: 4,  // Le nombre de tabs
      child: MainFrame(
        currentIndex: 4,
        title: 'Parcours Ligne Bleue',
        appBarVariant: AppBarVariant.notifAndProfile,
        bottom: const TabBar(
          indicatorColor: AppColors.textPrimary,
          labelColor: AppColors.textPrimary,
          unselectedLabelColor: AppColors.lightGrey,
          dividerColor: AppColors.lightGrey,
          tabs: [
            Tab(text: "Endurance"),
            Tab(text: "Force"),
            Tab(text: "Santé"),
            Tab(text: "Loisir"),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: TabBarView(
            children: [
              _buildTabView('Endurance', 'assets/img/ligne_endurance.png', 0xFF0BC6FF),
              _buildTabView('Force', 'assets/img/ligne_force.png', 0xFFF6F711),
              _buildTabView('Santé', 'assets/img/ligne_sante.png', 0xFFFF3332),
              _buildTabView('Loisir', 'assets/img/ligne_loisir.png', 0xFF434343),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildTabView(String tabName, String imagePath, int highligthColor) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(image: AssetImage(imagePath)),
        const SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: Color(highligthColor),
              shape: BoxShape.circle,
            ),
            ),
            const SizedBox(width: 8),
            Text(
            'Parcours $tabName',
            style: AppTextStyles.headline1,
            ),
          ],
        ),
      ],
    ),
  );
}