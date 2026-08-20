import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/features/auth/presentation/widgets/custom_elevated_button.dart';
import 'package:doctor_hunt/generated/app_assets.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/widgets/favorite_button_widget.dart';

class DoctorDetailsCard extends StatelessWidget {
  const DoctorDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      width: double.infinity,
      height: 185.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha(20),
            blurRadius: 25,
            spreadRadius: 0.5,
            offset: const Offset(0, 0),
          ),
        ],
        color: AppColors.bgPrimary,
      ),
      child: Column(
        crossAxisAlignment: .center,
        spacing: 15,
        children: [
          Expanded(
            child: Row(
              spacing: 15,
              children: [
                Expanded(flex: 3, child: _doctorImageWidget(context: context)),
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: .spaceAround,
                    children: [
                      Row(
                        crossAxisAlignment: .start,
                        spacing: 15,
                        children: [
                          Expanded(
                            child: _doctorDetailsWidget(context: context),
                          ),
                          FavoriteButtonWidget(),
                        ],
                      ),
                      _ratingWidget(context: context),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _buildBookNowButton(context: context),
        ],
      ),
    );
  }

  Widget _buildBookNowButton({required BuildContext context}) {
    return CustomElevatedButton(
      buttonWidth: 0.4.sw,
      paddingVertical: 10.w,
      borderRadius: 6,
      backgroundColor: AppColors.brandPrimary,
      onPressed: () {},
      child: Text('Book now', style: context.medium11.bgPrimary.rubik),
    );
  }

  Widget _ratingWidget({required BuildContext context}) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Row(
          spacing: 4,
          mainAxisAlignment: .center,
          children: List.generate(
            5,
            (index) => SvgPicture.asset(
              index != 4
                  ? AppAssets.icons.starIconRated.path
                  : AppAssets.icons.starIconUnrated.path,
              width: 12.w,
            ),
          ),
        ),
        Row(
          crossAxisAlignment: .center,
          spacing: 5,
          mainAxisAlignment: .end,
          children: [
            SvgPicture.asset(AppAssets.icons.sDollarIcon.path, width: 9.w),
            Text('25.00/ hours', style: context.light10.textSecondary.rubik),
          ],
        ),
      ],
    );
  }

  Widget _doctorDetailsWidget({required BuildContext context}) => Column(
    mainAxisAlignment: .spaceBetween,
    crossAxisAlignment: .start,
    children: [
      FittedBox(
        fit: .scaleDown,
        child: Text(
          'Dr. Shruti Kedia',
          style: context.medium16.textTertiary.rubik,
        ),
      ),
      FittedBox(
        fit: .scaleDown,
        child: Text(
          'Specialist Cardiologist',
          style: context.light11.textSecondary.rubik,
        ),
      ),
    ],
  );

  Widget _doctorImageWidget({required BuildContext context}) => Container(
    width: double.infinity,
    height: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      image: DecorationImage(
        image: AssetImage(AppAssets.images.testDoctorImage.path),
        fit: .cover,
      ),
    ),
  );
}
