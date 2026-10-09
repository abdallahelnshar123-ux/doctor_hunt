import 'package:doctor_hunt/apps/core/widgets/app_scaffold.dart';
import 'package:doctor_hunt/apps/features/patient/appointments_tab/presentation/widget/patient_appointment_card.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';

import '../../../../../../generated/translations.g.dart';
import '../../../../../core/theme/app_colors.dart';

class PatientAppointmentsTab extends StatelessWidget {
  const PatientAppointmentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
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
                    child: TabBarView(
                      children: [
                        ListView.separated(
                          itemBuilder: (context, index) =>
                              PatientAppointmentCard(),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 15),
                          itemCount: 10,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                        ),
                        ListView.separated(
                          itemBuilder: (context, index) =>
                              PatientAppointmentCard(),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 15),
                          itemCount: 10,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                        ),
                        ListView.separated(
                          itemBuilder: (context, index) =>
                              PatientAppointmentCard(),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 15),
                          itemCount: 10,
                          padding: const EdgeInsets.all(20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
