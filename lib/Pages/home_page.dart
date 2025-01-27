import 'package:flutter/material.dart';
import 'package:myapp/Components/main_frame.dart';
import 'package:myapp/Theme/app_text_styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainFrame(
      leftIcon: Icons.notifications_outlined,
      onActionButtonPressed: () {},
      title: '',
      appBarVariant: AppBarVariant.notifAndProfile,
      currentIndex: 0,
      onTabSelected: (int value) {},
      child: const Center(
        child:
            Text('Welcome to the Home Page!', style: AppTextStyles.headline1),
      ),
    );
  }
}
