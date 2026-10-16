part of 'update_doctor_details_bloc.dart';

@immutable
sealed class UpdateDoctorDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class UpdateDoctorDetailsInitial extends UpdateDoctorDetailsState {}

// Update Doctor Details States
final class UpdateDoctorDetailsLoading extends UpdateDoctorDetailsState {}

final class UpdateDoctorDetailsSuccess extends UpdateDoctorDetailsState {}

final class UpdateDoctorDetailsError extends UpdateDoctorDetailsState {
  final String message;

  UpdateDoctorDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}

// Delete Doctor States
final class DeleteDoctorFromEditLoading extends UpdateDoctorDetailsState {}

final class DeleteDoctorFromEditSuccess extends UpdateDoctorDetailsState {}

final class DeleteDoctorFromEditError extends UpdateDoctorDetailsState {
  final String message;

  DeleteDoctorFromEditError(this.message);

  @override
  List<Object?> get props => [message];
}

// Pick Image States
final class PickDoctorUpdateImageSuccessState extends UpdateDoctorDetailsState {
  final File image;

  PickDoctorUpdateImageSuccessState(this.image);

  @override
  List<Object?> get props => [image];
}

final class PickDoctorUpdateImageErrorState extends UpdateDoctorDetailsState {
  final String message;

  PickDoctorUpdateImageErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
