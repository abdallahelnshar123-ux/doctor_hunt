import 'package:dartz/dartz.dart';
import 'package:doctor_hunt/apps/core/data/appointment/repo/appointment_repository.dart';
import 'package:doctor_hunt/apps/core/data/doctor/repo/doctor_repository.dart';
import 'package:doctor_hunt/apps/core/data/models/doctor/doctor.dart';
import 'package:doctor_hunt/apps/core/data/models/doctor/rating.dart';
import 'package:doctor_hunt/apps/core/data/models/doctor/review.dart';
import 'package:doctor_hunt/apps/core/di/di.dart';
import 'package:doctor_hunt/apps/core/failure/failure.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../generated/translations.g.dart';
import '../../../../../core/data/session/user_session_manager.dart';
import '../../data/models/appointment/appointment.dart';

part 'appointments_event.dart';
part 'appointments_state.dart';

@injectable
class AppointmentsBloc extends Bloc<AppointmentsEvent, AppointmentsState> {
  final AppointmentRepository _appointmentRepository;
  final UserSessionManager _userSessionManager;
  final DoctorRepository _doctorRepository;

  AppointmentsBloc(
    this._appointmentRepository,
    this._userSessionManager, [
    DoctorRepository? doctorRepository,
  ])  : _doctorRepository = doctorRepository ?? getIt<DoctorRepository>(),
        super(AppointmentsInitial()) {
    on<FetchPatientAppointments>(_onFetchPatientAppointments);
    on<AddAppointmentReviewEvent>(_onAddAppointmentReview);
    on<CancelAppointmentEvent>(_onCancelAppointment);
    add(const FetchPatientAppointments());
  }

  Future<void> _onFetchPatientAppointments(
    FetchPatientAppointments event,
    Emitter<AppointmentsState> emit,
  ) async {
    emit(AppointmentsLoading());

    final userOption = _userSessionManager.getCurrentUser();
    if (userOption.isNone()) {
      emit(AppointmentsError(t.errors.someThingWentWrong));
      return;
    }

    final user = userOption.fold(() => null, (user) => user)!;

    await emit.forEach<Either<Failure, List<Appointment>>>(
      _appointmentRepository.getPatientAppointmentsStream(user.id),
      onData: (result) => result.fold(
        (failure) => AppointmentsError(failure.message),
        (appointments) => AppointmentsSuccess(appointments),
      ),
      onError: (error, stackTrace) => AppointmentsError(error.toString()),
    );
  }

  Future<void> _onAddAppointmentReview(
    AddAppointmentReviewEvent event,
    Emitter<AppointmentsState> emit,
  ) async {
    final currentState = state;
    emit(AddReviewLoading(event.appointment.id));

    final doctorResult = await _doctorRepository.getDoctorById(
      event.appointment.doctor.id,
    );

    await doctorResult.fold(
      (failure) async {
        emit(AddReviewError(failure.message, event.appointment.id));
        if (currentState is AppointmentsSuccess) {
          emit(AppointmentsSuccess(currentState.appointments));
        }
      },
      (freshDoctor) async {
        final updatedData = _calculateUpdatedDoctorAndAppointment(
          freshDoctor: freshDoctor,
          appointment: event.appointment,
          review: event.review,
        );

        final result = await _appointmentRepository.addReviewAndUpdateDoctor(
          updatedDoctor: updatedData.updatedDoctor,
          updatedAppointment: updatedData.updatedAppointment,
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
      },
    );
  }

  ({Doctor updatedDoctor, Appointment updatedAppointment})
      _calculateUpdatedDoctorAndAppointment({
    required Doctor freshDoctor,
    required Appointment appointment,
    required Review review,
  }) {
    final oldRating = freshDoctor.rating;

    final newReviews = List<Review>.from(oldRating.reviews)..add(review);
    final newTotalRating = newReviews.fold(
      0,
      (sum, item) => sum + item.rating,
    );
    final newAverage = newTotalRating / newReviews.length;

    final updatedRating = Rating(rating: newAverage, reviews: newReviews);
    final updatedDoctor = freshDoctor.copyWith(rating: updatedRating);
    final updatedAppointment = appointment.copyWith(
      review: review,
      doctor: updatedDoctor,
    );

    return (
      updatedDoctor: updatedDoctor,
      updatedAppointment: updatedAppointment,
    );
  }

  Future<void> _onCancelAppointment(
    CancelAppointmentEvent event,
    Emitter<AppointmentsState> emit,
  ) async {
    emit(CancelAppointmentLoading(event.appointmentId));

    final result = await _appointmentRepository.updateAppointmentStatus(
      event.appointmentId,
      AppointmentStatus.cancelled,
    );

    result.fold(
      (failure) {
        emit(CancelAppointmentError(failure.message, event.appointmentId));
      },
      (_) {
        emit(CancelAppointmentSuccess(event.appointmentId));
      },
    );
  }
}
