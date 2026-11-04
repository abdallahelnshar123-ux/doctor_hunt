import 'dart:io';

import 'package:doctor_hunt/apps/features/common/specialties/data/models/specialty_model.dart';
import 'package:equatable/equatable.dart';

sealed class DoctorProfileEvent extends Equatable {
  const DoctorProfileEvent();

  @override
  List<Object?> get props => [];
}

class UpdateDoctorDetailsRequested extends DoctorProfileEvent {
  final String? name;
  final SpecialtyModel? specialty;
  final double? consultationFee;
  final String? phone;
  final bool? active;
  final File? image;

  const UpdateDoctorDetailsRequested({
    this.name,
    this.specialty,
    this.consultationFee,
    this.phone,
    this.active,
    this.image,
  });

  @override
  List<Object?> get props => [
    name,
    specialty,
    consultationFee,
    phone,
    active,
    image,
  ];
}

class PickDoctorUpdateImageRequested extends DoctorProfileEvent {}
