part of 'working_hours_widget.dart';

class SlotDurationDropDown extends StatelessWidget {
  const SlotDurationDropDown({
    super.key,
    required this.initialSelection,
    this.onSelected,
    required this.title,
  });

  final SlotDuration initialSelection;
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
          dropdownMenuEntries: SlotDuration.values
              .map(
                (duration) => DropdownMenuEntry<String>(
                  value: duration.name,
                  label: '${duration.minutes} min',
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
