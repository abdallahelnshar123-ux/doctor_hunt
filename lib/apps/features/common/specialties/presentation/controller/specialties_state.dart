import 'package:doctor_hunt/apps/features/common/specialties/data/models/specialty_model.dart';
import 'package:equatable/equatable.dart';

enum SpecialtiesStatus { initial, loading, success, failure }

class SpecialtiesState extends Equatable {
  final SpecialtiesStatus status;
  final List<SpecialtyModel> specialties;
  final String? failureMessage;
  final String? actionSuccessMessage;

  const SpecialtiesState({
    this.status = SpecialtiesStatus.initial,
    this.specialties = const [],
    this.failureMessage,
    this.actionSuccessMessage,
  });

  bool get isLoading => status == SpecialtiesStatus.loading;

  SpecialtiesState copyWith({
    SpecialtiesStatus? status,
    List<SpecialtyModel>? specialties,
    String? failureMessage,
    String? actionSuccessMessage,
    bool clearActionMessage = false,
    bool clearFailure = false,
  }) {
    return SpecialtiesState(
      status: status ?? this.status,
      specialties: specialties ?? this.specialties,
      failureMessage: clearFailure
          ? null
          : (failureMessage ?? this.failureMessage),
      actionSuccessMessage: clearActionMessage
          ? null
          : (actionSuccessMessage ?? this.actionSuccessMessage),
    );
  }

  @override
  List<Object?> get props => [
    status,
    specialties,
    failureMessage,
    actionSuccessMessage,
  ];
}
