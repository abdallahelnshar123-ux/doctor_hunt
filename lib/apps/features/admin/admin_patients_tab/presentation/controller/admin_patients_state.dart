part of 'admin_patients_bloc.dart';

abstract class AdminPatientsState extends Equatable {
  const AdminPatientsState();

  @override
  List<Object?> get props => [];
}

class AdminPatientsInitial extends AdminPatientsState {}

class AdminPatientsLoading extends AdminPatientsState {


  const AdminPatientsLoading(

  );


}

class AdminPatientsSuccess extends AdminPatientsState {
  final List<PatientEntity> allPatients;
  final List<PatientEntity>? searchPatients;
  final String searchQuery;
  final String? errorMessage;

  const AdminPatientsSuccess({
    required this.allPatients,
    this.searchPatients,
    this.searchQuery = '',
    this.errorMessage,
  });

  List<PatientEntity> get displayPatients => searchPatients ?? allPatients;

  AdminPatientsSuccess copyWith({
    List<PatientEntity>? allPatients,
    List<PatientEntity>? searchPatients,
    String? searchQuery,
    String? errorMessage,
    bool clearSearch = false,
  }) {
    return AdminPatientsSuccess(
      allPatients: allPatients ?? this.allPatients,
      searchPatients: clearSearch ? null : (searchPatients ?? this.searchPatients),
      searchQuery: clearSearch ? '' : (searchQuery ?? this.searchQuery),
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [allPatients, searchPatients, searchQuery, errorMessage];
}

class AdminPatientsError extends AdminPatientsState {
  final String message;

  const AdminPatientsError(this.message);

  @override
  List<Object> get props => [message];
}
