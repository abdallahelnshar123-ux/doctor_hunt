part of 'admin_patient_action_bloc.dart';

@immutable
sealed class AdminPatientActionState extends Equatable {
  const AdminPatientActionState();

  @override
  List<Object?> get props => [];
}

final class AdminPatientActionInitial extends AdminPatientActionState {}

final class TogglePatientActiveStatusLoading extends AdminPatientActionState {}

final class TogglePatientActiveStatusSuccess extends AdminPatientActionState {}

final class TogglePatientActiveStatusError extends AdminPatientActionState {
  final String message;

  const TogglePatientActiveStatusError(this.message);

  @override
  List<Object?> get props => [message];
}
