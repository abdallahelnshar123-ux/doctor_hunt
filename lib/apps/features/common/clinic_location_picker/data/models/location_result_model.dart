import 'package:equatable/equatable.dart';

class LocationResultModel extends Equatable {
  final double? latitude;
  final double? longitude;
  final String? address;
  final bool isCleared;

  const LocationResultModel({
    this.latitude,
    this.longitude,
    this.address,
    this.isCleared = false,
  });

  const LocationResultModel.cleared()
      : latitude = null,
        longitude = null,
        address = null,
        isCleared = true;

  bool get hasLocation => !isCleared && latitude != null && longitude != null;

  @override
  List<Object?> get props => [latitude, longitude, address, isCleared];
}
