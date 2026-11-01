import 'package:doctor_hunt/apps/core/utils/validators.dart';
import 'package:doctor_hunt/apps/features/common/specialties/data/models/specialty_model.dart';
import 'package:doctor_hunt/apps/features/common/specialties/presentation/controller/specialties_bloc.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../core/extensions/context_extensions.dart';
import '../../../../../core/theme/app_colors.dart';

class SpecialtyDropdownWidget extends StatelessWidget {
  final ValueChanged<SpecialtyModel> selectedSpecialty;

  final String? initialSelection;

  const SpecialtyDropdownWidget({
    super.key,
    required this.selectedSpecialty,
    this.initialSelection,
  });

  @override
  Widget build(BuildContext context) {
    var specialities = context.watch<SpecialtiesBloc>().state.specialties;
    return DropdownMenuFormField(

      textStyle: context.medium16.textTertiary.rubik,
      onSelected: (value) => selectedSpecialty(
        specialities.firstWhere((element) => element.id == value),
      ),
      initialSelection: initialSelection,
      validator: (value) => Validators.required(value),
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(AppColors.bgPrimary),
        maximumSize: WidgetStatePropertyAll(Size.fromWidth(context.width - 40)),
      ),
      showTrailingIcon: true,
      selectedTrailingIcon: Icon(Icons.keyboard_arrow_up_rounded),
      dropdownMenuEntries: specialities
          .map(
            (specialty) => DropdownMenuEntry(
              value: specialty.id,
              label: specialty.localizedName(),
            ),
          )
          .toList(),
      width: double.infinity,
      requestFocusOnTap: true,
      trailingIcon: Icon(Icons.keyboard_arrow_down_rounded),
      enableSearch: true,
      enableFilter: true,
      filterCallback: (entries, query) {
        if (query.isEmpty) return entries;
        return entries
            .where((entry) =>
                entry.label.toLowerCase().contains(query.toLowerCase()))
            .toList();
      },
      decorationBuilder: (context, controller) => InputDecoration(
        filled: true,
        hintStyle: context.light14.textSecondary.rubik,
        hintText: t.admin.addDoctorScreen.selectSpecialty,
        enabled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.borderDefault, width: 2),
        ),
        focusedBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.borderDefault, width: 2),
        ) ,
        fillColor: AppColors.bgPrimary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.borderDefault, width: 2),
        ),
      ),
    );
  }
}
