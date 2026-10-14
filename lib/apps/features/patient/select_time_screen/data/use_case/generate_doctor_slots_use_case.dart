import 'package:injectable/injectable.dart';

import '../../../../../core/data/models/doctor/doctor_availability.dart';
import '../../../../../core/data/models/doctor/time_slot.dart';
import '../../../../../core/data/models/doctor/working_days.dart';

@injectable
class GenerateDoctorSlotsUseCase {
  /// Generates a list of TimeSlots for a specific doctor on a specific date.
  /// It considers the doctor's configuration (startTime, endTime, slotDuration),
  /// fixed break times, and filters out already booked appointments.
  List<TimeSlot> call({
    required DoctorAvailability availability,
    required DateTime targetDate,
    required List<DateTime> bookedAppointments,
  }) {
    // 1. Check if the targetDate is a working day for the doctor
    final targetDayEnum = _getWorkingDayFromDateTime(targetDate);
    if (!availability.workingDays.contains(targetDayEnum)) {
      return []; // Doctor is not working on this day
    }

    final slots = <TimeSlot>[];

    // Create DateTime objects for the start and end times on the target date
    var currentSlotTime = DateTime(
      targetDate.year,
      targetDate.month,
      targetDate.day,
      availability.startTime.hour24,
      0,
    );

    final endDateTime = DateTime(
      targetDate.year,
      targetDate.month,
      targetDate.day,
      availability.endTime.hour24,
      0,
    );

    // Fixed Break Times
    // Break 1: 12:00 PM - 1:00 PM
    final break1Start = DateTime(
      targetDate.year,
      targetDate.month,
      targetDate.day,
      12,
      0,
    );
    final break1End = DateTime(
      targetDate.year,
      targetDate.month,
      targetDate.day,
      13,
      0,
    );

    // Break 2: 4:00 PM - 5:00 PM (16:00 - 17:00)
    final break2Start = DateTime(
      targetDate.year,
      targetDate.month,
      targetDate.day,
      16,
      0,
    );
    final break2End = DateTime(
      targetDate.year,
      targetDate.month,
      targetDate.day,
      17,
      0,
    );

    // 2. Generate slots iteratively
    while (currentSlotTime.isBefore(endDateTime)) {
      final slotEndTime = currentSlotTime.add(
        Duration(minutes: availability.slotDuration.minutes),
      );

      // 3. Check for overlap with Break 1
      if (_isOverlapping(
        currentSlotTime,
        slotEndTime,
        break1Start,
        break1End,
      )) {
        // Skip to the end of the break
        currentSlotTime = break1End;
        continue;
      }

      // 4. Check for overlap with Break 2
      if (_isOverlapping(
        currentSlotTime,
        slotEndTime,
        break2Start,
        break2End,
      )) {
        // Skip to the end of the break
        currentSlotTime = break2End;
        continue;
      }

      // Ensure the slot doesn't exceed the end time
      if (slotEndTime.isAfter(endDateTime)) {
        break; // Stop generating slots if it passes the doctor's end time
      }

      // 5. Check if the slot is already booked
      final isBooked = bookedAppointments.any((bookedTime) {
        final localBookedTime = bookedTime.toLocal();
        return localBookedTime.year == currentSlotTime.year &&
            localBookedTime.month == currentSlotTime.month &&
            localBookedTime.day == currentSlotTime.day &&
            localBookedTime.hour == currentSlotTime.hour &&
            localBookedTime.minute == currentSlotTime.minute;
      });

      if (!isBooked) {
        final now = DateTime.now();
        if (currentSlotTime.isAfter(now)) {
          slots.add(TimeSlot(time: currentSlotTime, isAvailable: true));
        }
      }

      // Move to the next slot
      currentSlotTime = slotEndTime;
    }

    return slots;
  }

  /// Helper to convert DateTime weekday to WorkingDay enum
  WorkingDay _getWorkingDayFromDateTime(DateTime date) {
    switch (date.weekday) {
      case DateTime.monday:
        return WorkingDay.monday;
      case DateTime.tuesday:
        return WorkingDay.tuesday;
      case DateTime.wednesday:
        return WorkingDay.wednesday;
      case DateTime.thursday:
        return WorkingDay.thursday;
      case DateTime.friday:
        return WorkingDay.friday;
      case DateTime.saturday:
        return WorkingDay.saturday;
      case DateTime.sunday:
        return WorkingDay.sunday;
      default:
        return WorkingDay.monday;
    }
  }

  /// Helper to check if two time periods overlap
  bool _isOverlapping(
    DateTime slotStart,
    DateTime slotEnd,
    DateTime breakStart,
    DateTime breakEnd,
  ) {
    // A slot overlaps with a break if:
    // It starts before the break ends AND it ends after the break starts.
    return slotStart.isBefore(breakEnd) && slotEnd.isAfter(breakStart);
  }
}
