import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LocationService {
  const LocationService();

  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  Future<LocationPermission> checkPermission() async {
    return await Geolocator.checkPermission();
  }

  Future<LocationPermission> requestPermission() async {
    return await Geolocator.requestPermission();
  }

  Future<Position> getCurrentPosition() async {
    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 12),
      ),
    );
  }

  Future<String?> getAddressFromCoordinates({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final placemarks = await Geocoding().placemarkFromCoordinates(
        latitude,
        longitude,
      );
      if (placemarks.isEmpty) return null;

      final place = placemarks.first;
      final parts = <String>[];

      final street = place.street?.trim();
      if (street != null && street.isNotEmpty) {
        parts.add(street);
      }

      final subLocality = place.subLocality?.trim();
      if (subLocality != null &&
          subLocality.isNotEmpty &&
          subLocality != street &&
          !parts.contains(subLocality)) {
        parts.add(subLocality);
      }

      final locality = place.locality?.trim();
      if (locality != null && locality.isNotEmpty && !parts.contains(locality)) {
        parts.add(locality);
      }

      final adminArea = place.administrativeArea?.trim();
      if (adminArea != null &&
          adminArea.isNotEmpty &&
          !parts.contains(adminArea)) {
        parts.add(adminArea);
      }

      final country = place.country?.trim();
      if (country != null && country.isNotEmpty && !parts.contains(country)) {
        parts.add(country);
      }

      return parts.isNotEmpty ? parts.join(', ') : null;
    } catch (_) {
      // Graceful fallback for geocoding failures
      return null;
    }
  }
}
