import 'package:doctor_hunt/apps/core/di/di.dart';
import 'package:doctor_hunt/apps/core/widgets/appointments_list_shimmer_widget.dart';
import 'package:doctor_hunt/apps/features/admin/admin_appointments_tab/presentation/controller/admin_appointments_event.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/snack_bar_utils.dart';
import '../../../../../core/widgets/app_container_with_shadow.dart';
import '../../../../../core/widgets/appointment_review_read_only_widget.dart';
import '../../../../../core/widgets/custom_cached_network_image.dart';
import '../../../../../core/widgets/main_empty_list_widget.dart';
import '../../../../common/auth/presentation/widgets/custom_elevated_button.dart';
import '../../../../patient/appointments_tab/data/models/appointment/appointment.dart';
import '../../../admin_doctors_tab/presentation/screens/admin_doctors_tab.dart';
import '../controller/admin_appointments_bloc.dart';
import '../controller/admin_appointments_state.dart';

part '../widget/admin_appointment_card.dart';
part '../widget/appointments_list_widget.dart';

class AdminAppointmentsTab extends StatelessWidget {
  const AdminAppointmentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: BlocProvider(
        create: (context) =>
            getIt<AdminAppointmentsBloc>()
              ..add(FetchAdminAppointmentsRequested()),
        child: Scaffold(
          appBar: AdminAppbar(title: t.admin.appointments_tab.title),
          body: DefaultTabController(
            initialIndex: 0,
            length: 3,
            child: Column(
              children: [
                TabBar(
                  overlayColor: WidgetStatePropertyAll(AppColors.transparent),
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
                  child:
                      BlocBuilder<
                        AdminAppointmentsBloc,
                        AdminAppointmentsState
                      >(
                        buildWhen: (previous, current) =>
                            current is AdminAppointmentsLoadedState ||
                            current is AdminAppointmentsErrorState ||
                            current is AdminAppointmentsLoadingState,
                        builder: (context, state) {
                          if (state is AdminAppointmentsLoadedState) {
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
                          if (state is AdminAppointmentsErrorState) {
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

                  // TabBarView(
                  //   children: [],
                  //   // children: [
                  //   //   ListView.separated(
                  //   //     itemBuilder: (context, index) => PatientAppointmentCard(),
                  //   //     separatorBuilder: (context, index) =>
                  //   //         const SizedBox(height: 15),
                  //   //     itemCount: 10,
                  //   //     padding: const EdgeInsets.symmetric(horizontal: 20),
                  //   //   ),
                  //   //   ListView.separated(
                  //   //     itemBuilder: (context, index) => PatientAppointmentCard(),
                  //   //     separatorBuilder: (context, index) =>
                  //   //         const SizedBox(height: 15),
                  //   //     itemCount: 10,
                  //   //     padding: const EdgeInsets.all(20),
                  //   //   ),
                  //   //   ListView.separated(
                  //   //     itemBuilder: (context, index) => PatientAppointmentCard(),
                  //   //     separatorBuilder: (context, index) =>
                  //   //         const SizedBox(height: 15),
                  //   //     itemCount: 10,
                  //   //     padding: const EdgeInsets.symmetric(horizontal: 20),
                  //   //   ),
                  //   // ],
                  // ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
