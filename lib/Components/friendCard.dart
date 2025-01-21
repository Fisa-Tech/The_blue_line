import 'package:flutter/material.dart';
import 'package:myapp/Components/button_widget.dart';
import 'package:myapp/Theme/app_colors.dart';

class FriendCard extends StatelessWidget {
  final Map<String, String> friend;
  final VoidCallback? onAddPressed;
  final String buttonText;

  const FriendCard({
    super.key,
    required this.friend,
    required this.onAddPressed,
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
              backgroundImage: NetworkImage(friend['image_url']!),
              radius: 30,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${friend['first_name']} ${friend['last_name']}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Cliquez pour ajouter',
                    style: TextStyle(color: AppColors.textPrimary),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.29, // Par exemple, 60% de la largeur de l'écran
              child: BLElevatedButton(
                onPressed: onAddPressed ?? () {}, // Passer une fonction vide si null
                text: buttonText,
                variant: ButtonVariant.primary, // Choisissez la variante souhaitée
              ),
            ),
          ],
        ),
      ),
    );
  }
}
