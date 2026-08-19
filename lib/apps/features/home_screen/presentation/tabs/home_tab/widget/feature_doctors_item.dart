import 'package:doctor_hunt/apps/core/utils/app_assets.dart';
import 'package:doctor_hunt/apps/core/utils/app_colors.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FeatureDoctorsItem extends StatelessWidget {
  const FeatureDoctorsItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      clipBehavior: .antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: AppColors.bgPrimary,
      ),
      width: 96.w,
      child: Column(
        spacing: 5,
        crossAxisAlignment: .center,
        children: [
          Row(
            spacing: 5,
            children: [
              GestureDetector(
                onTap: () {},
                child: Icon(Icons.favorite, color: AppColors.badge, size: 12.w),
              ),
              Spacer(),
              SvgPicture.asset(AppAssets.starIconRated, width: 10.w),
              Text('5.0', style: context.medium8.black.rubik),
            ],
          ),
          Expanded(
            child: CircleAvatar(
              maxRadius: double.infinity,
              foregroundImage: AssetImage(AppAssets.testImageDoctor),
            ),
          ),
          FittedBox(
            fit: .scaleDown,
            child: Text(
              'Doctor name',
              style: context.medium16.textTertiary.rubik,
            ),
          ),

          Row(
            spacing: 5,
            mainAxisAlignment: .center,
            children: [
              SvgPicture.asset(AppAssets.sDollarIcon, width: 8.w),
              Text('25.00/ hours', style: context.light8.textSecondary.rubik),
            ],
          ),
        ],
      ),
    );
  }
}
