import 'package:dartz/dartz.dart';
import 'package:doctor_hunt/apps/core/data/appointment/repo/appointment_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/data/models/doctor/doctor_availability.dart';
import '../../../../../core/failure/failure.dart';
import '../models/daily_availability.dart';
import 'generate_doctor_slots_use_case.dart';

@injectable
class GetAvailableSlotsUseCase {
  final AppointmentRepository _appointmentRepository;
  final GenerateDoctorSlotsUseCase _generateDoctorSlotsUseCase;

  GetAvailableSlotsUseCase(
    this._appointmentRepository,
    this._generateDoctorSlotsUseCase,
  );

  Future<Either<Failure, List<DailyAvailability>>> call({
    required String doctorId,
    required DoctorAvailability availability,
    required DateTime startDate,
  }) async {
    // Normalize startDate to the beginning of the day (00:00:00)
    final startOfDate = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
    );

    // We want to fetch slots for 7 days including the startDate
    // So the end date should be the end of the 6th day after startDate (23:59:59)
    final endDate = startOfDate.add(
      const Duration(days: 6, hours: 23, minutes: 59, seconds: 59),
    );

    // 1. Fetch booked appointments for the next 7 days
    final result = await _appointmentRepository.getBookedAppointmentsInRange(
      doctorId: doctorId,
      startDate: startOfDate,
      endDate: endDate,
    );

    // 2. Map either failure or success
    return result.map((appointments) {
      final List<DailyAvailability> weeklyAvailability = [];

      for (int i = 0; i < 7; i++) {
        final currentDate = startOfDate.add(Duration(days: i));

        // Filter appointments that match the currentDate
        final appointmentsForCurrentDate = appointments.where((appt) {
          final localSessionTime = appt.sessionTime.toLocal();
          return localSessionTime.year == currentDate.year &&
              localSessionTime.month == currentDate.month &&
              localSessionTime.day == currentDate.day;
        }).toList();

        // Extract times from appointments to construct DateTime objects
        final bookedTimes = appointmentsForCurrentDate.map((appt) {
          return appt.sessionTime.toLocal();
        }).toList();

        // 3. Generate slots considering the booked times for this specific day
        final slots = _generateDoctorSlotsUseCase(
          availability: availability,
          targetDate: currentDate,
          bookedAppointments: bookedTimes,
        );

        weeklyAvailability.add(
          DailyAvailability(date: currentDate, availableSlots: slots),
        );
      }

      return weeklyAvailability;
    });
  }
}
