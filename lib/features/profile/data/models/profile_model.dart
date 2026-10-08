import '../../domain/entities/profile.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.id,
    required super.name,
    required super.email,
    required super.avatarUrl,
    required super.readerSince,
    required super.languageLabel,
    super.notificationsEnabled = true,
    super.appearanceMode = 'Light mode',
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      avatarUrl: json['avatarUrl'] as String,
      readerSince: json['readerSince'] as String,
      languageLabel: json['languageLabel'] as String,
      notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
      appearanceMode: json['appearanceMode'] as String? ?? 'Light mode',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatarUrl': avatarUrl,
      'readerSince': readerSince,
      'languageLabel': languageLabel,
      'notificationsEnabled': notificationsEnabled,
      'appearanceMode': appearanceMode,
    };
  }

  factory ProfileModel.fromEntity(ProfileEntity entity) {
    return ProfileModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      avatarUrl: entity.avatarUrl,
      readerSince: entity.readerSince,
      languageLabel: entity.languageLabel,
      notificationsEnabled: entity.notificationsEnabled,
      appearanceMode: entity.appearanceMode,
    );
  }
}
