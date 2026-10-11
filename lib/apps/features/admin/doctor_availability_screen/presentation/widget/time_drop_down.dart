part of '../screens/doctor_availability_screen.dart';

class TimeDropDown extends StatelessWidget {
  const TimeDropDown({
    super.key,
    // required this.workingHour,
    this.onSelected,
    required this.title,
    required this.initialSelection,
  });

  // final List<WorkingHour> workingHour;
  final void Function(String?)? onSelected;
  final String title;

  final WorkingHour initialSelection;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      crossAxisAlignment: .start,
      children: [
        Text(title, style: context.semiBold10.textSecondary.rubik),
        DropdownMenuFormField(
          textStyle: context.medium12.textTertiary.rubik,
          onSelected: onSelected,
          initialSelection: initialSelection.name,
          validator: (value) => Validators.required(value.toString()),
          menuStyle: MenuStyle(
            alignment: .centerStart,
            visualDensity: .compact,
            backgroundColor: WidgetStatePropertyAll(AppColors.bgPrimary),
            maximumSize: WidgetStatePropertyAll(
              Size.fromWidth(context.width - 40),
            ),
          ),
          showTrailingIcon: true,
          selectedTrailingIcon: Icon(Icons.keyboard_arrow_up_rounded),
          dropdownMenuEntries: WorkingHour.values
              .map(
                (hour) =>
                    DropdownMenuEntry(value: hour.name, label: hour.label),
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
        ),
      ],
    );
  }
}
