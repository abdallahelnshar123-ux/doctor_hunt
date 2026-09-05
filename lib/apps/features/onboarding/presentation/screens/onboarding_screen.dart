import 'package:doctor_hunt/apps/core/extensions/context_extensions.dart';
import 'package:doctor_hunt/generated/app_assets.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../auth/presentation/widgets/custom_elevated_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // final List<OnBoardingPage> onboardingDataList = onBoardingPages;
    final t = Translations.of(context);
    final onboardingPages = [
      (
        title: t.onboarding.page1.title,
        subtitle: t.onboarding.page1.subtitle,
        image: AppAssets.images.onBoarding1.path,
        firstButton: t.onboarding.next,
        secondButton: t.onboarding.skip,
      ),
      (
        title: t.onboarding.page2.title,
        subtitle: t.onboarding.page2.subtitle,
        image: AppAssets.images.onBoarding2.path,
        firstButton: t.onboarding.next,
        secondButton: t.onboarding.skip,
      ),
      (
        title: t.onboarding.page3.title,
        subtitle: t.onboarding.page3.subtitle,
        image: AppAssets.images.onBoarding3.path,
        firstButton: t.onboarding.get_started,
        secondButton: t.onboarding.skip,
      ),
    ];

    final currentPage = onboardingPages[currentIndex];

    return AppScaffold(
      isOnboarding: true,
      index: currentIndex,
      body: Padding(
        padding: EdgeInsets.fromLTRB(40, 0, 40, 43),
        child: Column(
          spacing: 14,
          crossAxisAlignment: .center,
          children: [
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: Image.asset(
                  key: ValueKey(currentPage.image),
                  currentPage.image,
                  width: double.infinity,
                  fit: .cover,
                ),
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                currentPage.title,
                textAlign: TextAlign.center,
                style: context.medium28.textTertiary.rubik,
              ),
            ),
            Text(
              currentPage.subtitle,
              textAlign: TextAlign.center,
              style: context.regular12.textSecondary90.rubik,
            ),
            SizedBox(height: 30),
            CustomElevatedButton(
              buttonWidth: context.width - 48,
              onPressed: () {
                if (currentIndex < onboardingPages.length - 1) {
                  debugPrint(currentIndex.toString());
                  setState(() {
                    currentIndex++;
                  });
                } else {
                  const RegisterRoute().go(context);
                }
              },
              backgroundColor: AppColors.brandPrimary,
              child: Text(
                currentPage.firstButton,
                style: context.medium18.bgPrimary.rubik,
              ),
            ),

            TextButton(
              onPressed: () {
                const RegisterRoute().go(context);
              },
              child: Text(
                currentPage.secondButton,
                style: context.regular14.textSecondary.rubik,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Remove the hardcoded onBoardingPagesList as it's now handled in build with translations
