part of 'add_doctors_bloc.dart';

@immutable
sealed class AddDoctorsState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class DoctorInitial extends AddDoctorsState {}

final class AddDoctorLoadingState extends AddDoctorsState {}

final class AddDoctorSuccessState extends AddDoctorsState {}

final class AddDoctorErrorState extends AddDoctorsState {
  final String message;

  AddDoctorErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

/// =========================  pick image states ==========================

final class PickDoctorImageSuccessState extends AddDoctorsState {
  final File image;

  PickDoctorImageSuccessState(this.image);

  @override
  List<Object?> get props => [image];
}

final class PickDoctorImageCancelledState extends AddDoctorsState {}

final class PickDoctorImageErrorState extends AddDoctorsState {
  final String message;

  PickDoctorImageErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
