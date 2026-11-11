import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../apps/core/data/appointment/repo/appointment_repository.dart';
import '../../../../../../apps/core/data/models/doctor/rating.dart';
import '../../../../../../apps/core/data/models/doctor/review.dart';
import '../../../../../../apps/features/common/auth/domain/entity/user/doctor.dart';
import '../../../../../../apps/features/doctor/domain/repository/doctor_repository.dart';
import 'package:doctor_hunt/apps/core/data/appointment/models/appointment.dart';
import 'appointment_action_event.dart';
import 'appointment_action_state.dart';

@lazySingleton
class AppointmentActionBloc
    extends Bloc<AppointmentActionEvent, AppointmentActionState> {
  final AppointmentRepository _appointmentRepository;
  final DoctorRepository _doctorRepository;

  AppointmentActionBloc(this._appointmentRepository, this._doctorRepository)
    : super(AppointmentActionInitial()) {
    on<CancelAppointmentEvent>(_onCancelAppointment);
    on<CompleteAppointmentEvent>(_onCompleteAppointment);
    on<AddAppointmentReviewEvent>(_onAddAppointmentReview);
  }

  Future<void> _onCancelAppointment(
    CancelAppointmentEvent event,
    Emitter<AppointmentActionState> emit,
  ) async {
    emit(AppointmentActionLoading(event.appointmentId));

    final result = await _appointmentRepository.updateAppointmentStatus(
      event.appointmentId,
      AppointmentStatus.cancelled,
    );

    result.fold(
      (failure) {
        emit(AppointmentActionError(failure.message, event.appointmentId));
      },
      (_) {
        emit(AppointmentActionSuccess(event.appointmentId));
      },
    );
  }

  Future<void> _onCompleteAppointment(
    CompleteAppointmentEvent event,
    Emitter<AppointmentActionState> emit,
  ) async {
    emit(AppointmentActionLoading(event.appointmentId));

    final result = await _appointmentRepository.updateAppointmentStatus(
      event.appointmentId,
      AppointmentStatus.completed,
    );

    result.fold(
      (failure) {
        emit(AppointmentActionError(failure.message, event.appointmentId));
      },
      (_) {
        emit(AppointmentActionSuccess(event.appointmentId));
      },
    );
  }

  Future<void> _onAddAppointmentReview(
    AddAppointmentReviewEvent event,
    Emitter<AppointmentActionState> emit,
  ) async {
    emit(AppointmentActionLoading(event.appointment.id));

    final doctorResult = await _doctorRepository.getDoctorById(
      event.appointment.doctor.id,
    );

    await doctorResult.fold(
      (failure) async {
        emit(AppointmentActionError(failure.message, event.appointment.id));
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
            emit(AppointmentActionError(failure.message, event.appointment.id));
          },
          (_) {
            emit(AppointmentActionSuccess(event.appointment.id));
          },
        );
      },
    );
  }

  ({DoctorEntity updatedDoctor, Appointment updatedAppointment})
  _calculateUpdatedDoctorAndAppointment({
    required DoctorEntity freshDoctor,
    required Appointment appointment,
    required Review review,
  }) {
    final oldRating = freshDoctor.rating;

    final currentCount = oldRating.reviewsCount > 0
        ? oldRating.reviewsCount
        : oldRating.reviews.length;
    final currentSum = oldRating.totalRatingSum > 0
        ? oldRating.totalRatingSum
        : oldRating.reviews.fold(0.0, (sum, item) => sum + item.rating);

    final newCount = currentCount + 1;
    final newTotalRating = currentSum + review.rating;
    final newAverage = double.parse(
      (newTotalRating / newCount).toStringAsFixed(1),
    );

    final updatedRating = Rating(
      rating: newAverage,
      reviewsCount: newCount,
      totalRatingSum: newTotalRating,
      reviews: const [],
    );
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
}
