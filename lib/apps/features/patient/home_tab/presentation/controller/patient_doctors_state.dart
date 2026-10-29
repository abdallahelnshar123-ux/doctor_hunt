part of 'patient_doctors_bloc.dart';

abstract class PatientDoctorsState extends Equatable {
  const PatientDoctorsState();

  @override
  List<Object?> get props => [];
}

class PatientDoctorsInitial extends PatientDoctorsState {}

class PatientDoctorsLoading extends PatientDoctorsState {}

class PatientDoctorsSuccess extends PatientDoctorsState {
  final List<DoctorEntity> doctors;
  final List<DoctorEntity> topRatedDoctors;
  final List<DoctorEntity> searchResults;
  final String? searchQuery;

  const PatientDoctorsSuccess({
    required this.doctors,
    required this.topRatedDoctors,
    this.searchResults = const [],
    this.searchQuery,
  });

  PatientDoctorsSuccess copyWith({
    List<DoctorEntity>? doctors,
    List<DoctorEntity>? topRatedDoctors,
    List<DoctorEntity>? searchResults,
    String? searchQuery,
  }) {
    return PatientDoctorsSuccess(
      doctors: doctors ?? this.doctors,
      topRatedDoctors: topRatedDoctors ?? this.topRatedDoctors,
      searchResults: searchResults ?? this.searchResults,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [
    doctors,
    topRatedDoctors,
    searchResults,
    searchQuery,
  ];
}

class PatientDoctorsError extends PatientDoctorsState {
  final String message;

  const PatientDoctorsError(this.message);

  @override
  List<Object?> get props => [message];
}
