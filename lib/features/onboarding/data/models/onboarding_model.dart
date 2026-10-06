import '../../domain/entities/onboarding_page.dart';

class OnboardingModel extends OnboardingPage {
  const OnboardingModel({
    required super.title,
    required super.subtitle,
    required super.imagePath,
  });

  factory OnboardingModel.fromJson(Map<String, dynamic> json) {
    return OnboardingModel(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      imagePath: json['imagePath'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'imagePath': imagePath,
    };
  }
}
