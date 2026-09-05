import 'package:flutter/material.dart';

import '../../../../../generated/style_atoms.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';

class SpecialtyDropdownWidget extends StatelessWidget {
  final TextEditingController controller;

  const SpecialtyDropdownWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return DropdownMenuFormField(
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(AppColors.bgPrimary),
        maximumSize: WidgetStatePropertyAll(Size.fromWidth(context.width - 40)),
      ),
      showTrailingIcon: true,
      selectedTrailingIcon: Icon(Icons.keyboard_arrow_up_rounded),
      dropdownMenuEntries: Specialties.values
          .map(
            (specialty) =>
                DropdownMenuEntry(value: specialty, label: specialty.name),
          )
          .toList(),
      width: double.infinity,
      trailingIcon: Icon(Icons.keyboard_arrow_down_rounded),

      controller: controller,
      enableSearch: true,
      decorationBuilder: (context, controller) => InputDecoration(
        filled: true,
        hintStyle: context.light14.textSecondary.rubik,
        hintText: 'Select specialty',
        enabled: true,

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.borderDefault, width: 2),
        ),
        fillColor: AppColors.bgPrimary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.borderDefault, width: 2),
        ),
      ),
    );
  }
}

enum Specialties {
  allergists,
  anesthesiologists,
  cardiologists,
  rectalSurgeons,
  dermatologists,
}
