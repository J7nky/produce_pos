import 'dart:convert';

class OnboardingModel {
  String lottieUrl;
  String headline;
  String description;
  OnboardingModel({
    required this.lottieUrl,
    required this.headline,
    required this.description,
  });

  OnboardingModel copyWith({
    String? lottieUrl,
    String? headline,
    String? description,
  }) {
    return OnboardingModel(
      lottieUrl: lottieUrl ?? this.lottieUrl,
      headline: headline ?? this.headline,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lottieUrl': lottieUrl,
      'headline': headline,
      'description': description,
    };
  }

  factory OnboardingModel.fromMap(Map<String, dynamic> map) {
    return OnboardingModel(
      lottieUrl: map['lottieUrl'] ?? '',
      headline: map['headline'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OnboardingModel.fromJson(String source) =>
      OnboardingModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'OnboardingData(lottieUrl: $lottieUrl, headline: $headline, description: $description)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OnboardingModel &&
        other.lottieUrl == lottieUrl &&
        other.headline == headline &&
        other.description == description;
  }

  @override
  int get hashCode =>
      lottieUrl.hashCode ^ headline.hashCode ^ description.hashCode;
}
