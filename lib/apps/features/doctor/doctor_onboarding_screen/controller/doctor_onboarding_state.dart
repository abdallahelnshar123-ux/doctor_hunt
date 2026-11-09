import 'dart:io';

import 'package:equatable/equatable.dart';

sealed class DoctorOnboardingState extends Equatable {
  const DoctorOnboardingState();

  @override
  List<Object?> get props => [];
}

final class DoctorOnboardingInitial extends DoctorOnboardingState {}

final class DoctorOnboardingLoading extends DoctorOnboardingState {}

final class DoctorOnboardingSuccess extends DoctorOnboardingState {}

final class DoctorOnboardingError extends DoctorOnboardingState {
  final String message;

  const DoctorOnboardingError(this.message);

  @override
  List<Object?> get props => [message];
}

final class PickDoctorOnboardingImageSuccessState
    extends DoctorOnboardingState {
  final File image;

  const PickDoctorOnboardingImageSuccessState(this.image);

  @override
  List<Object?> get props => [image];
}

final class PickDoctorOnboardingImageErrorState extends DoctorOnboardingState {
  final String message;

  const PickDoctorOnboardingImageErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
