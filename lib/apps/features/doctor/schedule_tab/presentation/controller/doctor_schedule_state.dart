import 'package:doctor_hunt/apps/core/data/appointment/models/appointment.dart';
import 'package:equatable/equatable.dart';

enum ScheduleFilter { today, tomorrow, next7Days }

class DoctorScheduleState extends Equatable {
  final ScheduleFilter filter;
  final bool isLoading;
  final List<Appointment>? appointments;
  final String? errorMessage;

  const DoctorScheduleState({
    this.filter = ScheduleFilter.today,
    this.isLoading = false,
    this.appointments,
    this.errorMessage,
  });

  DoctorScheduleState copyWith({
    ScheduleFilter? filter,
    bool? isLoading,
    List<Appointment>? appointments,
    String? errorMessage,
    bool clearError = false,
  }) {
    return DoctorScheduleState(
      filter: filter ?? this.filter,
      isLoading: isLoading ?? this.isLoading,
      appointments: appointments ?? this.appointments,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [filter, isLoading, appointments, errorMessage];
}
