import 'package:doctor_hunt/apps/core/utils/validators.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../core/data/models/doctor/doctor.dart';
import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/theme/app_colors.dart';

class SpecialtyDropdownWidget extends StatelessWidget {
  final ValueChanged<Specialty> selectedSpecialty;

  final Specialty? initialSelection;

  const SpecialtyDropdownWidget({
    super.key,
    required this.selectedSpecialty,
    this.initialSelection,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenuFormField(
      onSelected: (value) => selectedSpecialty(value!),
      initialSelection: initialSelection,
      validator: (value) => Validators.required(value?.name),
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(AppColors.bgPrimary),
        maximumSize: WidgetStatePropertyAll(Size.fromWidth(context.width - 40)),
      ),
      showTrailingIcon: true,
      selectedTrailingIcon: Icon(Icons.keyboard_arrow_up_rounded),
      dropdownMenuEntries: Specialty.values
          .map(
            (specialty) =>
                DropdownMenuEntry(value: specialty, label: specialty.name),
          )
          .toList(),
      width: double.infinity,
      trailingIcon: Icon(Icons.keyboard_arrow_down_rounded),

      enableSearch: true,
      decorationBuilder: (context, controller) => InputDecoration(
        filled: true,
        hintStyle: context.light14.textSecondary.rubik,
        hintText: t.admin.add_doctor_screen.select_specialty,
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
