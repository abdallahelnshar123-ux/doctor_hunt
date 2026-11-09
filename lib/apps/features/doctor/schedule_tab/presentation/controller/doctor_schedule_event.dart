import 'package:equatable/equatable.dart';

import 'doctor_schedule_state.dart';

abstract class DoctorScheduleEvent extends Equatable {
  const DoctorScheduleEvent();

  @override
  List<Object?> get props => [];
}

class FetchDoctorSchedule extends DoctorScheduleEvent {
  const FetchDoctorSchedule();
}

class RefreshDoctorSchedule extends DoctorScheduleEvent {
  const RefreshDoctorSchedule();
}

class ChangeScheduleFilter extends DoctorScheduleEvent {
  final ScheduleFilter filter;

  const ChangeScheduleFilter(this.filter);

  @override
  List<Object?> get props => [filter];
}
