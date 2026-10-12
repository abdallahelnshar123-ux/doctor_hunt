import 'package:equatable/equatable.dart';

import '../../data/models/daily_availability.dart';

abstract class SelectTimeState extends Equatable {
  const SelectTimeState();

  @override
  List<Object?> get props => [];
}

class SelectTimeInitial extends SelectTimeState {}

class SelectTimeLoading extends SelectTimeState {}

class SelectTimeLoaded extends SelectTimeState {
  final List<DailyAvailability> weeklyAvailability;

  const SelectTimeLoaded(this.weeklyAvailability);

  @override
  List<Object?> get props => [weeklyAvailability];
}

class SelectTimeError extends SelectTimeState {
  final String message;

  const SelectTimeError(this.message);

  @override
  List<Object?> get props => [message];
}

class BookAppointmentLoading extends SelectTimeState {}

class BookAppointmentSuccess extends SelectTimeState {
  final DateTime selectedTime;

  const BookAppointmentSuccess(this.selectedTime);

  @override
  List<Object?> get props => [selectedTime];
}

class BookAppointmentError extends SelectTimeState {
  final String message;

  const BookAppointmentError(this.message);

  @override
  List<Object?> get props => [message];
}

