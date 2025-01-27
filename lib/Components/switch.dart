import 'package:flutter/material.dart';
import 'package:myapp/Theme/app_colors.dart';

class BLSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const BLSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {

    return Switch(
      value: value,
      activeColor: Colors.white,
      activeTrackColor: AppColors.primary,
      inactiveTrackColor: AppColors.dark,
      inactiveThumbColor: AppColors.lightGrey,
      trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      onChanged: onChanged,
    );
  }
}