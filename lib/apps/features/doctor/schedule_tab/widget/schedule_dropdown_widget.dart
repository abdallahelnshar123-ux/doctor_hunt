import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';

import '../presentation/controller/doctor_schedule_state.dart';

class ScheduleDropdownWidget extends StatelessWidget {
  final ScheduleFilter selectedFilter;
  final ValueChanged<ScheduleFilter> onChanged;

  const ScheduleDropdownWidget({
    super.key,
    required this.selectedFilter,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenuFormField<ScheduleFilter>(
      textStyle: context.medium14.textTertiary.rubik,
      onSelected: (value) {
        if (value != null) onChanged(value);
      },
      initialSelection: selectedFilter,
      menuStyle: MenuStyle(
        backgroundColor: const WidgetStatePropertyAll(AppColors.bgPrimary),
      ),
      selectedTrailingIcon: const Icon(Icons.keyboard_arrow_up_rounded),
      dropdownMenuEntries: [
        DropdownMenuEntry(
          value: ScheduleFilter.today,
          label: t.doctor.schedule.today,
        ),
        DropdownMenuEntry(
          value: ScheduleFilter.tomorrow,
          label: t.doctor.schedule.tomorrow,
        ),
        DropdownMenuEntry(
          value: ScheduleFilter.next7Days,
          label: t.doctor.schedule.next7Days,
        ),
      ],
      width: double.infinity,
      requestFocusOnTap: false,
      trailingIcon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: AppColors.textSecondary,
      ),
      decorationBuilder: (context, controller) => InputDecoration(
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.borderDefault,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.borderDefault,
            width: 1,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.borderDefault,
            width: 1,
          ),
        ),
      ),
    );
  }
}

class DropdownMenuFormField<T> extends FormField<T> {
  DropdownMenuFormField({
    super.key,
    required T initialSelection,
    required List<DropdownMenuEntry<T>> dropdownMenuEntries,
    required ValueChanged<T?> onSelected,
    TextStyle? textStyle,
    MenuStyle? menuStyle,
    Widget? trailingIcon,
    Widget? selectedTrailingIcon,
    double? width,
    bool requestFocusOnTap = false,
    InputDecoration Function(
      BuildContext context,
      TextEditingController controller,
    )?
    decorationBuilder,
  }) : super(
         initialValue: initialSelection,
         builder: (FormFieldState<T> state) {
           return DropdownMenu<T>(
             initialSelection: initialSelection,
             onSelected: (value) {
               state.didChange(value);
               onSelected(value);
             },
             textStyle: textStyle,
             menuStyle: menuStyle,
             trailingIcon: trailingIcon,
             selectedTrailingIcon: selectedTrailingIcon,
             dropdownMenuEntries: dropdownMenuEntries,
             width: width,
             requestFocusOnTap: requestFocusOnTap,
             inputDecorationTheme: InputDecorationTheme(
               filled: true,
               fillColor: AppColors.white,
               contentPadding: const EdgeInsets.symmetric(horizontal: 12),
               enabledBorder: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(8),
                 borderSide: const BorderSide(
                   color: AppColors.borderDefault,
                   width: 1,
                 ),
               ),
               focusedBorder: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(8),
                 borderSide: const BorderSide(
                   color: AppColors.borderDefault,
                   width: 1,
                 ),
               ),
               border: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(8),
                 borderSide: const BorderSide(
                   color: AppColors.borderDefault,
                   width: 1,
                 ),
               ),
             ),
           );
         },
       );
}
