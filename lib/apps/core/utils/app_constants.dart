import '../../features/onboarding/data/models/on_boarding_page.dart';
import '../utils/app_assets.dart';

class AppConstants {
  static final List<OnBoardingPage> onBoardingPages = [
    OnBoardingPage(
      image: AppAssets.onBoardingImage1,
      subtitle: "Contrary to popular belief, Lorem Ipsum "
          "is not simply random text. It has roots in "
          "a piece of it over 2000 years old.",
      title: "Find Trusted Doctors",
      firstButton: "Next",
      secondButton: "Skip",
      // subtitle: "onboarding_description1",
      // title: "onboarding_title1",
      // firstButton: "next",
      // secondButton: 'skip',
    ),

    OnBoardingPage(
      image: AppAssets.onBoardingImage2,
      subtitle: "Contrary to popular belief, Lorem Ipsum is not"
          " simply random text. It has roots in a piece of it"
          " over 2000 years old.",
      title: "Choose Best Doctors",
      firstButton: "Next",
      secondButton: "Skip",
      // subtitle: "onboarding_description2",
      // title: "onboarding_title2",
      // firstButton: "next",
      // secondButton: "skip",
    ),

    OnBoardingPage(
      image: AppAssets.onBoardingImage3,
      subtitle: "Contrary to popular belief, Lorem Ipsum is not"
          " simply random text. It has roots"
          " in a piece of it over 2000 years old.",
      title: "Easy Appointments",
      firstButton: "Get Started",
      secondButton: "Skip",
      // subtitle: "onboarding_description3",
      // title: "onboarding_title3",
      // firstButton: "sign_in",
      // secondButton: "skip",
    ),
  ];
}
