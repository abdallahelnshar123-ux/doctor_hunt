import 'package:dartz/dartz.dart';
import 'package:doctor_hunt/apps/core/data/models/doctor/doctor.dart';
import 'package:doctor_hunt/apps/core/mapper/doctor_dto_mapper.dart';
import 'package:doctor_hunt/apps/features/patient/appointments_tab/data/service/review_batch_firestore_service.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/exceptions/app_exceptions.dart';
import '../../../../../core/failure/failure.dart';
import '../../../../../core/mapper/exception_mapper.dart';
import '../../../appointments_tab/data/models/appointment/appointment.dart';
import '../../../appointments_tab/data/mappers/appointment_mapper.dart';
import '../service/appointment_firestore_service.dart';

@injectable
class AppointmentRepository {
  final AppointmentFirestoreService _firestoreService;
  final ReviewBatchFirestoreService _reviewBatchService;

  AppointmentRepository(this._firestoreService, this._reviewBatchService);

  Future<Either<Failure, List<Appointment>>> getBookedAppointmentsInRange({
    required String doctorId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final appointmentDtos = await _firestoreService.getBookedAppointmentsInRange(
        doctorId: doctorId,
        startDate: startDate,
        endDate: endDate,
      );

      final appointments =
          appointmentDtos.map((dto) => dto.toAppointment()).toList();

      return Right(appointments);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  // Future<Either<Failure, List<Appointment>>> getPatientAppointments(
  //     String patientId) async {
  //   try {
  //     final appointmentDtos =
  //         await _firestoreService.getPatientAppointments(patientId);
  //
  //     final appointments =
  //         appointmentDtos.map((dto) => dto.toAppointment()).toList();
  //
  //     return Right(appointments);
  //   } on AppException catch (e) {
  //     return Left(e.toFailure());
  //   } catch (e) {
  //     return Left(UnexpectedFailure(e.toString()));
  //   }
  // }

  Stream<Either<Failure, List<Appointment>>> getPatientAppointmentsStream(
      String patientId) async* {
    try {
      await for (final dtos
          in _firestoreService.getPatientAppointmentsStream(patientId)) {
        final appointments = dtos.map((dto) => dto.toAppointment()).toList();
        yield Right(appointments);
      }
    } on AppException catch (e) {
      yield Left(e.toFailure());
    } catch (e) {
      yield Left(UnexpectedFailure(e.toString()));
    }
  }

  Future<Either<Failure, Unit>> bookAppointment(Appointment appointment) async {
    try {
      await _firestoreService.bookAppointment(appointment.toAppointmentDto());
      return const Right(unit);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  Future<Either<Failure, Unit>> addReviewAndUpdateDoctor({
    required Doctor updatedDoctor,
    required Appointment updatedAppointment,
  }) async {
    try {
      await _reviewBatchService.addReviewAndUpdateAppointment(
        updatedDoctorDto: updatedDoctor.toDoctorDto(),
        updatedAppointmentDto: updatedAppointment.toAppointmentDto(),
      );
      return const Right(unit);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  // Future<Either<Failure, List<Appointment>>> getAdminAppointments(
  //     String adminId) async {
  //   try {
  //     final appointmentDtos =
  //         await _firestoreService.getAdminAppointments(adminId);
  //
  //     final appointments =
  //         appointmentDtos.map((dto) => dto.toAppointment()).toList();
  //
  //     return Right(appointments);
  //   } on AppException catch (e) {
  //     return Left(e.toFailure());
  //   } catch (e) {
  //     return Left(UnexpectedFailure(e.toString()));
  //   }
  // }

  Stream<Either<Failure, List<Appointment>>> getAdminAppointmentsStream(
      String adminId) async* {
    try {
      await for (final dtos
          in _firestoreService.getAdminAppointmentsStream(adminId)) {
        final appointments = dtos.map((dto) => dto.toAppointment()).toList();
        yield Right(appointments);
      }
    } on AppException catch (e) {
      yield Left(e.toFailure());
    } catch (e) {
      yield Left(UnexpectedFailure(e.toString()));
    }
  }

  Future<Either<Failure, Unit>> updateAppointmentStatus(
      String appointmentId, AppointmentStatus status) async {
    try {
      await _firestoreService.updateAppointmentStatus(appointmentId, status);
      return const Right(unit);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
