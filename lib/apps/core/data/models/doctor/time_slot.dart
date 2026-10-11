import 'package:equatable/equatable.dart';

class TimeSlot extends Equatable {
  final DateTime time;
  final bool isAvailable;

  const TimeSlot({required this.time, this.isAvailable = true});

  TimeSlot copyWith({DateTime? time, bool? isAvailable}) {
    return TimeSlot(
      time: time ?? this.time,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }

  @override
  List<Object?> get props => [time, isAvailable];
}
