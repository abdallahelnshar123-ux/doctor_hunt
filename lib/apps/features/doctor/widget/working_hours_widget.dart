import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../generated/style_atoms.dart';
import '../../../core/data/models/doctor/slot_duration.dart';
import '../../../core/data/models/doctor/working_hour.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_container_with_shadow.dart';

part 'slot_duration_drop_down.dart';

part 'time_drop_down.dart';

class WorkingHoursWidget extends StatelessWidget {
  const WorkingHoursWidget({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.slotDuration,
  });

  final ObjectRef<WorkingHour> startTime;
  final ObjectRef<WorkingHour> endTime;
  final ObjectRef<SlotDuration> slotDuration;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,

      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Text(
            t.doctor.doctorAvailabilityScreen.workingHours,
            style: context.bold14.textTertiary.rubik,
          ),
        ),
        _buildDropDownGroup(context: context),
      ],
    );

  }

  Widget _buildDropDownGroup({required BuildContext context}) {
    return AppContainerWithShadow(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 10,
            children: [
              Expanded(
                child: TimeDropDown(
                  initialSelection: startTime.value,
                  onSelected: (value) => startTime.value = WorkingHour.values
                      .firstWhere((element) => element.name == value),
                  title: t.doctor.doctorAvailabilityScreen.startTime,
                ),
              ),
              Expanded(
                child: TimeDropDown(
                  initialSelection: endTime.value,
                  onSelected: (value) => endTime.value = WorkingHour.values
                      .firstWhere((element) => element.name == value),
                  title: t.doctor.doctorAvailabilityScreen.endTime,
                ),
              ),
            ],
          ),
          SlotDurationDropDown(
            initialSelection: slotDuration.value,
            onSelected: (value) => slotDuration.value = SlotDuration.values
                .firstWhere((element) => element.name == value),
            title: t.doctor.doctorAvailabilityScreen.slotDuration,
          ),
        ],
      ),
    );
  }
}
