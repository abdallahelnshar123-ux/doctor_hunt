import 'package:doctor_hunt/apps/core/data/models/doctor/doctor.dart';
import 'package:doctor_hunt/apps/core/widgets/app_scaffold.dart';
import 'package:doctor_hunt/apps/core/widgets/main_app_bar.dart';
import 'package:doctor_hunt/apps/features/patient/main_screen/widget/doctor_card_wide.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';

class PopularDoctorScreen extends StatelessWidget {
  const PopularDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        children: [
          MainAppBar(title: t.home.popular_doctors),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemBuilder: (context, index) => DoctorCardWide(
                doctor: Doctor(
                  id: "id",
                  name: 'hghghgh',
                  adminId: 'kkid',
                  specialty: Specialty.allergists,
                  active: true,
                ),
              ),
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
