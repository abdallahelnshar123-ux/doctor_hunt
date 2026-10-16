import 'package:doctor_hunt/apps/core/widgets/app_scaffold.dart';
import 'package:doctor_hunt/apps/core/widgets/appointments_list_shimmer_widget.dart';
import 'package:doctor_hunt/apps/core/widgets/custom_text_form_field.dart';
import 'package:doctor_hunt/apps/core/widgets/main_empty_list_widget.dart';
import 'package:doctor_hunt/apps/features/patient/appointments_tab/data/models/appointment/appointment.dart';
import 'package:doctor_hunt/apps/features/patient/appointments_tab/presentation/widget/patient_appointment_card.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../generated/translations.g.dart';
import '../../../../../core/data/models/doctor/review.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../common/auth/data/models/user/my_user.dart';
import '../controller/appointments_bloc.dart';

part '../widget/appointments_list_widget.dart';
part '../widget/review_input_widget.dart';

class PatientAppointmentsTab extends StatelessWidget {
  const PatientAppointmentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AppointmentsBloc>(),
      child: AppScaffold(
        bottomSafeArea: false,
        body: Column(
          spacing: 10,
          children: [
            AppBar(title: Text(t.patient_appointments.title)),
            Expanded(
              child: DefaultTabController(
                initialIndex: 0,
                length: 3,
                child: Column(
                  spacing: 10,
                  children: [
                    TabBar(
                      overlayColor: WidgetStatePropertyAll(
                        AppColors.transparent,
                      ),
                      onTap: (index) {},
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      dividerColor: AppColors.transparent,
                      indicator: BoxDecoration(
                        color: AppColors.brandPrimary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      labelStyle: context.medium12.white.rubik,
                      unselectedLabelStyle: context.medium12.brandPrimary.rubik,
                      tabAlignment: .fill,
                      indicatorSize: .tab,
                      indicatorAnimation: .elastic,
                      tabs: [
                        Tab(child: Text(t.patient_appointments.upcoming)),
                        Tab(child: Text(t.patient_appointments.completed)),
                        Tab(child: Text(t.patient_appointments.canceled)),
                      ],
                    ),
                    Expanded(
                      child: BlocBuilder<AppointmentsBloc, AppointmentsState>(
                        buildWhen: (previous, current) =>
                            current is AppointmentsSuccess ||
                            current is AppointmentsError ||
                            current is AppointmentsLoading,
                        builder: (context, state) {
                          if (state is AppointmentsSuccess) {
                            return TabBarView(
                              children: [
                                AppointmentsListWidget(
                                  allAppointmentsList: state.appointments,
                                  index: 0,
                                ),
                                AppointmentsListWidget(
                                  allAppointmentsList: state.appointments,
                                  index: 1,
                                ),
                                AppointmentsListWidget(
                                  allAppointmentsList: state.appointments,
                                  index: 2,
                                ),
                              ],
                            );
                          }
                          if (state is AppointmentsError) {
                            return Center(
                              child: Text(
                                state.message,
                                style: context.medium16.textSecondary.rubik,
                              ),
                            );
                          }
                          return const AppointmentsListShimmerWidget();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
