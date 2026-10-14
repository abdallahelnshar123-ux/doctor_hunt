import 'package:equatable/equatable.dart';

import '../../../../patient/appointments_tab/data/models/appointment/appointment.dart';

abstract class AdminAppointmentsState extends Equatable {
  const AdminAppointmentsState();

  @override
  List<Object?> get props => [];
}

class AdminAppointmentsInitial extends AdminAppointmentsState {}

class AdminAppointmentsLoadingState extends AdminAppointmentsState {}

class AdminAppointmentsLoadedState extends AdminAppointmentsState {
  final List<Appointment> appointments;

  const AdminAppointmentsLoadedState(this.appointments);

  @override
  List<Object?> get props => [appointments];
}

class AdminAppointmentsErrorState extends AdminAppointmentsState {
  final String message;

  const AdminAppointmentsErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class AdminUpdateAppointmentLoadingState extends AdminAppointmentsState {}

class AdminUpdateAppointmentSuccessState extends AdminAppointmentsState {
  final String message;

  const AdminUpdateAppointmentSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

class AdminUpdateAppointmentErrorState extends AdminAppointmentsState {
  final String message;

  const AdminUpdateAppointmentErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
