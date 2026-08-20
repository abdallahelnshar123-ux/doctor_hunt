import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/generated/app_assets.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LiveDoctorsItem extends StatelessWidget {
  const LiveDoctorsItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        image: DecorationImage(
          colorFilter: ColorFilter.mode(AppColors.black.withAlpha(77), .darken),
          image: AssetImage(AppAssets.images.testDoctorImage.path),
          fit: .cover,
        ),
      ),
      width: 120.w,
      child: Stack(
        alignment: .topRight,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.badge,
              borderRadius: BorderRadius.circular(3),
            ),
            child: Row(
              mainAxisAlignment: .end,
              mainAxisSize: .min,
              spacing: 4,
              children: [
                CircleAvatar(radius: 3),
                Text('Live', style: context.medium8.bgPrimary.rubik),
              ],
            ),
          ),
          Center(
            child: Icon(
              Icons.play_circle_outline_outlined,
              color: AppColors.bgPrimary,
              size: 30.w,
            ),
          ),
        ],
      ),
    );
  }
}
