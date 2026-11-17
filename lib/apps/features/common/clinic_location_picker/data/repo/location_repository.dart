import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:doctor_hunt/apps/core/failure/failure.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

import '../service/location_service.dart';

@lazySingleton
class LocationRepository {
  final LocationService _locationService;

  const LocationRepository(this._locationService);

  Future<Either<Failure, Position>> getCurrentPosition() async {
    try {
      final isServiceEnabled = await _locationService.isLocationServiceEnabled();
      if (!isServiceEnabled) {
        return Left(ServerFailure(t.clinicLocation.gpsDisabled));
      }

      var permission = await _locationService.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await _locationService.requestPermission();
        if (permission == LocationPermission.denied) {
          return Left(ServerFailure(t.clinicLocation.permissionDenied));
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Left(
          ServerFailure(t.clinicLocation.permissionPermanentlyDenied),
        );
      }

      final position = await _locationService.getCurrentPosition();
      return Right(position);
    } on TimeoutException {
      return Left(NetworkFailure(t.clinicLocation.offlineWarning));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  Future<Either<Failure, String?>> getAddressFromCoordinates({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final address = await _locationService.getAddressFromCoordinates(
        latitude: latitude,
        longitude: longitude,
      );
      return Right(address);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
