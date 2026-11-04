import 'package:doctor_hunt/generated/app_assets.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DoctorOnboardingSuccessTab extends StatelessWidget {
  const DoctorOnboardingSuccessTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100),
          child: Lottie.asset(
            AppAssets.lottie.successCheck.path,
            frameRate: .max,
            repeat: false,
          ),
        ),
        Text(
          t.doctor.onboarding.successTitle,
          style: context.semiBold24.textPrimary.rubik,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
