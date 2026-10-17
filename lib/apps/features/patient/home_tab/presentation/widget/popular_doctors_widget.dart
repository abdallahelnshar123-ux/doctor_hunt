import 'package:doctor_hunt/apps/core/router/app_routes.dart';
import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/features/patient/home_tab/presentation/controller/patient_doctors_bloc.dart';
import 'package:doctor_hunt/apps/features/patient/home_tab/presentation/widget/popular_doctors_item.dart';
import 'package:doctor_hunt/apps/features/patient/home_tab/presentation/widget/popular_doctors_shimmer.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularDoctorsWidget extends StatelessWidget {
  const PopularDoctorsWidget({super.key});

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
                t.home.popular_doctors,
                style: context.medium18.textTertiary.rubik,
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  const PopularDoctorsRoute().push(context);
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
        BlocBuilder<PatientDoctorsBloc, PatientDoctorsState>(
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
                    t.admin.doctors_tab.no_doctors_found,
                    style: context.medium10.black.rubik,
                  ),
                );
              }
              return SizedBox(
                height: 330,
                width: double.infinity,
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final doctor = state.doctors[index];
                    return GestureDetector(
                      onTap: () {
                        PatientDoctorDetailsRoute(doctor).push(context);
                      },
                      child: PopularDoctorsItem(doctor: doctor),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 15),
                  itemCount: state.doctors.length,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(20),
                ),
              );
            }
            // Use same shimmer or create a specific one for popular doctors
            return const SizedBox(
              height: 330,
              width: double.infinity,
              child: PopularDoctorsShimmer(),

              // TopRatedDoctorsShimmer(),
            );
          },
        ),
      ],
    );
  }
}
