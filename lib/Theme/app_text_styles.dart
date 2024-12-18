import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const headline1 = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  static const headline2 = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const bodyText1 = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  static const bodyText2 = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  static const hintText = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    color: AppColors.disabled,
  );
}
