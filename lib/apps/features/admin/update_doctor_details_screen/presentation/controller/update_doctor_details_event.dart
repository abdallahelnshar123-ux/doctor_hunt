part of 'update_doctor_details_bloc.dart';

@immutable
sealed class UpdateDoctorDetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateDoctorDetailsRequested extends UpdateDoctorDetailsEvent {
  final Doctor doctor;
  final File? image;

  UpdateDoctorDetailsRequested({required this.doctor, required this.image});

  @override
  List<Object?> get props => [doctor, image];
}

class DeleteDoctorRequested extends UpdateDoctorDetailsEvent {
  final String doctorId;

  DeleteDoctorRequested({required this.doctorId});

  @override
  List<Object?> get props => [doctorId];
}

class PickDoctorUpdateImageRequested extends UpdateDoctorDetailsEvent {}
