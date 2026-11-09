import 'package:doctor_hunt/apps/features/common/specialties/data/models/specialty_model.dart';
import 'package:equatable/equatable.dart';

abstract class SpecialtiesEvent extends Equatable {
  const SpecialtiesEvent();

  @override
  List<Object?> get props => [];
}

class GetSpecialtiesEvent extends SpecialtiesEvent {
  const GetSpecialtiesEvent();
}

class AddSpecialtyEvent extends SpecialtiesEvent {
  final String en;
  final String ar;

  const AddSpecialtyEvent({required this.en, required this.ar});

  @override
  List<Object?> get props => [en, ar];
}

class UpdateSpecialtyEvent extends SpecialtiesEvent {
  final SpecialtyModel specialty;

  const UpdateSpecialtyEvent(this.specialty);

  @override
  List<Object?> get props => [specialty];
}
