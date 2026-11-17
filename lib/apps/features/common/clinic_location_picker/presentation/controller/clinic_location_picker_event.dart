import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

abstract class ClinicLocationPickerEvent extends Equatable {
  const ClinicLocationPickerEvent();

  @override
  List<Object?> get props => [];
}

class ClinicLocationPickerInitEvent extends ClinicLocationPickerEvent {
  final double? initialLat;
  final double? initialLng;
  final String? initialAddress;

  const ClinicLocationPickerInitEvent({
    this.initialLat,
    this.initialLng,
    this.initialAddress,
  });

  @override
  List<Object?> get props => [initialLat, initialLng, initialAddress];
}

class MapCenterChangedEvent extends ClinicLocationPickerEvent {
  final LatLng center;

  const MapCenterChangedEvent(this.center);

  @override
  List<Object?> get props => [center];
}

class LocateMeRequestedEvent extends ClinicLocationPickerEvent {
  const LocateMeRequestedEvent();
}

class AddressChangedEvent extends ClinicLocationPickerEvent {
  final String address;

  const AddressChangedEvent(this.address);

  @override
  List<Object?> get props => [address];
}

class ConfirmLocationRequestedEvent extends ClinicLocationPickerEvent {
  const ConfirmLocationRequestedEvent();
}

class RemoveLocationRequestedEvent extends ClinicLocationPickerEvent {
  const RemoveLocationRequestedEvent();
}
