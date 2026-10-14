import 'package:equatable/equatable.dart';

abstract class AdminAppointmentsEvent extends Equatable {
  const AdminAppointmentsEvent();

  @override
  List<Object> get props => [];
}

class FetchAdminAppointmentsRequested extends AdminAppointmentsEvent {}

class CompleteAppointmentRequested extends AdminAppointmentsEvent {
  final String appointmentId;

  const CompleteAppointmentRequested(this.appointmentId);

  @override
  List<Object> get props => [appointmentId];
}

class CancelAppointmentRequested extends AdminAppointmentsEvent {
  final String appointmentId;

  const CancelAppointmentRequested(this.appointmentId);

  @override
  List<Object> get props => [appointmentId];
}
