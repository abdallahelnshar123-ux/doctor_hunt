import 'package:equatable/equatable.dart';

import '../../../../../../apps/core/data/models/doctor/review.dart';
import 'package:doctor_hunt/apps/core/data/appointment/models/appointment.dart';

abstract class AppointmentActionEvent extends Equatable {
  const AppointmentActionEvent();

  @override
  List<Object> get props => [];
}

class CancelAppointmentEvent extends AppointmentActionEvent {
  final String appointmentId;
  final String doctorId;
  final DateTime sessionTime;

  const CancelAppointmentEvent({
    required this.appointmentId,
    required this.doctorId,
    required this.sessionTime,
  });

  @override
  List<Object> get props => [appointmentId, doctorId, sessionTime];
}

class CompleteAppointmentEvent extends AppointmentActionEvent {
  final String appointmentId;

  const CompleteAppointmentEvent(this.appointmentId);

  @override
  List<Object> get props => [appointmentId];
}

class AddAppointmentReviewEvent extends AppointmentActionEvent {
  final Appointment appointment;
  final Review review;

  const AddAppointmentReviewEvent(this.appointment, this.review);

  @override
  List<Object> get props => [appointment, review];
}
