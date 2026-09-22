//CR Dead Code: Unused mutable model class; OnboardingScreen uses records instead. Remove or make immutable if needed.
class OnBoardingPage {
  OnBoardingPage({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.firstButton,
    required this.secondButton,
  });

  String image;

  String title;

  String subtitle;

  String firstButton;

  String secondButton;
}
