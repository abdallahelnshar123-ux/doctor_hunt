part of 'appointments_bloc.dart';

sealed class AppointmentsEvent extends Equatable {
  const AppointmentsEvent();

  @override
  List<Object> get props => [];
}

class FetchPatientAppointments extends AppointmentsEvent {
  const FetchPatientAppointments();
}

class AddAppointmentReviewEvent extends AppointmentsEvent {
  final Appointment appointment;
  final Review review;

  const AddAppointmentReviewEvent(this.appointment, this.review);

  @override
  List<Object> get props => [appointment, review];
}
