import 'package:doctor_hunt/apps/core/data/shared_prefs/user_pref.dart';
import 'package:doctor_hunt/apps/core/extensions/context_extensions.dart';
import 'package:doctor_hunt/apps/core/router/app_routes.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';

import '../../../../../core/di/di.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/app_scaffold.dart';
import '../../../auth/presentation/widgets/custom_elevated_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final userPrefs = getIt<UserPrefs>();
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final onboardingPages = t.onboarding.pages;

    final currentPage = onboardingPages[currentIndex];
    final isLastPage = currentIndex == onboardingPages.length - 1;

    final firstButtonText = isLastPage
        ? t.onboarding.getStarted
        : t.onboarding.next;

    final secondButtonText = t.onboarding.skip;
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
                  key: ValueKey(currentPage.imagePath),
                  currentPage.imagePath,
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
              onPressed: () async {
                if (currentIndex < onboardingPages.length - 1) {
                  setState(() {
                    currentIndex++;
                  });
                } else {
                  await userPrefs.setOnboardingDone();
                  if (context.mounted) {
                    const ChooseRoleRoute().go(context);
                  }
                }
              },
              backgroundColor: AppColors.brandPrimary,
              child: Text(
                firstButtonText,
                style: context.medium18.bgPrimary.rubik,
              ),
            ),

            TextButton(
              onPressed: () async {
                await userPrefs.setOnboardingDone();
                if (context.mounted) {
                  const ChooseRoleRoute().go(context);
                }
              },
              child: Text(
                secondButtonText,
                style: context.regular14.textSecondary.rubik,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
