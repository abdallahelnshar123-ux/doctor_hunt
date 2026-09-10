part of 'doctor_bloc.dart';

@immutable
sealed class DoctorState {}

final class DoctorInitial extends DoctorState {}

final class AddDoctorLoadingState extends DoctorState {}

final class AddDoctorSuccessState extends DoctorState {}

final class AddDoctorErrorState extends DoctorState {
  final String message;

  AddDoctorErrorState(this.message);
}

/// =========================  pick image states ==========================

final class PickDoctorImageSuccessState extends DoctorState {
  final File image;

  PickDoctorImageSuccessState(this.image);
}

final class PickDoctorImageCancelledState extends DoctorState {
  PickDoctorImageCancelledState();
}

final class PickDoctorImageErrorState extends DoctorState {
  final String message;

  PickDoctorImageErrorState(this.message);
}
