import 'package:doctor_hunt/apps/core/data/models/doctor/doctor.dart';
import 'package:doctor_hunt/apps/core/data/models/doctor/review.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/my_user.dart';
import 'package:equatable/equatable.dart';

enum AppointmentStatus { upcoming, completed, cancelled }

class Appointment extends Equatable {
  final String id;
  final MyUser patient;
  final Doctor doctor;
  final DateTime sessionTime;
  final DateTime createdAt;
  final double fee;
  final AppointmentStatus status;
  final Review? review;

  const Appointment({
    required this.id,
    required this.patient,
    required this.doctor,
    required this.sessionTime,
    required this.createdAt,
    required this.fee,
    required this.status,
    this.review,
  });

  Appointment copyWith({
    String? id,
    MyUser? patient,
    Doctor? doctor,
    DateTime? sessionTime,
    DateTime? createdAt,
    double? fee,
    AppointmentStatus? status,
    Review? review,
  }) {
    return Appointment(
      id: id ?? this.id,
      patient: patient ?? this.patient,
      doctor: doctor ?? this.doctor,
      sessionTime: sessionTime ?? this.sessionTime,
      createdAt: createdAt ?? this.createdAt,
      fee: fee ?? this.fee,
      status: status ?? this.status,
      review: review ?? this.review,
    );
  }

  @override
  List<Object?> get props => [
        id,
        patient,
        doctor,
        sessionTime,
        createdAt,
        fee,
        status,
        review,
      ];
}
