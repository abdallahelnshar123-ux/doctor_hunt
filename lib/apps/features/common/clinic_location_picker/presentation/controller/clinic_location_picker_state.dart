import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

import '../../data/models/location_result_model.dart';

class ClinicLocationPickerState extends Equatable {
  static const LatLng defaultLocation = LatLng(30.0444, 31.2357); // Cairo / Default

  final LatLng currentCenter;
  final String address;
  final bool isAddressLoading;
  final bool isGpsLoading;
  final bool hasInitialLocation;
  final String? errorMessage;
  final LocationResultModel? confirmedResult;
  final LatLng? animateToTarget;

  const ClinicLocationPickerState({
    this.currentCenter = defaultLocation,
    this.address = '',
    this.isAddressLoading = false,
    this.isGpsLoading = false,
    this.hasInitialLocation = false,
    this.errorMessage,
    this.confirmedResult,
    this.animateToTarget,
  });

  ClinicLocationPickerState copyWith({
    LatLng? currentCenter,
    String? address,
    bool? isAddressLoading,
    bool? isGpsLoading,
    bool? hasInitialLocation,
    String? errorMessage,
    bool clearErrorMessage = false,
    LocationResultModel? confirmedResult,
    LatLng? animateToTarget,
    bool clearAnimateTarget = false,
  }) {
    return ClinicLocationPickerState(
      currentCenter: currentCenter ?? this.currentCenter,
      address: address ?? this.address,
      isAddressLoading: isAddressLoading ?? this.isAddressLoading,
      isGpsLoading: isGpsLoading ?? this.isGpsLoading,
      hasInitialLocation: hasInitialLocation ?? this.hasInitialLocation,
      errorMessage: clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
      confirmedResult: confirmedResult ?? this.confirmedResult,
      animateToTarget: clearAnimateTarget ? null : (animateToTarget ?? this.animateToTarget),
    );
  }

  @override
  List<Object?> get props => [
        currentCenter,
        address,
        isAddressLoading,
        isGpsLoading,
        hasInitialLocation,
        errorMessage,
        confirmedResult,
        animateToTarget,
      ];
}
