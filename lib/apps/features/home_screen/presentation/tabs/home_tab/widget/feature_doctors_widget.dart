import 'package:doctor_hunt/apps/core/utils/app_colors.dart';
import 'package:doctor_hunt/apps/features/home_screen/presentation/tabs/home_tab/widget/feature_doctors_item.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeatureDoctorsWidget extends StatelessWidget {
  const FeatureDoctorsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
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
                'Popular Doctors',
                style: context.medium18.textTertiary.rubik,
              ),
              Spacer(),
              Text('See all', style: context.light12.textSecondary.rubik),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 130.w,
          width: double.infinity,
          child: ListView.separated(
            itemBuilder: (context, index) => const FeatureDoctorsItem(),
            separatorBuilder: (context, index) => const SizedBox(width: 15),
            itemCount: 10,
            scrollDirection: .horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
          ),
        ),
      ],
    );
  }
}
