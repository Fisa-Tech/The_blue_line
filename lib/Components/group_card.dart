import 'package:flutter/material.dart';
import 'package:myapp/Components/button_widget.dart';
import 'package:myapp/Theme/app_colors.dart';

class GroupCard extends StatefulWidget {
  final String groupName;
  final String groupSlogan;
  final VoidCallback onTap;

  const GroupCard({
    super.key,
    required this.groupName,
    required this.groupSlogan,
    required this.onTap,
  });

  @override
  State<GroupCard> createState() => _GroupCardState();
}

class _GroupCardState extends State<GroupCard> {
  bool isIntegrated = false;

  void toggleIntegration() {
    setState(() {
      isIntegrated = !isIntegrated;
    });
  }

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
          widget.groupName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        subtitle: Text(
          widget.groupSlogan,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.disabled,
          ),
        ),
        onTap: isIntegrated
            ? widget.onTap
            : null, // Activer onTap seulement si intégré
        trailing: !isIntegrated
            ? IconButton(
                icon:
                    const Icon(Icons.login_outlined, color: AppColors.primary),
                onPressed: toggleIntegration,
              )
            : null,
      ),
    );
  }
}
