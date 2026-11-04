import 'package:equatable/equatable.dart';

abstract class DoctorAvailabilityState extends Equatable {
  const DoctorAvailabilityState();

  @override
  List<Object?> get props => [];
}

final class DoctorAvailabilityInitial extends DoctorAvailabilityState {}

final class DoctorAvailabilityLoading extends DoctorAvailabilityState {}

final class DoctorAvailabilitySuccess extends DoctorAvailabilityState {}

final class DoctorAvailabilityError extends DoctorAvailabilityState {
  final String message;

  const DoctorAvailabilityError(this.message);

  @override
  List<Object?> get props => [message];
}
