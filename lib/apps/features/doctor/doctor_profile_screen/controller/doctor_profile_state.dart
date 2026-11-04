import 'dart:io';

import 'package:equatable/equatable.dart';

sealed class DoctorProfileState extends Equatable {
  const DoctorProfileState();

  @override
  List<Object?> get props => [];
}

final class UpdateDoctorDetailsInitial extends DoctorProfileState {}

final class UpdateDoctorDetailsLoading extends DoctorProfileState {}

final class UpdateDoctorDetailsSuccess extends DoctorProfileState {}

final class UpdateDoctorDetailsError extends DoctorProfileState {
  final String message;

  const UpdateDoctorDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}

final class PickDoctorUpdateImageSuccessState extends DoctorProfileState {
  final File image;

  const PickDoctorUpdateImageSuccessState(this.image);

  @override
  List<Object?> get props => [image];
}

final class PickDoctorUpdateImageErrorState extends DoctorProfileState {
  final String message;

  const PickDoctorUpdateImageErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
