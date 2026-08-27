import 'package:doctor_hunt/apps/core/router/app_routes.dart';
import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/features/home_tab/presentation/widget/popular_doctors_item.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';

class PopularDoctorsWidget extends StatelessWidget {
  const PopularDoctorsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
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
                  const FindDoctorRoute().push(context);
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
        SizedBox(
          height: 330,
          width: double.infinity,
          child: ListView.separated(
            itemBuilder: (context, index) => const PopularDoctorsItem(),
            separatorBuilder: (context, index) => const SizedBox(width: 15),
            itemCount: 10,
            scrollDirection: .horizontal,
            padding: const EdgeInsets.all(20),
          ),
        ),
      ],
    );
  }
}
