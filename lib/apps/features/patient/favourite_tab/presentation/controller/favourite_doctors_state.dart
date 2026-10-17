part of 'favourite_doctors_bloc.dart';

abstract class FavouriteDoctorsState extends Equatable {
  const FavouriteDoctorsState();

  @override
  List<Object?> get props => [];
}

class FavouriteDoctorsInitial extends FavouriteDoctorsState {}

class FavouriteDoctorsLoading extends FavouriteDoctorsState {}

class FavouriteDoctorsSuccess extends FavouriteDoctorsState {
  final List<Doctor> allFavouriteDoctors;
  final List<Doctor> filteredDoctors;
  final String? searchQuery;

  const FavouriteDoctorsSuccess({
    required this.allFavouriteDoctors,
    required this.filteredDoctors,
    this.searchQuery,
  });

  FavouriteDoctorsSuccess copyWith({
    List<Doctor>? allFavouriteDoctors,
    List<Doctor>? filteredDoctors,
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
