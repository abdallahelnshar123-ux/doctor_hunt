import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/exceptions/app_exceptions.dart';
import '../../../../../core/failure/failure.dart';
import '../../../../../core/mapper/exception_mapper.dart';
import '../../../../../core/utils/date_formatter_utils.dart';
import '../../../appointments_tab/data/models/appointment/appointment.dart';
import '../../../appointments_tab/data/mappers/appointment_mapper.dart';
import '../service/appointment_firestore_service.dart';

@injectable
class AppointmentRepository {
  final AppointmentFirestoreService _firestoreService;

  AppointmentRepository(this._firestoreService);

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
}
