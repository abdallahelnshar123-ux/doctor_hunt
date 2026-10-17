part of 'favourite_doctors_bloc.dart';

abstract class FavouriteDoctorsEvent extends Equatable {
  const FavouriteDoctorsEvent();

  @override
  List<Object?> get props => [];
}

class LoadFavoritesEvent extends FavouriteDoctorsEvent {
  final List<Doctor> allDoctors;
  final List<String> favoriteDoctorIds;

  const LoadFavoritesEvent({
    required this.allDoctors,
    required this.favoriteDoctorIds,
  });

  @override
  List<Object?> get props => [allDoctors, favoriteDoctorIds];
}

class UpdateFavoriteIdsEvent extends FavouriteDoctorsEvent {
  final List<String> favoriteDoctorIds;

  const UpdateFavoriteIdsEvent(this.favoriteDoctorIds);

  @override
  List<Object?> get props => [favoriteDoctorIds];
}

class SearchFavouriteDoctorsRequested extends FavouriteDoctorsEvent {
  final String query;

  const SearchFavouriteDoctorsRequested(this.query);

  @override
  List<Object?> get props => [query];
}
