import 'package:flutter/material.dart';
import 'package:myapp/Components/custom_dropbox.dart';
import 'package:myapp/Models/user_dto.dart';
import 'package:myapp/Theme/app_colors.dart';
import 'package:myapp/user_state.dart';
import 'package:provider/provider.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  // Contrôleurs pour les champs modifiables
  final TextEditingController _emailController = TextEditingController();

  // Données utilisateur
  late UserState userState;
  late UserDto user;

  String? _avatar;
  String? _status;

  // Options pour les champs modifiables
  final List<String> avatars = ["Avatar 1", "Avatar 2", "Avatar 3"];
  final List<String> statuses = UserStatus.values.map((e) => e.name).toList();

  @override
  void initState() {
    super.initState();
    userState = Provider.of<UserState>(context, listen: false);
    user = userState.currentUser!;
    _emailController.text = user.email;
    _avatar = user.avatar;
    _status = user.status!.name;
  }

  Future<void> _submitData() async {
    UserDto updatedUser = UserDto(
      id: user.id,
      email: _emailController.text,
      firstname: user.firstname,
      lastname: user.lastname,
      gender: user.gender,
      avatar: _avatar,
      status: UserStatus.values.byName(_status!),
    );

    UserDto? updated = await userState.updateUser(updatedUser);

    if (updated != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profil mis à jour avec succès')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erreur lors de la mise à jour')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color dark = Color(0xFF262531);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: dark,
        foregroundColor: Colors.white,
        title: const Text("Modifier le profil"),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: dark,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              _buildReadonlyField("Prénom", user.firstname!),
              const SizedBox(height: 16),
              _buildReadonlyField("Nom", user.lastname!),
              const SizedBox(height: 16),
              _buildReadonlyField("Genre", user.gender!.name),
              const SizedBox(height: 16),
              _buildEditableField(
                labelText: "Email",
                controller: _emailController,
              ),
              const SizedBox(height: 16),
              const Text(
                "Status",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 8),
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
              const SizedBox(height: 16),
              const Text(
                "Avatar",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 8),
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
              ElevatedButton(
                onPressed: _submitData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF546EFF),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Enregistrer",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReadonlyField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.lightDark,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            value,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildEditableField({
    required String labelText,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.grey,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
