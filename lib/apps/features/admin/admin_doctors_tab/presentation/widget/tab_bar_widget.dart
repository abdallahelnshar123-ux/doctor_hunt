import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';

class TabBarWidget extends StatelessWidget {
  final bool isSelected;
  final String label;
  final int number;

  const TabBarWidget({
    super.key,
    required this.isSelected,
    required this.label,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
      label: Text(
        '$label ($number)',
        style: isSelected
            ? context.bold12.white.rubik
            : context.regular12.textSecondary.rubik,
      ),
      backgroundColor: isSelected
          ? AppColors.brandPrimary
          : AppColors.bgPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: BorderSide(
          color: isSelected ? AppColors.brandPrimary : AppColors.borderMuted,
        ),
      ),
    );
  }
}
