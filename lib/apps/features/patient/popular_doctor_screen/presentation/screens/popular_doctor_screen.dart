import 'package:doctor_hunt/apps/core/widgets/app_scaffold.dart';
import 'package:doctor_hunt/apps/core/widgets/main_app_bar.dart';
import 'package:doctor_hunt/apps/features/patient/main_screen/widget/doctor_card_wide.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../generated/app_assets.dart';
import '../../../../../../generated/style_atoms.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/app_container_with_shadow.dart';
import '../../../../../core/widgets/favorite_button_widget.dart';
import '../../../../../core/widgets/rating_widget.dart';
import '../../../home_tab/presentation/controller/patient_doctors_bloc.dart';

part '../widget/shimmer_widget.dart';

class PopularDoctorScreen extends StatelessWidget {
  const PopularDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        children: [
          MainAppBar(title: t.home.popularDoctors),
          Expanded(
            child: BlocBuilder<PatientDoctorsBloc, PatientDoctorsState>(
              buildWhen: (previous, current) =>
                  current is PatientDoctorsSuccess ||
                  current is PatientDoctorsLoading,
              builder: (context, state) {
                if (state is PatientDoctorsSuccess) {
                  if (state.doctors.isEmpty) {
                    return Container(
                      alignment: Alignment.center,
                      height: 330,
                      width: double.infinity,
                      child: Text(
                        t.admin.doctorsTab.noDoctorsFound,
                        style: context.medium10.black.rubik,
                      ),
                    );
                  }
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      final doctor = state.doctors[index];
                      return GestureDetector(
                        onTap: () {
                          PatientDoctorDetailsRoute(doctor).push(context);
                        },
                        child: DoctorCardWide(doctor: doctor),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 15),
                    itemCount: state.doctors.length,
                    padding: const EdgeInsets.all(20),
                  );
                }
                // Use same shimmer or create a specific one for popular doctors
                return ShimmerWidget();
              },
            ),

            // ListView.separated(
            //   padding: const EdgeInsets.all(20),
            //   itemBuilder: (context, index) => DoctorCardWide(
            //     doctor: Doctor(
            //       id: "id",
            //       name: 'hghghgh',
            //       adminId: 'kkid',
            //       specialty: Specialty.allergists,
            //       active: true,
            //       consultationFee: 0.0,
            //       rating: const Rating(rating: 0.0, reviews: []),
            //     ),
            //   ),
            //   separatorBuilder: (context, index) => const SizedBox(height: 15),
            //   itemCount: 10,
            // ),
          ),
        ],
      ),
    );
  }
}
