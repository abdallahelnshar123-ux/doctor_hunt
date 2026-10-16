import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import 'package:doctor_hunt/apps/core/data/models/doctor/doctor.dart';

part 'favourite_doctors_event.dart';
part 'favourite_doctors_state.dart';

EventTransformer<T> _debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

@injectable
class FavouriteDoctorsBloc
    extends Bloc<FavouriteDoctorsEvent, FavouriteDoctorsState> {
  FavouriteDoctorsBloc() : super(FavouriteDoctorsInitial()) {
    on<LoadFavoritesEvent>(_onLoadFavoritesEvent);
    on<UpdateFavoriteIdsEvent>(_onUpdateFavoriteIdsEvent);
    on<SearchFavouriteDoctorsRequested>(
      _onSearchFavouriteDoctorsRequested,
      transformer: _debounce(const Duration(milliseconds: 300)),
    );
  }

  void _onLoadFavoritesEvent(
    LoadFavoritesEvent event,
    Emitter<FavouriteDoctorsState> emit,
  ) {
    emit(FavouriteDoctorsLoading());

    if (event.favoriteDoctorIds.isEmpty) {
      emit(const FavouriteDoctorsSuccess(
        allFavouriteDoctors: [],
        filteredDoctors: [],
      ));
      return;
    }

    final favoriteDoctors = event.allDoctors
        .where((doc) => event.favoriteDoctorIds.contains(doc.id))
        .toList();

    emit(FavouriteDoctorsSuccess(
      allFavouriteDoctors: favoriteDoctors,
      filteredDoctors: favoriteDoctors,
    ));
  }

  void _onUpdateFavoriteIdsEvent(
    UpdateFavoriteIdsEvent event,
    Emitter<FavouriteDoctorsState> emit,
  ) {
    if (state is FavouriteDoctorsSuccess) {
      final currentState = state as FavouriteDoctorsSuccess;

      // Filter the already loaded favorite doctors to remove any that are no longer in the favorite IDs list
      final updatedFavouriteDoctors = currentState.allFavouriteDoctors
          .where((doc) => event.favoriteDoctorIds.contains(doc.id))
          .toList();

      // Apply the same removal to the currently filtered list (if searching)
      final updatedFilteredDoctors = currentState.filteredDoctors
          .where((doc) => event.favoriteDoctorIds.contains(doc.id))
          .toList();

      emit(currentState.copyWith(
        allFavouriteDoctors: updatedFavouriteDoctors,
        filteredDoctors: updatedFilteredDoctors,
      ));
    }
  }

  void _onSearchFavouriteDoctorsRequested(
    SearchFavouriteDoctorsRequested event,
    Emitter<FavouriteDoctorsState> emit,
  ) {
    final currentState = state;
    if (currentState is FavouriteDoctorsSuccess) {
      if (event.query == currentState.searchQuery) return;

      final trimmedQuery = event.query.trim().toLowerCase();
      final List<Doctor> filtered;

      if (trimmedQuery.isEmpty) {
        filtered = currentState.allFavouriteDoctors;
      } else {
        filtered = currentState.allFavouriteDoctors.where((doctor) {
          final nameMatches = doctor.name.toLowerCase().contains(trimmedQuery);
          final specialtyMatches =
              doctor.specialty.name.toLowerCase().contains(trimmedQuery);
          return nameMatches || specialtyMatches;
        }).toList();
      }

      emit(currentState.copyWith(
        searchQuery: event.query,
        filteredDoctors: filtered,
      ));
    }
  }
}
