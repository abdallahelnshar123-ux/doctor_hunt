import 'dart:io';

import 'package:doctor_hunt/apps/core/data/models/doctor/doctor_availability.dart';
import 'package:equatable/equatable.dart';

sealed class DoctorOnboardingEvent extends Equatable {
  const DoctorOnboardingEvent();

  @override
  List<Object?> get props => [];
}

class PickDoctorOnboardingImageRequested extends DoctorOnboardingEvent {}

class SaveDoctorOnboardingRequested extends DoctorOnboardingEvent {
  final File? image;
  final String phone;
  final double consultationFee;
  final DoctorAvailability availability;
  final double? latitude;
  final double? longitude;
  final String? clinicAddress;
  final String bio;

  const SaveDoctorOnboardingRequested({
    this.image,
    required this.phone,
    required this.consultationFee,
    required this.availability,
    this.latitude,
    this.longitude,
    this.clinicAddress,
    required this.bio,
  });

  @override
  List<Object?> get props => [
        image,
        phone,
        consultationFee,
        availability,
        latitude,
        longitude,
        clinicAddress,
        bio,
      ];
}
