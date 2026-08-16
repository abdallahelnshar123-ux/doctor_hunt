import 'package:flutter/material.dart';

import '../../../../core/utils/app_constants.dart';

class OnboardingViewModel extends ChangeNotifier {
  final int onboardingPagesNumber = AppConstants.onBoardingPages.length;

  int currentIndex = 0;

  OnboardingViewModel();

  void changeIndex(int index) {
    if (currentIndex != index) {
      currentIndex = index;
      notifyListeners();
    }
  }

  void onFirstButtonClick() {
    if (currentIndex < onboardingPagesNumber - 1) {
      currentIndex++;
      notifyListeners();
    } else {
      // _setOnboardingDoneUseCase.setOnboardingDone();
    }
  }

  void onSecondButtonClick() {
    // _setOnboardingDoneUseCase.setOnboardingDone();
  }
}
