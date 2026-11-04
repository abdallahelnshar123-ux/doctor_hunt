import 'package:doctor_hunt/apps/core/extensions/context_extensions.dart';
import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';

class DoctorOnboardingWelcomeTab extends StatelessWidget {
  const DoctorOnboardingWelcomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return
      ListView(
        padding: EdgeInsets.symmetric(horizontal: 25),
        children: [
          const SizedBox(height: 50,),
          Container(
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: AppColors.brandPrimary8,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.medical_services_outlined,
              size: context.width / 4,
              color: AppColors.brandPrimary,
            ),
          ),
          const SizedBox(height: 50,),

          Text(
            t.doctor.onboarding.welcomeTitle,
            style: context.semiBold24.textPrimary.rubik,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            t.doctor.onboarding.welcomeSubtitle,
            textAlign: TextAlign.center,
            style: context.regular16.textSecondary.rubik.copyWith(height: 1.5),
          ),
        ],
      );
  }
}
