part of 'admin_doctors_bloc.dart';

abstract class AdminDoctorsEvent extends Equatable {
  const AdminDoctorsEvent();

  @override
  List<Object?> get props => [];
}

class AdminGetDoctorsRequested extends AdminDoctorsEvent {
  final String adminId;

  const AdminGetDoctorsRequested(this.adminId);

  @override
  List<Object?> get props => [adminId];
}

class AdminFilterDoctorsRequested extends AdminDoctorsEvent {
  final Specialty? selectedSpecialty;

  const AdminFilterDoctorsRequested(this.selectedSpecialty);

  @override
  List<Object?> get props => [selectedSpecialty];
}

class AdminSearchDoctorsRequested extends AdminDoctorsEvent {
  final String query;

  const AdminSearchDoctorsRequested(this.query);

  @override
  List<Object?> get props => [query];
}
