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

  @override
  List<Object?> get props => [workingDays, startTime, endTime, slotDuration];
}
