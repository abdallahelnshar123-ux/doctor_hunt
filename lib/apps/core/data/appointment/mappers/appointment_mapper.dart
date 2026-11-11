import 'package:doctor_hunt/apps/core/data/appointment/models/appointment.dart';
import 'package:doctor_hunt/apps/core/data/appointment/models/appointment_dto.dart';
import 'package:doctor_hunt/apps/core/mapper/review_dto_mapper.dart';
import 'package:doctor_hunt/apps/core/mapper/review_mapper.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/dto/user/doctor_dto.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/mappers/user_mapper.dart';
import 'package:doctor_hunt/apps/features/common/auth/domain/entity/user/doctor.dart';

extension AppointmentMapper on AppointmentDto {
  Appointment toAppointment() {
    return Appointment(
      id: id,
      patient: patient.toEntity(),
      doctor: doctor.toEntity() as DoctorEntity,
      sessionTime: sessionTime,
      createdAt: createdAt,
      fee: fee,
      status: status,
      review: review?.toDomain(),
    );
  }
}

extension AppointmentDtoMapper on Appointment {
  AppointmentDto toAppointmentDto() {
    return AppointmentDto(
      id: id,
      patient: patient.toDto(),
      doctor: doctor.toDto() as DoctorDto,
      sessionTime: sessionTime,
      createdAt: createdAt,
      fee: fee,
      status: status,
      review: review?.toDto(),
    );
  }
}
