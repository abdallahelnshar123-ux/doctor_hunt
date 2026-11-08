import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:doctor_hunt/apps/core/data/appointment/repo/appointment_repository.dart';
import 'package:doctor_hunt/apps/core/data/session/user_session_manager.dart';

import 'doctor_schedule_event.dart';
import 'doctor_schedule_state.dart';

@injectable
class DoctorScheduleBloc extends Bloc<DoctorScheduleEvent, DoctorScheduleState> {
  final AppointmentRepository _appointmentRepository;
  final UserSessionManager _userSessionManager;

  DoctorScheduleBloc(
    this._appointmentRepository,
    this._userSessionManager,
  ) : super(const DoctorScheduleState()) {
    on<FetchDoctorSchedule>(_onFetchDoctorSchedule);
    on<RefreshDoctorSchedule>(_onRefreshDoctorSchedule);
    on<ChangeScheduleFilter>(_onChangeScheduleFilter);
  }

  Future<void> _onFetchDoctorSchedule(
    FetchDoctorSchedule event,
    Emitter<DoctorScheduleState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final user = _userSessionManager.currentUser;
    if (user == null) {
      emit(state.copyWith(isLoading: false, errorMessage: 'User not found'));
      return;
    }

    final now = DateTime.now();
    DateTime startDate;
    DateTime endDate;

    switch (state.filter) {
      case ScheduleFilter.today:
        startDate = DateTime(now.year, now.month, now.day);
        endDate = startDate.add(const Duration(days: 1));
        break;
      case ScheduleFilter.tomorrow:
        startDate = DateTime(now.year, now.month, now.day).add(const Duration(days: 1));
        endDate = startDate.add(const Duration(days: 1));
        break;
      case ScheduleFilter.next7Days:
        startDate = DateTime(now.year, now.month, now.day);
        endDate = startDate.add(const Duration(days: 7));
        break;
    }

    final result = await _appointmentRepository.getBookedAppointmentsInRange(
      doctorId: user.id,
      startDate: startDate,
      endDate: endDate,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      )),
      (appointments) {
        appointments.sort((a, b) => a.sessionTime.compareTo(b.sessionTime));
        emit(state.copyWith(
          isLoading: false,
          appointments: appointments,
        ));
      },
    );
  }

  void _onRefreshDoctorSchedule(
    RefreshDoctorSchedule event,
    Emitter<DoctorScheduleState> emit,
  ) {
    add(const FetchDoctorSchedule());
  }

  void _onChangeScheduleFilter(
    ChangeScheduleFilter event,
    Emitter<DoctorScheduleState> emit,
  ) {
    if (state.filter != event.filter) {
      emit(state.copyWith(filter: event.filter));
      add(const FetchDoctorSchedule());
    }
  }
}
