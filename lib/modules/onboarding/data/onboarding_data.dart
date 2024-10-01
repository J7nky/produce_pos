import '../../../core/constants/app_images.dart';
import 'onboarding_model.dart';

class OnboardingData {
  static List<OnboardingModel> items = [
    OnboardingModel(
      lottieUrl: AppImages.onboarding1,
      headline: 'Massive Collection',
      description:
          'We offer a large collection of high-quality fruits, vegetables, and more .',
    ),
    OnboardingModel(
      lottieUrl: AppImages.onboarding2,
      headline: 'Simple Interface',
      description:
          'Few easy steps to add and confirm your orders and address .',
    ),
    OnboardingModel(
      lottieUrl: AppImages.onboarding3,
      headline: 'Fast Delivery',
      description:
          'We are working hard to deliver our products fresh and as quickly as possible .',
    ),
  ];
}
