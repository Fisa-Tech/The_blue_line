import 'package:flutter/material.dart';
import 'package:myapp/Components/button_widget.dart';
import 'package:myapp/Components/form_text_field.dart';
import 'package:myapp/Components/main_frame.dart';
import 'package:myapp/Theme/app_colors.dart';
import 'package:myapp/Theme/app_text_styles.dart';
import 'package:myapp/Components/dropdown_button.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  // Profil avec valeurs possibles nulles
  final profilJson = {
    // 'id': "1",
    // 'firstname': "John",
    // 'lastname': "Doe",
    // 'email': "example@gmail.com",
    // 'sex': "Homme",
    // 'avatar': "https://www.gravatar.com/avatar?s=2048",
    // 'status': "Actif",
  };

  late TextEditingController emailController;
  late TextEditingController lastnameController;
  late TextEditingController firstnameController;
  late TextEditingController statusController;

  // Variables pour DropdownButton
  String? selectedSex;
  String? selectedStatus;

  @override
  void initState() {
    super.initState();

    // Initialisation avec des valeurs par défaut si profilJson est vide ou contient des nulls
    emailController = TextEditingController(text: profilJson['email'] ?? "");
    lastnameController =
        TextEditingController(text: profilJson['lastname'] ?? "");
    firstnameController =
        TextEditingController(text: profilJson['firstname'] ?? "");
    statusController = TextEditingController(text: profilJson['status'] ?? "");
    selectedSex = profilJson['sex'];
    selectedStatus = profilJson['status'];
  }

  @override
  void dispose() {
    // Nettoyage des TextEditingController
    emailController.dispose();
    lastnameController.dispose();
    firstnameController.dispose();
    statusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final avatarRadius =
        screenWidth * 0.15; // Taille de l'avatar ajustée au mobile

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
                backgroundImage: NetworkImage(profilJson['avatar'] ??
                    'https://www.gravatar.com/avatar?s=2048'), // Valeur par défaut si null
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
                    BLFormTextField(
                      color: Colors.white,
                      controller: emailController,
                      hintText: "example@gmail.com",
                      label: "Email",
                    ),
                    const SizedBox(height: 10),
                    BLFormTextField(
                      color: Colors.white,
                      controller: lastnameController,
                      hintText: "Doe",
                      label: "Nom",
                    ),
                    const SizedBox(height: 10),
                    BLFormTextField(
                      color: Colors.white,
                      controller: firstnameController,
                      hintText: "John",
                      label: "Prénom",
                    ),
                    const SizedBox(height: 10),
                    // Genre Dropdown
                    BLDropdownButton<String>(
                      items: [
                        DropdownMenuItem(value: 'MALE', child: Text('Homme')),
                        DropdownMenuItem(value: 'FEMALE', child: Text('Femme')),
                        DropdownMenuItem(value: 'OTHER', child: Text('Autre')),
                      ],
                      hintText: "Sélectionner un genre",
                      value: selectedSex,
                      onChanged: (value) {
                        setState(() {
                          selectedSex = value;
                        });
                      },
                      label: "Genre",
                      color: Colors.white,
                    ),
                    const SizedBox(height: 10),
                    // Statut Dropdown
                    BLDropdownButton<String>(
                      items: [
                        DropdownMenuItem(value: 'LYCEE', child: Text('Lycée')),
                        DropdownMenuItem(
                            value: 'COLLEGE', child: Text('Collège')),
                        DropdownMenuItem(
                            value: 'ETUDIANT', child: Text('Étudiant')),
                        DropdownMenuItem(
                            value: 'PERSONNEL', child: Text('Personnel')),
                        DropdownMenuItem(value: 'AUTRES', child: Text('Autre')),
                      ],
                      hintText: "Sélectionner un statut",
                      value: selectedStatus,
                      onChanged: (value) {
                        setState(() {
                          selectedStatus = value;
                        });
                      },
                      label: "Statut",
                      color: Colors.white,
                    ),
                    const SizedBox(height: 32),
                    BLElevatedButton(
                      onPressed: () {
                        // Logique pour enregistrer les modifications
                        print("Enregistrer les modifications :");
                        print("Email : ${emailController.text}");
                        print("Nom : ${lastnameController.text}");
                        print("Prénom : ${firstnameController.text}");
                        print("Genre : ${selectedSex}");
                        print("Statut : ${statusController.text}");
                      },
                      text: "Enregistrer",
                    ),
                    BLElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Retour sans enregistrer
                      },
                      text: "Annuler",
                      variant: ButtonVariant.grey,
                    ),
                    const SizedBox(height: 16),
                    BLElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/settings/edit_password');
                      },
                      text: "Changer de mot de passe",
                      variant: ButtonVariant.grey,
                    ),
                    BLElevatedButton(
                      onPressed: () {
                        // Logique pour supprimer le compte
                        print("Demande de suppression du compte.");
                      },
                      text: "Supprimer mon compte",
                      variant: ButtonVariant.danger,
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
