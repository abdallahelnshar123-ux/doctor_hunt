import 'package:equatable/equatable.dart';

import '../../../../../core/data/models/doctor/doctor.dart';
import '../../../../../core/data/models/doctor/doctor_availability.dart';

abstract class SelectTimeEvent extends Equatable {
  const SelectTimeEvent();

  @override
  List<Object> get props => [];
}

class GetDoctorSlotsEvent extends SelectTimeEvent {
  final DoctorAvailability availability;
  final DateTime startDate;
  final String doctorId;

  const GetDoctorSlotsEvent({
    required this.availability,
    required this.startDate,
    required this.doctorId,
  });

  @override
  List<Object> get props => [availability, startDate, doctorId];
}

class BookAppointmentEvent extends SelectTimeEvent {
  final DateTime selectedTime;
  final Doctor doctor;

  const BookAppointmentEvent({
    required this.selectedTime,
    required this.doctor,
  });

  @override
  List<Object> get props => [selectedTime, doctor];
}
