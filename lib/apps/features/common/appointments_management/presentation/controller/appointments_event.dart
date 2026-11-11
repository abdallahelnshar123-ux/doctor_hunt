part of 'appointments_bloc.dart';

sealed class AppointmentsEvent extends Equatable {
  const AppointmentsEvent();

  @override
  List<Object?> get props => [];
}

class FetchAppointmentsRequested extends AppointmentsEvent {
  const FetchAppointmentsRequested();
}
