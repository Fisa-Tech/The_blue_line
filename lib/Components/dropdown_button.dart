import 'package:flutter/material.dart';
import 'package:myapp/Theme/app_colors.dart';

class BLDropdownButton<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final String hintText;
  final Function(T?)? onChanged;
  final String? label;
  final Color? color;

  const BLDropdownButton({
    super.key,
    required this.items,
    required this.hintText,
    this.value,
    this.onChanged,
    this.label,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: TextStyle(
              color: color ?? AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            color: AppColors.grey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              isExpanded: true,
              value: value,
              items: items,
              onChanged: onChanged,
              dropdownColor: AppColors.grey,
              hint: Text(
                hintText,
                style: TextStyle(color: AppColors.disabled),
              ),
              style: const TextStyle(color: AppColors.textPrimary),
              icon: const Icon(
                Icons.arrow_drop_down,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
