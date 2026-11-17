import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../data/models/location_result_model.dart';
import '../../data/repo/location_repository.dart';
import 'clinic_location_picker_event.dart';
import 'clinic_location_picker_state.dart';

EventTransformer<T> _debounce<T>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

@injectable
class ClinicLocationPickerBloc
    extends Bloc<ClinicLocationPickerEvent, ClinicLocationPickerState> {
  final LocationRepository _locationRepository;

  ClinicLocationPickerBloc(this._locationRepository)
      : super(const ClinicLocationPickerState()) {
    on<ClinicLocationPickerInitEvent>(_onInit);
    on<MapCenterChangedEvent>(
      _onMapCenterChanged,
      transformer: _debounce(const Duration(milliseconds: 500)),
    );
    on<LocateMeRequestedEvent>(_onLocateMeRequested);
    on<AddressChangedEvent>(_onAddressChanged);
    on<ConfirmLocationRequestedEvent>(_onConfirmLocationRequested);
    on<RemoveLocationRequestedEvent>(_onRemoveLocationRequested);
  }

  Future<void> _onInit(
    ClinicLocationPickerInitEvent event,
    Emitter<ClinicLocationPickerState> emit,
  ) async {
    if (event.initialLat != null && event.initialLng != null) {
      final initialCenter = LatLng(event.initialLat!, event.initialLng!);
      emit(
        state.copyWith(
          currentCenter: initialCenter,
          hasInitialLocation: true,
          address: event.initialAddress ?? '',
          animateToTarget: initialCenter,
        ),
      );

      if (event.initialAddress == null || event.initialAddress!.isEmpty) {
        await _fetchAddress(initialCenter, emit);
      }
    } else {
      // If no initial location, attempt GPS auto-detection gracefully
      add(const LocateMeRequestedEvent());
    }
  }

  Future<void> _onMapCenterChanged(
    MapCenterChangedEvent event,
    Emitter<ClinicLocationPickerState> emit,
  ) async {
    if (emit.isDone) return;
    emit(state.copyWith(currentCenter: event.center));
    await _fetchAddress(event.center, emit);
  }

  Future<void> _onLocateMeRequested(
    LocateMeRequestedEvent event,
    Emitter<ClinicLocationPickerState> emit,
  ) async {
    if (emit.isDone) return;
    emit(state.copyWith(isGpsLoading: true, clearErrorMessage: true));

    try {
      final result = await _locationRepository.getCurrentPosition();

      if (emit.isDone) return;

      await result.fold(
        (failure) async {
          if (!emit.isDone) {
            emit(
              state.copyWith(
                isGpsLoading: false,
                errorMessage: failure.message,
              ),
            );
          }
        },
        (position) async {
          final target = LatLng(position.latitude, position.longitude);
          if (!emit.isDone) {
            emit(
              state.copyWith(
                currentCenter: target,
                animateToTarget: target,
                isGpsLoading: false,
              ),
            );
          }
          await _fetchAddress(target, emit);
        },
      );
    } catch (e) {
      if (!emit.isDone) {
        emit(
          state.copyWith(
            isGpsLoading: false,
            errorMessage: e.toString(),
          ),
        );
      }
    }
  }

  Future<void> _fetchAddress(
    LatLng center,
    Emitter<ClinicLocationPickerState> emit,
  ) async {
    if (emit.isDone) return;
    emit(state.copyWith(isAddressLoading: true));

    try {
      final result = await _locationRepository.getAddressFromCoordinates(
        latitude: center.latitude,
        longitude: center.longitude,
      );

      if (emit.isDone) return;

      result.fold(
        (_) {
          if (!emit.isDone) {
            emit(state.copyWith(isAddressLoading: false));
          }
        },
        (address) {
          if (!emit.isDone) {
            emit(
              state.copyWith(
                address: address ?? '',
                isAddressLoading: false,
              ),
            );
          }
        },
      );
    } catch (_) {
      if (!emit.isDone) {
        emit(state.copyWith(isAddressLoading: false));
      }
    }
  }

  void _onAddressChanged(
    AddressChangedEvent event,
    Emitter<ClinicLocationPickerState> emit,
  ) {
    emit(state.copyWith(address: event.address));
  }

  void _onConfirmLocationRequested(
    ConfirmLocationRequestedEvent event,
    Emitter<ClinicLocationPickerState> emit,
  ) {
    final confirmedResult = LocationResultModel(
      latitude: state.currentCenter.latitude,
      longitude: state.currentCenter.longitude,
      address: state.address.trim().isNotEmpty ? state.address.trim() : null,
    );
    emit(state.copyWith(confirmedResult: confirmedResult));
  }

  void _onRemoveLocationRequested(
    RemoveLocationRequestedEvent event,
    Emitter<ClinicLocationPickerState> emit,
  ) {
    emit(state.copyWith(confirmedResult: const LocationResultModel.cleared()));
  }
}
