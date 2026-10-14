import 'package:dartz/dartz.dart';
import 'package:doctor_hunt/apps/core/failure/failure.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/data/session/user_session_manager.dart';
import '../../../../patient/appointments_tab/data/models/appointment/appointment.dart';
import '../../../../patient/select_time_screen/data/repo/appointment_repository.dart';
import 'admin_appointments_event.dart';
import 'admin_appointments_state.dart';

@injectable
class AdminAppointmentsBloc
    extends Bloc<AdminAppointmentsEvent, AdminAppointmentsState> {
  final AppointmentRepository _repository;
  final UserSessionManager _userSessionManager;

  AdminAppointmentsBloc(this._repository, this._userSessionManager)
    : super(AdminAppointmentsInitial()) {
    on<FetchAdminAppointmentsRequested>(_onFetchAdminAppointmentsRequested);
    on<CompleteAppointmentRequested>(_onCompleteAppointmentRequested);
    on<CancelAppointmentRequested>(_onCancelAppointmentRequested);
  }

  Future<void> _onFetchAdminAppointmentsRequested(
    FetchAdminAppointmentsRequested event,
    Emitter<AdminAppointmentsState> emit,
  ) async {
    emit(AdminAppointmentsLoadingState());

    final userOption = _userSessionManager.getCurrentUser();

    if (userOption.isNone()) {
      emit( AdminAppointmentsErrorState(t.errors.user_not_authenticated));
      return;
    }

    final user = userOption.fold(() => null, (user) => user)!;

    await emit.forEach<Either<Failure, List<Appointment>>>(
      _repository.getAdminAppointmentsStream(user.id),
      onData: (result) => result.fold(
        (failure) => AdminAppointmentsErrorState(failure.message),
        (appointments) => AdminAppointmentsLoadedState(appointments),
      ),
      onError: (error, stackTrace) =>
          AdminAppointmentsErrorState(error.toString()),
    );
  }

  Future<void> _onCompleteAppointmentRequested(
    CompleteAppointmentRequested event,
    Emitter<AdminAppointmentsState> emit,
  ) async {
    emit(AdminUpdateAppointmentLoadingState());

    final result = await _repository.updateAppointmentStatus(
      event.appointmentId,
      AppointmentStatus.completed,
    );

    result.fold(
      (failure) => emit(AdminUpdateAppointmentErrorState(failure.message)),
      (_) {
        emit(
          AdminUpdateAppointmentSuccessState(
            t
                .admin
                .appointments_tab
                .appointment_was_marked_as_completed_successfully,
          ),
        );
      },
    );
  }

  Future<void> _onCancelAppointmentRequested(
    CancelAppointmentRequested event,
    Emitter<AdminAppointmentsState> emit,
  ) async {
    emit(AdminUpdateAppointmentLoadingState());

    final result = await _repository.updateAppointmentStatus(
      event.appointmentId,
      AppointmentStatus.cancelled,
    );

    result.fold(
      (failure) => emit(AdminUpdateAppointmentErrorState(failure.message)),
      (_) {
        emit(
          AdminUpdateAppointmentSuccessState(
            t.admin.appointments_tab.appointment_was_cancelled_successfully,
          ),
        );
      },
    );
  }
}
