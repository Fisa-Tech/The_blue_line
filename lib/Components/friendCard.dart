import 'package:flutter/material.dart';
import 'package:myapp/Components/button_widget.dart';
import 'package:myapp/Models/user_dto.dart';
import 'package:myapp/Theme/app_colors.dart';

class FriendCard extends StatelessWidget {
  final UserDto friend;
  final VoidCallback? onAddPressed;
  final VoidCallback? onAcceptPressed;
  final VoidCallback? onRejectPressed;
  final String buttonText;

  const FriendCard({
    super.key,
    required this.friend,
    required this.onAddPressed,
    required this.onAcceptPressed,
    required this.onRejectPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.lightDark,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey,
              child: Text(
                friend.firstname![0].toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${friend.firstname} ${friend.lastname}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    friend.status?.name ?? '',
                    style: const TextStyle(color: AppColors.disabled),
                  ),
                ],
              ),
            ),
            if (onAcceptPressed != null && onRejectPressed != null) ...[
              IconButton(
                icon: const Icon(Icons.check, color: Colors.green),
                onPressed: onAcceptPressed,
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.red),
                onPressed: onRejectPressed,
              ),
            ] else
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: onAddPressed,
              ),
          ],
        ),
      ),
    );
  }
}
