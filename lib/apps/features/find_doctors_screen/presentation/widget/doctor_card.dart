import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/features/auth/presentation/widgets/custom_elevated_button.dart';
import 'package:doctor_hunt/generated/app_assets.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/favorite_button_widget.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      width: double.infinity,
      height: 200,
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
                FavoriteButtonWidget(),
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
        Icon(Icons.circle, color: AppColors.brandPrimary, size: 10),
        Text(text, style: context.light8.textSecondary.rubik),
      ],
    );
  }

  Widget _buildBookNowButton({required BuildContext context}) => Expanded(
    flex: 2,
    child: CustomElevatedButton(
      buttonWidth: double.infinity,
      paddingVertical: 10,
      borderRadius: 6,
      backgroundColor: AppColors.brandPrimary,
      onPressed: () {
        const DoctorDetailsRoute().push(context);
      },
      child: Text(
        Translations.of(context).doctor_details.book_now,
        style: context.medium11.bgPrimary.rubik,
      ),
    ),
  );

  Widget _buildNextAvailableText({required BuildContext context}) {
    final t = Translations.of(context);
    return Expanded(
      flex: 3,
      child: Text.rich(
        TextSpan(
          text: '${t.doctor_details.next_available}\n',
          style: context.medium12.brandPrimary.rubik,
          children: [
            TextSpan(
              text: '10:00',
              style: context.medium12.textSecondary.rubik,
            ),
            TextSpan(
              text: ' ${t.common.am} ${t.doctor_details.tomorrow}',
              style: context.light12.textSecondary.rubik,
            ),
          ],
        ),
      ),
    );
  }

  Widget _doctorDetailsWidget({required BuildContext context}) {
    final t = Translations.of(context);
    return Expanded(
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
          Text(
            Translations.of(context).doctor_details.tooths_dentist,
            style: context.regular11.brandPrimary.rubik,
          ),
          Text(
            t.doctor_details.experience(Years: '7'),
            style: context.light11.textSecondary.rubik,
          ),
          SizedBox(height: 5),
          Wrap(
            crossAxisAlignment: .start,
            alignment: .start,
            direction: .horizontal,
            spacing: 20,
            children: [
              _patientStoriesWidget(text: '87%', context: context),
              _patientStoriesWidget(
                text: t.doctor_details.patient_stories(Count: '69'),
                context: context,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _doctorImageWidget({required BuildContext context}) => Expanded(
    flex: 3,
    child: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        image: DecorationImage(
          image: AssetImage(AppAssets.images.testDoctorImage.path),
          fit: .cover,
        ),
      ),
    ),
  );
}
