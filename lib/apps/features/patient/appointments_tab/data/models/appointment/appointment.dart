import 'package:doctor_hunt/apps/core/data/models/doctor/doctor.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/my_user.dart';
import 'package:equatable/equatable.dart';

enum AppointmentStatus { upcoming, completed, cancelled }

class Appointment extends Equatable {
  final String id;
  final MyUser patient;
  final Doctor doctor;
  final String date;
  final String time;
  final double fee;
  final AppointmentStatus status;

  const Appointment({
    required this.id,
    required this.patient,
    required this.doctor,
    required this.date,
    required this.time,
    required this.fee,
    required this.status,
  });

  Appointment copyWith({
    String? id,
    MyUser? patient,
    Doctor? doctor,
    String? date,
    String? time,
    double? fee,
    AppointmentStatus? status,
  }) {
    return Appointment(
      id: id ?? this.id,
      patient: patient ?? this.patient,
      doctor: doctor ?? this.doctor,
      date: date ?? this.date,
      time: time ?? this.time,
      fee: fee ?? this.fee,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [id, patient, doctor, date, time, fee, status];
}
