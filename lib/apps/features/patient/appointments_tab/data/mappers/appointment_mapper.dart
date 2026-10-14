import 'package:doctor_hunt/apps/core/mapper/doctor_dto_mapper.dart';
import 'package:doctor_hunt/apps/core/mapper/doctor_mapper.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/mappers/my_user_dto_mapper.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/mappers/my_user_mapper.dart';
import 'package:doctor_hunt/apps/features/patient/appointments_tab/data/models/appointment/appointment.dart';
import 'package:doctor_hunt/apps/features/patient/appointments_tab/data/models/appointment_dto/appointment_dto.dart';
import 'package:doctor_hunt/apps/core/mapper/review_mapper.dart';
import 'package:doctor_hunt/apps/core/mapper/review_dto_mapper.dart';

extension AppointmentMapper on AppointmentDto {
  Appointment toAppointment() {
    return Appointment(
      id: id,
      patient: patient.toUser(),
      doctor: doctor.toDoctor(),
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
      patient: patient.toMyUserDto(),
      doctor: doctor.toDoctorDto(),
      sessionTime: sessionTime,
      createdAt: createdAt,
      fee: fee,
      status: status,
      review: review?.toDto(),
    );
  }
}
