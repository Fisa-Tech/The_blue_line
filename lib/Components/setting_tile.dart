import 'package:flutter/material.dart';
import 'package:myapp/Theme/app_colors.dart';
import 'package:myapp/Theme/app_text_styles.dart';

class BLSettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget trailing;
  final BorderRadius? borderRadius;

  const BLSettingTile({
    super.key,
    required this.icon,
    required this.title,
    required this.trailing,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {

    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: AppTextStyles.bodyText1),
      tileColor: AppColors.lightDark,
      shape: RoundedRectangleBorder(borderRadius: borderRadius ?? BorderRadius.zero),
      trailing: trailing,
    );
  }
}