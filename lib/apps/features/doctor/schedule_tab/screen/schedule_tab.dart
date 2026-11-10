import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation/controller/doctor_schedule_bloc.dart';
import '../presentation/controller/doctor_schedule_event.dart';
import '../presentation/controller/doctor_schedule_state.dart';
import '../widget/schedule_appointment_card.dart';
import '../widget/schedule_dropdown_widget.dart';

class ScheduleTab extends StatelessWidget {
  const ScheduleTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Column(
        children: [
          AppBar(title: Text(t.doctor.schedule.title)),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            child: Row(
              spacing: 15,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<DoctorScheduleBloc, DoctorScheduleState>(
                  buildWhen: (previous, current) =>
                      previous.filter != current.filter,
                  builder: (context, state) {
                    return Expanded(
                      child: ScheduleDropdownWidget(
                        selectedFilter: state.filter,
                        onChanged: (newValue) {
                          context.read<DoctorScheduleBloc>().add(
                            ChangeScheduleFilter(newValue),
                          );
                        },
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    context.read<DoctorScheduleBloc>().add(
                      const RefreshDoctorSchedule(),
                    );
                  },
                ),
                // InkWell(
                //   onTap: () {
                //     context.read<DoctorScheduleBloc>().add(
                //       const RefreshDoctorSchedule(),
                //     );
                //   },
                //   borderRadius: BorderRadius.circular(8),
                //   child: Container(
                //     padding: const EdgeInsets.all(10),
                //     decoration: BoxDecoration(
                //       border: Border.all(color: AppColors.borderDefault),
                //       borderRadius: BorderRadius.circular(8),
                //     ),
                //     child: Row(
                //       children: [
                //         const Icon(
                //           Icons.refresh,
                //           size: 20,
                //           color: AppColors.textSecondary,
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<DoctorScheduleBloc, DoctorScheduleState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.errorMessage != null) {
                  return Center(
                    child: Text(
                      state.errorMessage!,
                      style: context.medium16.statusError.rubik,
                    ),
                  );
                }

                final appointments = state.appointments;
                if (appointments == null || appointments.isEmpty) {
                  return Center(
                    child: Text(
                      t.doctor.schedule.noAppointments,
                      style: context.medium16.textTertiary.rubik,
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: appointments.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 15),
                  itemBuilder: (context, index) {
                    return ScheduleAppointmentCard(
                      appointment: appointments[index],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
