part of 'appointments_bloc.dart';

sealed class AppointmentsState extends Equatable {
  const AppointmentsState();

  @override
  List<Object?> get props => [];
}

final class AppointmentsInitial extends AppointmentsState {}

final class AppointmentsLoading extends AppointmentsState {}

final class AppointmentsSuccess extends AppointmentsState {
  final List<Appointment> appointments;

  const AppointmentsSuccess(this.appointments);

  @override
  List<Object?> get props => [appointments];
}

final class AppointmentsError extends AppointmentsState {
  final String message;

  const AppointmentsError(this.message);

  @override
  List<Object?> get props => [message];
}
