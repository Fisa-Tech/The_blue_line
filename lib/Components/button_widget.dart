import 'package:flutter/material.dart';
import 'package:myapp/Theme/app_colors.dart';

class BLElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final ButtonVariant variant;

  const BLElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.variant = ButtonVariant.primary,
  });

  @override
  Widget build(BuildContext context) {
    // Récupération des dimensions de l'écran
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    // Définition des couleurs selon la variante
    final Color backgroundColor;
    final Color textColor;

    switch (variant) {
      case ButtonVariant.primary:
        backgroundColor = AppColors.primary;
        textColor = Colors.white;
        break;
      case ButtonVariant.danger:
        backgroundColor = AppColors.danger;
        textColor = Colors.white;
        break;
      case ButtonVariant.grey:
        backgroundColor = AppColors.grey;
        textColor = Colors.white;
        break;
      case ButtonVariant.custom:
        backgroundColor = Colors.blue;
        textColor = Colors.white;
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: Size(double.infinity, screenHeight * 0.055),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: screenWidth * 0.045,
        ),
      ),
    );
  }
}

// Enum pour les variantes
enum ButtonVariant { primary, danger, grey, custom }
