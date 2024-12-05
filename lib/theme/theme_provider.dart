import 'package:flutter/material.dart';
import 'package:myapp/theme/app_colors.dart';
import 'package:myapp/theme/app_text_styles.dart';

class ThemeProvider {
  static final ThemeData myTheme = ThemeData(
      primaryColor: AppColors.textPrimary,
      scaffoldBackgroundColor: AppColors.dark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.textPrimary,
        secondary: AppColors.disabled,
        surface: AppColors.primary,
        onPrimary: AppColors.textPrimary,
        onSecondary: AppColors.textPrimary,
        onSurface: AppColors.textPrimary,
      ));

  static const TextTheme myTextTheme = TextTheme(
    titleLarge: AppTextStyles.headline1,
    titleMedium: AppTextStyles.headline2,
    bodyLarge: AppTextStyles.bodyText1,
    bodyMedium: AppTextStyles.bodyText2,
    bodySmall: AppTextStyles.hintText,
  );
}
