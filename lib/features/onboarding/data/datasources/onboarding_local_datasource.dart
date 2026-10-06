import '../models/onboarding_model.dart';

abstract class OnboardingLocalDataSource {
  List<OnboardingModel> getOnboardingPages();
}

class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  const OnboardingLocalDataSourceImpl();

  @override
  List<OnboardingModel> getOnboardingPages() {
    return const [
      OnboardingModel(
        title: 'Discover\nBeautiful Stories',
        subtitle:
            'Explore a world of interesting\nTamil & English stories for\nevery reader.',
        imagePath: 'assets/images/onboarding/onboarding_1.png',
      ),
      OnboardingModel(
        title: 'Learn Naturally\nWhile Reading',
        subtitle:
            'Read stories in Tamil, English\nor both. Improve your vocabulary\nand language skills easily.',
        imagePath: 'assets/images/onboarding/onboarding_2.png',
      ),
      OnboardingModel(
        title: 'Read, Listen\nand Practice',
        subtitle:
            'Enjoy audio narration, improve\npronunciation and make\nlearning fun.',
        imagePath: 'assets/images/onboarding/onboarding_3.png',
      ),
    ];
  }
}
