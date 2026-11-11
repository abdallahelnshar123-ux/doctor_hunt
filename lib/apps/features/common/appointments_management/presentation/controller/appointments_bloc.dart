import 'package:dartz/dartz.dart';
import 'package:doctor_hunt/apps/core/data/appointment/models/appointment.dart';
import 'package:doctor_hunt/apps/core/data/appointment/repo/appointment_repository.dart';
import 'package:doctor_hunt/apps/core/data/session/user_session_manager.dart';
import 'package:doctor_hunt/apps/core/failure/failure.dart';
import 'package:doctor_hunt/apps/features/common/auth/domain/entity/user/user_roles.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'appointments_event.dart';
part 'appointments_state.dart';

@injectable
class AppointmentsBloc extends Bloc<AppointmentsEvent, AppointmentsState> {
  final AppointmentRepository _appointmentRepository;
  final UserSessionManager _userSessionManager;

  AppointmentsBloc(this._appointmentRepository, this._userSessionManager)
      : super(AppointmentsInitial()) {
    on<FetchAppointmentsRequested>(_onFetchAppointmentsRequested);
    add(const FetchAppointmentsRequested());
  }

  Future<void> _onFetchAppointmentsRequested(
    FetchAppointmentsRequested event,
    Emitter<AppointmentsState> emit,
  ) async {
    emit(AppointmentsLoading());

    final userOption = _userSessionManager.getCurrentUser();
    if (userOption.isNone()) {
      emit(AppointmentsError(t.errors.userNotAuthenticated));
      return;
    }

    final user = userOption.fold(() => null, (u) => u)!;

    final Stream<Either<Failure, List<Appointment>>> appointmentsStream =
        switch (user.role) {
      UserRoles.patient =>
        _appointmentRepository.getPatientAppointmentsStream(user.id),
      UserRoles.doctor =>
        _appointmentRepository.getDoctorAppointmentsStream(user.id),
      UserRoles.admin =>
        _appointmentRepository.getAdminAppointmentsStream(),
    };

    await emit.forEach<Either<Failure, List<Appointment>>>(
      appointmentsStream,
      onData: (result) => result.fold(
        (failure) => AppointmentsError(failure.message),
        (appointments) => AppointmentsSuccess(appointments),
      ),
      onError: (error, stackTrace) => AppointmentsError(error.toString()),
    );
  }
}
