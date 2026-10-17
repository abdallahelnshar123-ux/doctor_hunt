import 'package:equatable/equatable.dart';

import 'slot_duration.dart';
import 'working_days.dart';
import 'working_hour.dart';

class DoctorAvailability extends Equatable {
  final List<WorkingDay> workingDays;
  final WorkingHour startTime;
  final WorkingHour endTime;
  final SlotDuration slotDuration;

  const DoctorAvailability({
    required this.workingDays,
    required this.startTime,
    required this.endTime,
    required this.slotDuration,
  });

  const DoctorAvailability.initial()
    : workingDays = const [
        WorkingDay.monday,
        WorkingDay.tuesday,
        WorkingDay.wednesday,
        WorkingDay.thursday,
        WorkingDay.friday,
        WorkingDay.saturday,
        WorkingDay.sunday,
      ],
      startTime = WorkingHour.am9,
      endTime = WorkingHour.pm5,
      slotDuration = SlotDuration.min30;

  @override
  List<Object?> get props => [workingDays, startTime, endTime, slotDuration];
}
