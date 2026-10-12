import 'package:equatable/equatable.dart';

import '../../../../../core/data/models/doctor/time_slot.dart';

class DailyAvailability extends Equatable {
  final DateTime date;
  final List<TimeSlot> availableSlots;

  const DailyAvailability({
    required this.date,
    required this.availableSlots,
  });

  @override
  List<Object?> get props => [date, availableSlots];
}
