import 'package:flutter/material.dart';
import 'package:myapp/Components/custom_dropbox.dart';
import 'package:myapp/Components/form_text_field.dart';
import 'package:myapp/Models/user_dto.dart';
import 'package:myapp/Theme/app_colors.dart';
import 'package:myapp/user_state.dart';
import 'package:provider/provider.dart';

class ProfileSetupPage extends StatefulWidget {
  const ProfileSetupPage({super.key});

  @override
  State<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {
  late UserState userState;
  final PageController _pageController = PageController();
  int _currentStep = 0;

  // Contrôleurs pour les champs de texte
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();

  // Données utilisateur
  String? _gender;
  String? _avatar;
  String? _status;

  // Options pour les champs de sélection
  final List<String> genders = UserSex.values.map((e) => e.name).toList();
  final List<String> avatars = ["Avatar 1", "Avatar 2", "Avatar 3"];
  final List<String> statuses = UserStatus.values.map((e) => e.name).toList();

  @override
  void initState() {
    super.initState();
    userState = Provider.of<UserState>(context, listen: false);
  }

  void _nextPage() {
    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Dernière étape : Envoyer les données
      _submitData();
    }
  }

  void _previousPage() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _submitData() async {
    UserDto user = userState.currentUser!;
    UserDto? updated = await userState.updateUser(UserDto(
        id: user.id,
        email: user.email,
        firstname: _firstnameController.text,
        lastname: _lastnameController.text,
        gender: UserSex.values.byName(_gender!),
        avatar: _avatar,
        status: UserStatus.values.byName(_status!)));
    if (updated != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Compte créé avec succès')),
      );
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erreur de connexion')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color dark = Color(0xFF262531);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: dark,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 12, 16, 12),
              child: Row(
                children: [
                  IconButton(
                    onPressed: _previousPage,
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: (_currentStep + 1) / 3,
                      backgroundColor: Colors.grey[800],
                      color: const Color(0xFF546EFF),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  // Étape 1 : Informations personnelles
                  _buildPersonalInfoStep(),
                  // Étape 2 : Sélection des préférences
                  _buildPreferencesStep(),
                  // Étape 3 : Confirmation
                  _buildConfirmationStep(),
                ],
              ),
            ),
            // Bouton Continuer
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _nextPage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF546EFF),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  _currentStep < 2 ? "Continuer" : "Confirmer",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalInfoStep() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.lightDark,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Icon(
                          Icons.account_circle,
                          size: 100,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "Informations personnelles",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      BLFormTextField(
                        controller: _firstnameController,
                        hintText: "Prénom",
                      ),
                      const SizedBox(height: 16),
                      BLFormTextField(
                        controller: _lastnameController,
                        hintText: "Nom",
                      ),
                    ]),
              ),
            ]));
  }

  Widget _buildPreferencesStep() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.lightDark,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Icon(
                        Icons.settings,
                        size: 100,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "Préférences",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomDropdown<String>(
                      labelText: "Genre",
                      value: _gender,
                      items: genders,
                      onChanged: (value) {
                        setState(() {
                          _gender = value;
                        });
                      },
                      itemToString: (gender) => gender,
                    ),
                    const SizedBox(height: 16),
                    CustomDropdown<String>(
                      labelText: "Avatar",
                      value: _avatar,
                      items: avatars,
                      onChanged: (value) {
                        setState(() {
                          _avatar = value;
                        });
                      },
                      itemToString: (avatar) => avatar,
                    ),
                    const SizedBox(height: 16),
                    CustomDropdown<String>(
                      labelText: "Statut",
                      value: _status,
                      items: statuses,
                      onChanged: (value) {
                        setState(() {
                          _status = value;
                        });
                      },
                      itemToString: (status) => status,
                    ),
                  ],
                ),
              )
            ]));
  }

  Widget _buildConfirmationStep() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Center(
            child: Icon(
              Icons.check_circle,
              size: 100,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 24),
          Text(
            "Tout est prêt !",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Text(
            "Prêt à commencer ton aventure.",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
