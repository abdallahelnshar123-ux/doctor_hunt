import 'package:doctor_hunt/apps/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_routes.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../auth/presentation/widgets/custom_elevated_button.dart';
import '../../data/models/on_boarding_page.dart';
import '../controller/onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OnboardingViewModel provider = context.watch<OnboardingViewModel>();
    final int currentIndex = provider.currentIndex;
    final List<OnBoardingPage> onboardingDataList =
        AppConstants.onBoardingPages;

    return SafeArea(
      top: false,
      bottom: true,
      child: AppScaffold(
        isOnboarding: true,
        index: currentIndex,
        body: Padding(
          padding: EdgeInsets.fromLTRB(40.w, 0, 40.w, 43.h),
          child: Column(
            spacing: 14.h,
            crossAxisAlignment: .center,
            children: [
              // SizedBox(height: 80.h),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: Image.asset(
                    key: ValueKey(onboardingDataList[currentIndex].image),
                    onboardingDataList[currentIndex].image,
                    width: double.infinity,
                    fit: .cover,
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  onboardingDataList[currentIndex].title,
                  textAlign: TextAlign.center,
                  style: AppStyles.rubikMedium28(AppColors.textTertiary),
                ),
              ),
              Text(
                onboardingDataList[currentIndex].subtitle,
                textAlign: TextAlign.center,
                style: AppStyles.rubikRegular12(AppColors.textSecondary90),
              ),
              SizedBox(height: 30.h),
              CustomElevatedButton(
                buttonWidth: 1.sw - 48.w,
                onPressed: () {
                  final wasLastPage =
                      provider.currentIndex ==
                      provider.onboardingPagesNumber - 1;

                  provider.onFirstButtonClick();

                  if (wasLastPage) {
                    context.goNamed(AppRoutes.loginRouteName);
                  }
                },
                backgroundColor: AppColors.brandPrimary,
                child: Text(
                  onboardingDataList[currentIndex].firstButton,
                  style: AppStyles.rubikMedium18(AppColors.bgPrimary),
                ),
              ),

              TextButton(
                onPressed: () {
                  provider.onSecondButtonClick();
                  context.goNamed(AppRoutes.loginRouteName);
                },
                child: Text(
                  onboardingDataList[currentIndex].secondButton,
                  style: AppStyles.rubikRegular14(AppColors.textSecondary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
