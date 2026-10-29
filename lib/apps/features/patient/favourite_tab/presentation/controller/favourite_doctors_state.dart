part of 'favourite_doctors_bloc.dart';

abstract class FavouriteDoctorsState extends Equatable {
  const FavouriteDoctorsState();

  @override
  List<Object?> get props => [];
}

class FavouriteDoctorsInitial extends FavouriteDoctorsState {}

class FavouriteDoctorsLoading extends FavouriteDoctorsState {}

class FavouriteDoctorsSuccess extends FavouriteDoctorsState {
  final List<DoctorEntity> allFavouriteDoctors;
  final List<DoctorEntity> filteredDoctors;
  final String? searchQuery;

  const FavouriteDoctorsSuccess({
    required this.allFavouriteDoctors,
    required this.filteredDoctors,
    this.searchQuery,
  });

  FavouriteDoctorsSuccess copyWith({
    List<DoctorEntity>? allFavouriteDoctors,
    List<DoctorEntity>? filteredDoctors,
    String? searchQuery,
  }) {
    return FavouriteDoctorsSuccess(
      allFavouriteDoctors: allFavouriteDoctors ?? this.allFavouriteDoctors,
      filteredDoctors: filteredDoctors ?? this.filteredDoctors,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [
    allFavouriteDoctors,
    filteredDoctors,
    searchQuery,
  ];
}
