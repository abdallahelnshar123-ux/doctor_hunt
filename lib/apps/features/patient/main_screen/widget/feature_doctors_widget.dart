import 'package:doctor_hunt/apps/core/router/app_routes.dart';
import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/features/patient/main_screen/widget/feature_doctors_shimmer.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../admin/add_doctor_screen/presentation/controller/doctor_bloc.dart';
import 'feature_doctors_item.dart';

class FeatureDoctorsWidget extends StatelessWidget {
  const FeatureDoctorsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      mainAxisAlignment: .start,
      crossAxisAlignment: .start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            spacing: 5,
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(
                t.home.feature_doctor,
                style: context.medium18.textTertiary.rubik,
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  const AppointmentRoute().push(context);
                },
                child: Row(
                  spacing: 5,
                  children: [
                    Text(
                      t.home.see_all,
                      style: context.light12.textSecondary.rubik,
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        BlocBuilder<DoctorBloc, DoctorState>(
          buildWhen: (previous, current) =>
              current is GetDoctorsSuccessState ||
              current is GetDoctorsLoadingState,

          builder: (context, state) {
            if (state is GetDoctorsSuccessState) {
              if (state.allDoctors.isEmpty) {
                return Container(
                  alignment: .center,
                  height: 190,
                  width: double.infinity,
                  child: Text(
                    t.admin.doctors_tab.no_doctors_found,
                    style: context.medium10.black.rubik,
                  ),
                );
              }
              return SizedBox(
                height: 190,
                width: double.infinity,
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    var doctor = state.allDoctors[index];
                    return GestureDetector(
                      onTap: () {
                        PatientDoctorDetailsRoute(doctor).push(context);
                      },
                      child: FeatureDoctorsItem(doctor: doctor),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 15),
                  itemCount: state.allDoctors.length,
                  scrollDirection: .horizontal,
                  padding: const EdgeInsets.all(20),
                ),
              );
            }
            return SizedBox(
              height: 190,
              width: double.infinity,
              child: FeatureDoctorsShimmer(),
            );
          },
        ),
      ],
    );
  }
}
