import 'package:equatable/equatable.dart';

abstract class DoctorAvailabilityState extends Equatable {
  const DoctorAvailabilityState();

  @override
  List<Object?> get props => [];
}

class DoctorAvailabilityInitial extends DoctorAvailabilityState {}

class DoctorAvailabilityLoading extends DoctorAvailabilityState {}

class DoctorAvailabilitySuccess extends DoctorAvailabilityState {}

class DoctorAvailabilityError extends DoctorAvailabilityState {
  final String message;

  const DoctorAvailabilityError(this.message);

  @override
  List<Object?> get props => [message];
}
