import 'package:doctor_hunt/apps/core/data/models/doctor/slot_duration.dart';
import 'package:doctor_hunt/apps/core/data/models/doctor/working_days.dart';
import 'package:doctor_hunt/apps/core/data/models/doctor/working_hour.dart';
import 'package:doctor_hunt/apps/features/doctor/widget/working_days_widget.dart';
import 'package:doctor_hunt/apps/features/doctor/widget/working_hours_widget.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DoctorOnboardingAvailabilityTab extends StatelessWidget {
  const DoctorOnboardingAvailabilityTab({
    super.key,
    required this.workingDays,
    required this.startTime,
    required this.endTime,
    required this.slotDuration,
  });

  final ValueNotifier<List<WorkingDay>> workingDays;
  final ObjectRef<WorkingHour> startTime;
  final ObjectRef<WorkingHour> endTime;
  final ObjectRef<SlotDuration> slotDuration;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Text(
            t.doctor.onboarding.stepAvailabilitySubtitle,
            style: context.medium16.textPrimary.rubik,
            textAlign: .center,
          ),
          // Text(
          //   t.admin.doctorAvailabilityScreen.workingDays,
          //   style: context.bold14.textTertiary.rubik,
          // ),
          // _buildWorkingDaysWidget(context),
          WorkingDaysWidget(workingDays: workingDays),
          WorkingHoursWidget(
            startTime: startTime,
            endTime: endTime,
            slotDuration: slotDuration,
          ),
          // Text(
          //   t.doctor.doctorAvailabilityScreen.workingHours,
          //   style: context.bold14.textTertiary.rubik,
          // ),
          // _buildDropDownGroup(context),
        ],
      ),
    );

    //   CupertinoOnboardingPage(
    //   title: Text(
    //     t.doctor.onboarding.stepAvailabilityTitle,
    //     style: context.semiBold24.textPrimary.rubik,
    //     textAlign: TextAlign.center,
    //   ),
    //   body: SingleChildScrollView(
    //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text(
    //           t.doctor.onboarding.stepAvailabilitySubtitle,
    //           style: context.regular14.textSecondary.rubik,
    //         ),
    //         const SizedBox(height: 16),
    //         Text(
    //           t.admin.doctorAvailabilityScreen.workingDays,
    //           style: context.bold14.textTertiary.rubik,
    //         ),
    //         const SizedBox(height: 8),
    //         _buildWorkingDaysWidget(context),
    //         const SizedBox(height: 16),
    //         Text(
    //           t.admin.doctorAvailabilityScreen.workingHours,
    //           style: context.bold14.textTertiary.rubik,
    //         ),
    //         const SizedBox(height: 8),
    //         _buildDropDownGroup(context),
    //         const SizedBox(height: 30),
    //       ],
    //     ),
    //   ),
    // );
  }

  // Widget _buildDropDownGroup(BuildContext context) {
  //   return AppContainerWithShadow(
  //     padding: const EdgeInsets.all(15),
  //     decoration: BoxDecoration(
  //       color: AppColors.white,
  //       borderRadius: BorderRadius.circular(16),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           children: [
  //             Expanded(
  //               child: TimeDropDown(
  //                 initialSelection: startTime.value,
  //                 onSelected: (value) => startTime.value = WorkingHour.values
  //                     .firstWhere((element) => element.name == value),
  //                 title: t.admin.doctorAvailabilityScreen.startTime,
  //               ),
  //             ),
  //             const SizedBox(width: 10),
  //             Expanded(
  //               child: TimeDropDown(
  //                 initialSelection: endTime.value,
  //                 onSelected: (value) => endTime.value = WorkingHour.values
  //                     .firstWhere((element) => element.name == value),
  //                 title: t.admin.doctorAvailabilityScreen.endTime,
  //               ),
  //             ),
  //           ],
  //         ),
  //         const SizedBox(height: 10),
  //         SlotDurationDropDown(
  //           initialSelection: slotDuration.value,
  //           onSelected: (value) => slotDuration.value = SlotDuration.values
  //               .firstWhere((element) => element.name == value),
  //           title: t.admin.doctorAvailabilityScreen.slotDuration,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildWorkingDaysWidget(BuildContext context) {
  //   return AppContainerWithShadow(
  //     padding: const EdgeInsets.all(15),
  //     decoration: BoxDecoration(
  //       color: AppColors.white,
  //       borderRadius: BorderRadius.circular(16),
  //     ),
  //     child: ListView.separated(
  //       physics: const NeverScrollableScrollPhysics(),
  //       shrinkWrap: true,
  //       itemBuilder: (context, index) {
  //         final day = WorkingDay.values[index];
  //         return ValueListenableBuilder(
  //           valueListenable: workingDays,
  //           builder: (context, workingDaysValue, child) {
  //             final bool isActive = workingDaysValue.contains(day);
  //             return ListTile(
  //               leading: Container(
  //                 padding: const EdgeInsets.all(7),
  //                 decoration: BoxDecoration(
  //                   color: isActive
  //                       ? AppColors.brandPrimary8
  //                       : AppColors.borderDefault,
  //                   borderRadius: BorderRadius.circular(8),
  //                 ),
  //                 child: Icon(
  //                   Icons.calendar_month_outlined,
  //                   color: isActive
  //                       ? AppColors.brandPrimary
  //                       : AppColors.textSecondary,
  //                 ),
  //               ),
  //               title: Text(day.name),
  //               titleTextStyle: isActive
  //                   ? context.semiBold14.textPrimary.rubik
  //                   : context.semiBold14.textSecondary.rubik,
  //               trailing: Switch(
  //                 value: isActive,
  //                 onChanged: (val) {
  //                   final newList = List<WorkingDay>.from(workingDaysValue);
  //                   val ? newList.add(day) : newList.remove(day);
  //                   workingDays.value = newList;
  //                 },
  //                 activeThumbColor: AppColors.white,
  //                 activeTrackColor: AppColors.brandPrimary,
  //               ),
  //               contentPadding: EdgeInsets.zero,
  //             );
  //           },
  //         );
  //       },
  //       separatorBuilder: (context, index) =>
  //           const Divider(color: AppColors.bgSurfaceLight, height: 5),
  //       itemCount: WorkingDay.values.length,
  //     ),
  //   );
  // }
}
