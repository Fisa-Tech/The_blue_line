import 'package:flutter/material.dart';
import 'package:myapp/Theme/app_colors.dart';

class BLFormTextField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController? controller;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final String? label;
  final Color? color;

  const BLFormTextField({
    super.key,
    required this.hintText,
    this.label,
    this.isPassword = false,
    this.controller,
    this.onSaved,
    this.validator,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.primary,
      style: const TextStyle(color: AppColors.textPrimary),
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        label: label != null ? Text(label!) : null,
        labelStyle: label != null && color != null ? TextStyle(color: color) : null,
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.disabled),
        filled: true,
        fillColor: AppColors.grey,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      onSaved: onSaved,
      validator: validator,
    );
  }
}
