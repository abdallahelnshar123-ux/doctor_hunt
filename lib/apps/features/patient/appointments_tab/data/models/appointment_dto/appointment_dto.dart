import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt/apps/core/constants/firestore_constants.dart';
import 'package:doctor_hunt/apps/core/data/models/doctor/doctor.dart';
import 'package:doctor_hunt/apps/core/data/models/doctor/doctor_dto.dart';
import 'package:doctor_hunt/apps/core/data/models/doctor/rating_dto.dart';
import 'package:doctor_hunt/apps/core/data/models/doctor/review_dto.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user/auth_providers.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/user_dto/my_user_dto.dart';
import 'package:doctor_hunt/apps/features/patient/appointments_tab/data/models/appointment/appointment.dart';
import 'package:equatable/equatable.dart';

class AppointmentDto extends Equatable {
  final String id;
  final MyUserDto patient;
  final DoctorDto doctor;
  final DateTime sessionTime;
  final DateTime createdAt;
  final double fee;
  final AppointmentStatus status;
  final ReviewDto? review;

  const AppointmentDto({
    required this.id,
    required this.patient,
    required this.doctor,
    required this.sessionTime,
    required this.createdAt,
    required this.fee,
    required this.status,
    this.review,
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
              consultationFee: 0.0,
              rating: RatingDto(rating: 0.0, reviews: []),
            ),
      sessionTime: data[FirestoreConstants.sessionTime] is Timestamp
          ? (data[FirestoreConstants.sessionTime] as Timestamp).toDate()
          : DateTime.now(),
      createdAt: data[FirestoreConstants.createdAt] is Timestamp
          ? (data[FirestoreConstants.createdAt] as Timestamp).toDate()
          : DateTime.now(),
      fee: (data[FirestoreConstants.fee] as num?)?.toDouble() ?? 0.0,
      status: data[FirestoreConstants.status] != null
          ? AppointmentStatus.values.firstWhere(
              (e) => e.name == data[FirestoreConstants.status],
              orElse: () => AppointmentStatus.upcoming,
            )
          : AppointmentStatus.upcoming,
      review: data[FirestoreConstants.review] != null
          ? ReviewDto.fromFireStore(
              Map<String, dynamic>.from(data[FirestoreConstants.review] as Map),
            )
          : null,
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      FirestoreConstants.id: id,
      FirestoreConstants.patient: patient.toFireStore(),
      FirestoreConstants.doctor: doctor.toFireStore(),
      FirestoreConstants.sessionTime: Timestamp.fromDate(sessionTime),
      FirestoreConstants.createdAt: Timestamp.fromDate(createdAt),
      FirestoreConstants.fee: fee,
      FirestoreConstants.status: status.name,
      if (review != null) FirestoreConstants.review: review!.toFireStore(),
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
    DateTime? sessionTime,
    DateTime? createdAt,
    double? fee,
    AppointmentStatus? status,
    ReviewDto? review,
  }) {
    return AppointmentDto(
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
