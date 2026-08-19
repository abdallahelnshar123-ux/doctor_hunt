import 'package:doctor_hunt/apps/core/utils/app_assets.dart';
import 'package:doctor_hunt/apps/core/utils/app_colors.dart';
import 'package:doctor_hunt/apps/features/auth/presentation/widgets/custom_elevated_button.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      width: double.infinity,
      height: 200.h,
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
        spacing: 10,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: .start,
              spacing: 14,
              children: [
                _doctorImageWidget(context: context),
                _doctorDetailsWidget(context: context),
                GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.favorite,
                    color: AppColors.badge,
                    size: 20.w,
                  ),
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: .center,
            children: [
              _buildNextAvailableText(context: context),
              _buildBookNowButton(context: context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _patientStoriesWidget({
    required String text,
    required BuildContext context,
  }) {
    return Row(
      mainAxisSize: .min,
      spacing: 3,
      children: [
        Icon(Icons.circle, color: AppColors.brandPrimary, size: 10.w),
        Text(text, style: context.light8.textSecondary.rubik),
      ],
    );
  }

  Widget _buildBookNowButton({required BuildContext context}) => Expanded(
    flex: 2,
    child: CustomElevatedButton(
      buttonWidth: double.infinity,
      paddingVertical: 10.w,
      borderRadius: 6,
      backgroundColor: AppColors.brandPrimary,
      onPressed: () {},
      child: Text('Book now', style: context.medium11.bgPrimary.rubik),
    ),
  );

  Widget _buildNextAvailableText({required BuildContext context}) => Expanded(
    flex: 3,
    child: Text.rich(
      TextSpan(
        text: 'Next Available\n',
        style: context.medium12.brandPrimary.rubik,
        children: [
          TextSpan(text: '10:00', style: context.medium12.textSecondary.rubik),
          TextSpan(
            text: ' AM tomorrow',
            style: context.light12.textSecondary.rubik,
          ),
        ],
      ),
    ),
  );

  Widget _doctorDetailsWidget({required BuildContext context}) => Expanded(
    flex: 5,
    child: Column(
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
        Text('Tooths Dentist', style: context.regular11.brandPrimary.rubik),
        Text('7 Years experience ', style: context.light11.textSecondary.rubik),
        SizedBox(height: 5),
        Wrap(
          crossAxisAlignment: .start,
          alignment: .start,
          direction: .horizontal,
          spacing: 20,
          children: [
            _patientStoriesWidget(text: '87%', context: context),
            _patientStoriesWidget(text: '69 Patient Stories', context: context),
          ],
        ),
      ],
    ),
  );

  Widget _doctorImageWidget({required BuildContext context}) => Expanded(
    flex: 3,
    child: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        image: DecorationImage(
          image: AssetImage(AppAssets.testImageDoctor),
          fit: .cover,
        ),
      ),
    ),
  );
}
