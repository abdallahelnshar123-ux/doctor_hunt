import 'package:doctor_hunt/apps/core/constants/firestore_constants.dart';
import 'package:doctor_hunt/apps/core/data/models/doctor/doctor.dart';
import 'package:doctor_hunt/apps/core/data/models/doctor/doctor_dto.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/auth_providers.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user_dto/my_user_dto.dart';
import 'package:doctor_hunt/apps/features/patient/appointments_tab/data/models/appointment/appointment.dart';
import 'package:equatable/equatable.dart';

class AppointmentDto extends Equatable {
  final String id;
  final MyUserDto patient;
  final DoctorDto doctor;
  final String date;
  final String time;
  final double fee;
  final AppointmentStatus status;

  const AppointmentDto({
    required this.id,
    required this.patient,
    required this.doctor,
    required this.date,
    required this.time,
    required this.fee,
    required this.status,
  });

  factory AppointmentDto.fromFireStore(Map<String, dynamic> data) {
    return AppointmentDto(
      id: data[FirestoreConstants.id]?.toString() ?? '',
      patient: data[FirestoreConstants.patient] != null
          ? MyUserDto.fromFireStore(
              data[FirestoreConstants.patient] as Map<String, dynamic>,
            )
          : const MyUserDto(
              id: '',
              email: '',
              name: '',
              provider: UserAuthProvider.emailPassword,
            ),
      doctor: data[FirestoreConstants.doctor] != null
          ? DoctorDto.fromFireStore(
              data[FirestoreConstants.doctor] as Map<String, dynamic>,
            )
          : const DoctorDto(
              id: '',
              name: '',
              adminId: '',
              specialty: Specialty.allergists,
              active: false,
            ),
      date: data[FirestoreConstants.date]?.toString() ?? '',
      time: data[FirestoreConstants.time]?.toString() ?? '',
      fee: (data[FirestoreConstants.fee] as num?)?.toDouble() ?? 0.0,
      status: data[FirestoreConstants.status] != null
          ? AppointmentStatus.values.firstWhere(
              (e) => e.name == data[FirestoreConstants.status],
              orElse: () => AppointmentStatus.upcoming,
            )
          : AppointmentStatus.upcoming,
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      FirestoreConstants.id: id,
      FirestoreConstants.patient: patient.toFireStore(),
      FirestoreConstants.doctor: doctor.toFireStore(),
      FirestoreConstants.date: date,
      FirestoreConstants.time: time,
      FirestoreConstants.fee: fee,
      FirestoreConstants.status: status.name,
    };
  }

  factory AppointmentDto.fromJson(Map<String, dynamic> json) {
    return AppointmentDto.fromFireStore(json);
  }

  Map<String, dynamic> toJson() {
    return toFireStore();
  }

  AppointmentDto copyWith({
    String? id,
    MyUserDto? patient,
    DoctorDto? doctor,
    String? date,
    String? time,
    double? fee,
    AppointmentStatus? status,
  }) {
    return AppointmentDto(
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
