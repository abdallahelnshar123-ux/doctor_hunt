import 'package:doctor_hunt/apps/core/utils/validators.dart';
import 'package:flutter/material.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../data/models/doctor/doctor.dart';

class SpecialtyDropdownWidget extends StatelessWidget {
  //CR use enum: Use strongly typed 'Specialties' enum (e.g. ValueChanged<Specialties?> onSelected or FormField<Specialties>) instead of binding to a loose String TextEditingController and reverse-looking up via firstWhere.
  final TextEditingController controller;
  final Specialties? initialSelection;

  const SpecialtyDropdownWidget({
    super.key,
    required this.controller,
    this.initialSelection,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenuFormField(
      initialSelection: initialSelection,
      validator: (value) => Validators.required(value?.name),
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
        //CR hardcode text
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
