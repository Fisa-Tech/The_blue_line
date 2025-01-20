import 'package:flutter/material.dart';
import 'package:myapp/Theme/app_colors.dart';

class GroupCard extends StatelessWidget {
  final String groupName;
  final String groupSlogan;
  final VoidCallback onTap; // Nouvelle propriété

  const GroupCard({
    super.key,
    required this.groupName,
    required this.groupSlogan,
    required this.onTap, // Rendre onTap obligatoire
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.lightDark,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: const Icon(
          Icons.group,
          size: 40,
          color: Colors.white,
        ),
        title: Text(
          groupName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary
          ),
        ),
        subtitle: Text(
          groupSlogan,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.disabled,
          ),
        ),
        onTap: onTap, // Utiliser l'action fournie
      ),
    );
  }
}
