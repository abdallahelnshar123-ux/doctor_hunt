part of 'update_doctor_details_bloc.dart';

@immutable
sealed class UpdateDoctorDetailsEvent {}

class UpdateDoctorDetailsRequested extends UpdateDoctorDetailsEvent {
  final Doctor doctor;
  final File? image;

  UpdateDoctorDetailsRequested({required this.doctor, required this.image});
}

class DeleteDoctorRequested extends UpdateDoctorDetailsEvent {
  final String doctorId;

  DeleteDoctorRequested({required this.doctorId});
}

class PickDoctorUpdateImageRequested extends UpdateDoctorDetailsEvent {}
