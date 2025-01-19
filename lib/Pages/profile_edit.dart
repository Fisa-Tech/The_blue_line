import 'package:flutter/material.dart';
import 'package:myapp/Components/button_widget.dart';
import 'package:myapp/Components/form_text_field.dart';
import 'package:myapp/Components/main_frame.dart';
import 'package:myapp/Theme/app_colors.dart';
import 'package:myapp/Theme/app_text_styles.dart';

class ProfileEditPage extends StatelessWidget {
  const ProfileEditPage({super.key});

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
              // Section Profil
              CircleAvatar(
                radius: avatarRadius,
                backgroundImage: const NetworkImage(
                  'https://www.gravatar.com/avatar?s=2048',
                ),
              ),
              const SizedBox(height: 16),
              const Text('Changer d\'avatar', style: AppTextStyles.hintText),
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
                    const BLFormTextField(hintText: "example@gmail.com", label: "Email"),
                    const BLFormTextField(hintText: "Doe", label: "Nom"),
                    const BLFormTextField(hintText: "John", label: "Prénom"),
                    const BLFormTextField(hintText: "", label: "Genre"),
                    const BLFormTextField(hintText: "", label: "Statut"),
                    const SizedBox(height: 32),
                    BLElevatedButton(onPressed: () {}, text: "Enregistrer"),
                    BLElevatedButton(onPressed: () {}, text: "Annuler", variant: ButtonVariant.grey),
                    const SizedBox(height: 16),
                    BLElevatedButton(onPressed: () {
                      Navigator.pushNamed(context, '/settings/edit_password');
                    }, text: "Changer de mot de passe", variant: ButtonVariant.grey),
                    BLElevatedButton(onPressed: () {}, text: "Supprimer mon compte", variant: ButtonVariant.danger),
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