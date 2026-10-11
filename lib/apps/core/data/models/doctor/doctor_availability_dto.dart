import 'package:equatable/equatable.dart';

import '../../../../core/constants/firestore_constants.dart';
import 'slot_duration.dart';
import 'working_days.dart';
import 'working_hour.dart';

class DoctorAvailabilityDto extends Equatable {
  final List<WorkingDay> workingDays;
  final WorkingHour startTime;
  final WorkingHour endTime;
  final SlotDuration slotDuration;

  const DoctorAvailabilityDto({
    required this.workingDays,
    required this.startTime,
    required this.endTime,
    required this.slotDuration,
  });

  factory DoctorAvailabilityDto.fromFireStore(Map<String, dynamic> data) {
    return DoctorAvailabilityDto(
      workingDays:
          (data[FirestoreConstants.workingDays] as List<dynamic>?)
              ?.map(
                (e) => WorkingDay.values.firstWhere(
                  (day) => day.name == e.toString(),
                  orElse: () => WorkingDay.monday,
                ),
              )
              .toList() ??
          [],
      startTime: WorkingHour.values.firstWhere(
        (e) => e.name == data[FirestoreConstants.startTime]?.toString(),
        orElse: () => WorkingHour.am9,
      ),
      endTime: WorkingHour.values.firstWhere(
        (e) => e.name == data[FirestoreConstants.endTime]?.toString(),
        orElse: () => WorkingHour.pm5,
      ),
      slotDuration: SlotDuration.values.firstWhere(
        (e) => e.name == data[FirestoreConstants.slotDuration]?.toString(),
        orElse: () => SlotDuration.min30,
      ),
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      FirestoreConstants.workingDays: workingDays.map((e) => e.name).toList(),
      FirestoreConstants.startTime: startTime.name,
      FirestoreConstants.endTime: endTime.name,
      FirestoreConstants.slotDuration: slotDuration.name,
    };
  }

  @override
  List<Object?> get props => [workingDays, startTime, endTime, slotDuration];
}
