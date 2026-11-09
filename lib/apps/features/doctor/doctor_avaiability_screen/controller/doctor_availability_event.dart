import 'package:equatable/equatable.dart';

import '../../../../core/data/models/doctor/slot_duration.dart';
import '../../../../core/data/models/doctor/working_days.dart';
import '../../../../core/data/models/doctor/working_hour.dart';

abstract class DoctorAvailabilityEvent extends Equatable {
  const DoctorAvailabilityEvent();

  @override
  List<Object?> get props => [];
}

class UpdateAvailabilityConfigEvent extends DoctorAvailabilityEvent {
  final List<WorkingDay> workingDays;
  final WorkingHour startTime;
  final WorkingHour endTime;
  final SlotDuration slotDuration;

  const UpdateAvailabilityConfigEvent({
    required this.workingDays,
    required this.startTime,
    required this.endTime,
    required this.slotDuration,
  });

  @override
  List<Object?> get props => [workingDays, startTime, endTime, slotDuration];
}
