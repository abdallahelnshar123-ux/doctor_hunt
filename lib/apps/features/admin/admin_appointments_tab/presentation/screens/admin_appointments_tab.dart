import 'package:doctor_hunt/apps/core/data/appointment/models/appointment.dart';
import 'package:doctor_hunt/apps/core/di/di.dart';
import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/widgets/appointment/appointment_card.dart';
import 'package:doctor_hunt/apps/core/widgets/appointments_list_shimmer_widget.dart';
import 'package:doctor_hunt/apps/core/widgets/main_empty_list_widget.dart';
import 'package:doctor_hunt/apps/features/common/appointments_management/presentation/controller/appointments_bloc.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '../widget/appointments_list_widget.dart';

class AdminAppointmentsTab extends StatelessWidget {
  const AdminAppointmentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: BlocProvider(
        create: (context) => getIt<AppointmentsBloc>(),
        child: DefaultTabController(
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
                  Tab(child: Text(t.patientAppointments.upcoming)),
                  Tab(child: Text(t.patientAppointments.completed)),
                  Tab(child: Text(t.patientAppointments.canceled)),
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
    );
  }
}
