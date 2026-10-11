part of 'admin_doctors_bloc.dart';

abstract class AdminDoctorsState extends Equatable {
  const AdminDoctorsState();

  @override
  List<Object?> get props => [];
}

class AdminDoctorsInitial extends AdminDoctorsState {}

class AdminDoctorsLoading extends AdminDoctorsState {}

class AdminDoctorsSuccess extends AdminDoctorsState {
  final List<Doctor> allDoctors;
  final List<Doctor> filteredDoctors;
  final List<Doctor> searchDoctors;
  final List<Map<Specialty, int>> specialtyCounts;
  final int activeDoctorsCount;
  final Specialty? selectedSpecialty;
  final String searchQuery;

  const AdminDoctorsSuccess({
    required this.allDoctors,
    required this.specialtyCounts,
    required this.activeDoctorsCount,
    this.filteredDoctors = const [],
    this.searchDoctors = const [],
    this.selectedSpecialty,
    this.searchQuery = '',
  });

  AdminDoctorsSuccess copyWith({
    List<Doctor>? allDoctors,
    List<Doctor>? filteredDoctors,
    List<Doctor>? searchDoctors,
    List<Map<Specialty, int>>? specialtyCounts,
    int? activeDoctorsCount,
    Specialty? selectedSpecialty,
    String? searchQuery,
    bool clearSpecialty = false,
  }) {
    return AdminDoctorsSuccess(
      allDoctors: allDoctors ?? this.allDoctors,
      filteredDoctors: filteredDoctors ?? this.filteredDoctors,
      searchDoctors: searchDoctors ?? this.searchDoctors,
      specialtyCounts: specialtyCounts ?? this.specialtyCounts,
      activeDoctorsCount: activeDoctorsCount ?? this.activeDoctorsCount,
      selectedSpecialty: clearSpecialty
          ? null
          : (selectedSpecialty ?? this.selectedSpecialty),
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [
    allDoctors,
    filteredDoctors,
    searchDoctors,
    specialtyCounts,
    activeDoctorsCount,
    selectedSpecialty,
    searchQuery,
  ];
}

class AdminDoctorsError extends AdminDoctorsState {
  final String message;

  const AdminDoctorsError(this.message);

  @override
  List<Object?> get props => [message];
}
