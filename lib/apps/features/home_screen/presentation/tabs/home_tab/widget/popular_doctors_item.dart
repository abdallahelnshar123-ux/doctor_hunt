import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/generated/app_assets.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PopularDoctorsItem extends StatelessWidget {
  const PopularDoctorsItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: .antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: AppColors.bgPrimary,
      ),
      width: 190.w,
      child: Column(
        crossAxisAlignment: .center,
        children: [
          Expanded(
            child: Image.asset(
              AppAssets.images.testDoctorImage.path,
              fit: .cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsetsGeometry.all(10),
            child: Column(
              spacing: 5,
              crossAxisAlignment: .center,
              children: [
                FittedBox(
                  fit: .scaleDown,
                  child: Text(
                    'Doctor name',
                    style: context.medium18.textTertiary.rubik,
                  ),
                ),
                Text(
                  'Medicine Specialist',
                  style: context.light12.textSecondary80.rubik,
                ),
                Row(
                  spacing: 5,
                  mainAxisAlignment: .center,
                  children: List.generate(
                    5,
                    (index) => SvgPicture.asset(
                      index != 4
                          ? AppAssets.icons.starIconRated.path
                          : AppAssets.icons.starIconUnrated.path,
                      width: 13.w,
                    ),
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
