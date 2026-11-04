part of 'working_hours_widget.dart';

class TimeDropDown extends StatelessWidget {
  const TimeDropDown({
    super.key,
    required this.initialSelection,
    this.onSelected,
    required this.title,
  });

  final WorkingHour initialSelection;
  final void Function(String?)? onSelected;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: context.regular12.textSecondary.rubik),
        const SizedBox(height: 6),
        DropdownMenu<String>(
          width: double.infinity,
          initialSelection: initialSelection.name,
          onSelected: onSelected,
          textStyle: context.semiBold14.textPrimary.rubik,
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: AppColors.bgSurfaceLight,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          dropdownMenuEntries: WorkingHour.values
              .map(
                (hour) => DropdownMenuEntry<String>(
                  value: hour.name,
                  label: hour.label,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
