import 'package:doctor_hunt/apps/core/widgets/app_scaffold.dart';
import 'package:doctor_hunt/apps/core/widgets/main_app_bar.dart';
import 'package:doctor_hunt/apps/core/widgets/search_text_field_widget.dart';
import 'package:doctor_hunt/apps/features/patient/main_screen/widget/doctor_card_wide.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';

import '../../../../../core/data/models/doctor/doctor.dart';
import '../../../../../core/data/models/doctor/rating.dart';

class FindDoctorsScreen extends StatelessWidget {
  const FindDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        children: [
          MainAppBar(title: t.doctor_details.find_doctors),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                  child: SearchTextFieldWidget(),
                ),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) => DoctorCardWide(
                      doctor: Doctor(
                        id: "id",
                        name: 'hghghgh',
                        adminId: 'kkid',
                        specialty: Specialty.allergists,
                        active: true,
                        consultationFee: 0.0,
                        rating: const Rating(rating: 0.0, reviews: []),
                      ),
                    ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 15),
                    itemCount: 10,
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
