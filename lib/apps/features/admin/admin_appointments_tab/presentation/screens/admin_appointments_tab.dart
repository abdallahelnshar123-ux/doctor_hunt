import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../patient/appointments_tab/presentation/widget/patient_appointment_card.dart';
import '../../../admin_doctors_tab/presentation/screens/admin_doctors_tab.dart';

class AdminAppointmentsTab extends StatelessWidget {
  const AdminAppointmentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
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
                      padding: const EdgeInsets.all(20),
                    ),
                    ListView.separated(
                      itemBuilder: (context, index) =>
                          PatientAppointmentCard(),
                      separatorBuilder: (context, index) =>
                      const SizedBox(height: 15),
                      itemCount: 10,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
