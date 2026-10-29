import 'dart:io';

import 'package:equatable/equatable.dart';

sealed class UpdateDoctorDetailsState extends Equatable {
  const UpdateDoctorDetailsState();

  @override
  List<Object?> get props => [];
}

final class UpdateDoctorDetailsInitial extends UpdateDoctorDetailsState {}

final class UpdateDoctorDetailsLoading extends UpdateDoctorDetailsState {}

final class UpdateDoctorDetailsSuccess extends UpdateDoctorDetailsState {}

final class UpdateDoctorDetailsError extends UpdateDoctorDetailsState {
  final String message;

  const UpdateDoctorDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}

final class PickDoctorUpdateImageSuccessState extends UpdateDoctorDetailsState {
  final File image;

  const PickDoctorUpdateImageSuccessState(this.image);

  @override
  List<Object?> get props => [image];
}

final class PickDoctorUpdateImageErrorState extends UpdateDoctorDetailsState {
  final String message;

  const PickDoctorUpdateImageErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
