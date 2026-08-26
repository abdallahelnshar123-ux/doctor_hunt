import 'package:doctor_hunt/generated/app_assets.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../auth/presentation/widgets/custom_elevated_button.dart';
import '../../data/models/on_boarding_page.dart';

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
                  key: ValueKey(onBoardingPagesList[currentIndex].image),
                  onBoardingPagesList[currentIndex].image,
                  width: double.infinity,
                  fit: .cover,
                ),
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                onBoardingPagesList[currentIndex].title,
                textAlign: TextAlign.center,
                style: context.medium28.textTertiary.rubik,
              ),
            ),
            Text(
              onBoardingPagesList[currentIndex].subtitle,
              textAlign: TextAlign.center,
              style: context.regular12.textSecondary90.rubik,
            ),
            SizedBox(height: 30),
            CustomElevatedButton(
              buttonWidth: MediaQuery.sizeOf(context).width - 48,
              onPressed: () {
                if (currentIndex < onBoardingPagesList.length - 1) {
                  debugPrint(currentIndex.toString());
                  setState(() {
                    currentIndex++;
                  });
                } else {
                  const LoginRoute().go(context);
                }
              },
              backgroundColor: AppColors.brandPrimary,
              child: Text(
                onBoardingPagesList[currentIndex].firstButton,
                style: context.medium18.bgPrimary.rubik,
              ),
            ),

            TextButton(
              onPressed: () {
                setState(() {
                  const LoginRoute().go(context);
                });
              },
              child: Text(
                onBoardingPagesList[currentIndex].secondButton,
                style: context.regular14.textSecondary.rubik,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final List<OnBoardingPage> onBoardingPagesList = [
  OnBoardingPage(
    image: AppAssets.images.onBoarding1.path,
    subtitle:
        "Find trusted doctors near you. Get"
        " the care you need from experienced professionals.",
    title: "Find Trusted Doctors",
    firstButton: "Next",
    secondButton: "Skip",
    // subtitle: "onboarding_description1",
    // title: "onboarding_title1",
    // firstButton: "next",
    // secondButton: 'skip',
  ),

  OnBoardingPage(
    image: AppAssets.images.onBoarding2.path,
    subtitle:
        "Explore doctors based on your needs."
        "Choose the one that’s right for you.",
    title: "Choose Best Doctors",
    firstButton: "Next",
    secondButton: "Skip",
    // subtitle: "onboarding_description2",
    // title: "onboarding_title2",
    // firstButton: "next",
    // secondButton: "skip",
  ),

  OnBoardingPage(
    image: AppAssets.images.onBoarding3.path,
    subtitle:
        "Book your appointment in just a few taps."
        "Choose a time that works best for you.",
    title: "Easy Appointments",
    firstButton: "Get Started",
    secondButton: "Skip",
    // subtitle: "onboarding_description3",
    // title: "onboarding_title3",
    // firstButton: "sign_in",
    // secondButton: "skip",
  ),
];
