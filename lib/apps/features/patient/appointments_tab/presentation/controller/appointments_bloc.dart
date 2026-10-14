import 'package:doctor_hunt/apps/core/data/models/doctor/rating.dart';
import 'package:doctor_hunt/apps/core/data/models/doctor/review.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../generated/translations.g.dart';
import '../../../../../core/data/session/user_session_manager.dart';
import '../../../select_time_screen/data/repo/appointment_repository.dart';
import '../../data/models/appointment/appointment.dart';

part 'appointments_event.dart';
part 'appointments_state.dart';

@injectable
class AppointmentsBloc extends Bloc<AppointmentsEvent, AppointmentsState> {
  final AppointmentRepository _appointmentRepository;
  final UserSessionManager _userSessionManager;

  AppointmentsBloc(
    this._appointmentRepository,
    this._userSessionManager,
  ) : super(AppointmentsInitial()) {
    on<FetchPatientAppointments>(_onFetchPatientAppointments);
    on<AddAppointmentReviewEvent>(_onAddAppointmentReview);
  }

  Future<void> _onFetchPatientAppointments(
    FetchPatientAppointments event,
    Emitter<AppointmentsState> emit,
  ) async {
    emit(AppointmentsLoading());

    final userOption = _userSessionManager.getCurrentUser();
    if (userOption.isNone()) {
      emit(AppointmentsError(t.errors.some_thing_went_wrong));
      return;
    }

    final user = userOption.fold(() => null, (user) => user)!;

    final result = await _appointmentRepository.getPatientAppointments(user.id);

    result.fold(
      (failure) => emit(AppointmentsError(failure.message)),
      (appointments) => emit(AppointmentsSuccess(appointments)),
    );
  }

  Future<void> _onAddAppointmentReview(
    AddAppointmentReviewEvent event,
    Emitter<AppointmentsState> emit,
  ) async {
    final currentState = state;
    emit(AddReviewLoading(event.appointment.id));

    final doctor = event.appointment.doctor;
    final oldRating = doctor.rating;
    
    final newReviews = List<Review>.from(oldRating.reviews)..add(event.review);
    final newTotalRating = newReviews.fold(0, (sum, review) => sum + review.rating);
    final newAverage = newTotalRating / newReviews.length;

    final updatedRating = Rating(rating: newAverage, reviews: newReviews);
    final updatedDoctor = doctor.copyWith(rating: updatedRating);
    final updatedAppointment = event.appointment.copyWith(
      review: event.review,
      doctor: updatedDoctor,
    );

    final result = await _appointmentRepository.addReviewAndUpdateDoctor(
      updatedDoctor: updatedDoctor,
      updatedAppointment: updatedAppointment,
    );

    result.fold(
      (failure) {
        emit(AddReviewError(failure.message, event.appointment.id));
        if (currentState is AppointmentsSuccess) {
          emit(AppointmentsSuccess(currentState.appointments));
        }
      },
      (_) {
        emit(AddReviewSuccess(event.appointment.id));
        // add(const FetchPatientAppointments());
      },
    );
  }
}
