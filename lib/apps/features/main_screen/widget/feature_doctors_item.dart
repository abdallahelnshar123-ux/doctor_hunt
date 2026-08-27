import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/widgets/app_container_with_shadow.dart';
import 'package:doctor_hunt/generated/app_assets.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FeatureDoctorsItem extends StatelessWidget {
  const FeatureDoctorsItem({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainerWithShadow(
      padding: EdgeInsets.all(8),
      clipBehavior: .antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: AppColors.bgPrimary,
      ),
      width: 105,
      child: Column(
        spacing: 5,
        crossAxisAlignment: .center,
        children: [
          Row(
            spacing: 5,
            children: [
              GestureDetector(
                onTap: () {},
                child: Icon(Icons.favorite, color: AppColors.badge, size: 15),
              ),
              Spacer(),
              SvgPicture.asset(AppAssets.icons.starIconRated.path, width: 15),
              Text('5.0', style: context.medium10.black.rubik),
            ],
          ),
          Expanded(
            child: CircleAvatar(
              maxRadius: double.infinity,
              foregroundImage: AssetImage(
                AppAssets.images.testDoctorImage.path,
              ),
            ),
          ),
          FittedBox(
            fit: .scaleDown,
            child: Text(
              'Doctor name',
              style: context.medium16.textTertiary.rubik,
            ),
          ),

          FittedBox(
            fit: .scaleDown,
            child: Row(
              spacing: 5,
              mainAxisAlignment: .center,
              children: [
                SvgPicture.asset(AppAssets.icons.sDollarIcon.path, width: 8),
                Text('25.00/ hours', style: context.light8.textSecondary.rubik),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
