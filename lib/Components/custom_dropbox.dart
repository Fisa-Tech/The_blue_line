import 'package:flutter/material.dart';
import 'package:myapp/Theme/app_colors.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String labelText;
  final T? value;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  final String Function(T)
      itemToString; // Convertit l'item en chaîne pour l'affichage
  final Color fillColor;
  final TextStyle? style;

  const CustomDropdown({
    super.key,
    required this.labelText,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.itemToString,
    this.fillColor = AppColors.grey, // Couleur par défaut
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(
            itemToString(item),
            style: style ?? const TextStyle(color: Colors.white),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      dropdownColor: fillColor,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: fillColor,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
