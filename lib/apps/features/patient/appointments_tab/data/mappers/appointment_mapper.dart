import 'package:doctor_hunt/apps/core/mapper/doctor_dto_mapper.dart';
import 'package:doctor_hunt/apps/core/mapper/doctor_mapper.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/mappers/my_user_dto_mapper.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/mappers/my_user_mapper.dart';
import 'package:doctor_hunt/apps/features/patient/appointments_tab/data/models/appointment/appointment.dart';
import 'package:doctor_hunt/apps/features/patient/appointments_tab/data/models/appointment_dto/appointment_dto.dart';

extension AppointmentMapper on AppointmentDto {
  Appointment toAppointment() {
    return Appointment(
      id: id,
      patient: patient.toUser(),
      doctor: doctor.toDoctor(),
      date: date,
      time: time,
      fee: fee,
      status: status,
    );
  }
}

extension AppointmentDtoMapper on Appointment {
  AppointmentDto toAppointmentDto() {
    return AppointmentDto(
      id: id,
      patient: patient.toMyUserDto(),
      doctor: doctor.toDoctorDto(),
      date: date,
      time: time,
      fee: fee,
      status: status,
    );
  }
}
