import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../../generated/translations.g.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/appointments_list_shimmer_widget.dart';
import '../controller/appointments_bloc.dart';
import 'appointments_list_widget.dart';

class AppointmentsView extends StatelessWidget {
  const AppointmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AppointmentsBloc>(),
      child: DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Column(
          children: [
            TabBar(
              overlayColor: const WidgetStatePropertyAll(
                AppColors.transparent,
              ),
              onTap: (index) {},
              padding: const EdgeInsets.symmetric(horizontal: 20),
              dividerColor: AppColors.transparent,
              indicator: BoxDecoration(
                color: AppColors.brandPrimary,
                borderRadius: BorderRadius.circular(6),
              ),
              labelStyle: context.medium12.white.rubik,
              unselectedLabelStyle: context.medium12.brandPrimary.rubik,
              tabAlignment: TabAlignment.fill,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorAnimation: TabIndicatorAnimation.elastic,
              tabs: [
                Tab(child: Text(t.patientAppointments.upcoming)),
                Tab(child: Text(t.patientAppointments.completed)),
                Tab(child: Text(t.patientAppointments.canceled)),
              ],
            ),
            const SizedBox(height: 10),
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
    );
  }
}
