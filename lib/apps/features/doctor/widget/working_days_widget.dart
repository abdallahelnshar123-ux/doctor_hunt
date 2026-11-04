import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';

import '../../../../generated/style_atoms.dart';
import '../../../core/data/models/doctor/working_days.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_container_with_shadow.dart';

class WorkingDaysWidget extends StatelessWidget {
  const WorkingDaysWidget({super.key, required this.workingDays});

  final ValueNotifier<List<WorkingDay>> workingDays;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Text(
            t.doctor.doctorAvailabilityScreen.workingDays,
            style: context.bold14.textTertiary.rubik,
          ),
        ),
        _buildWorkingDaysWidget(context: context),
      ],
    );
  }

  Widget _buildWorkingDaysWidget({required BuildContext context}) {
    return AppContainerWithShadow(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final day = WorkingDay.values[index];
          return ValueListenableBuilder(
            valueListenable: workingDays,
            builder: (context, workingDaysValue, child) {
              final bool isActive = workingDaysValue.contains(day);
              return ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppColors.brandPrimary8
                        : AppColors.borderDefault,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.calendar_month_outlined,
                    color: isActive
                        ? AppColors.brandPrimary
                        : AppColors.textSecondary,
                  ),
                ),
                title: Text(day.name),
                titleTextStyle: isActive
                    ? context.semiBold14.textPrimary.rubik
                    : context.semiBold14.textSecondary.rubik,
                trailing: Switch(
                  value: isActive,
                  onChanged: (val) {
                    final newList = List<WorkingDay>.from(workingDaysValue);
                    val ? newList.add(day) : newList.remove(day);
                    workingDays.value = newList;
                  },
                  activeThumbColor: AppColors.white,
                  activeTrackColor: AppColors.brandPrimary,
                ),
                contentPadding: EdgeInsets.zero,
              );
            },
          );
        },
        separatorBuilder: (context, index) =>
            const Divider(color: AppColors.bgSurfaceLight, height: 5),
        itemCount: WorkingDay.values.length,
      ),
    );
  }
}
