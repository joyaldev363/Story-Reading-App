class ProfileEntity {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;
  final String readerSince;
  final String languageLabel;
  final bool notificationsEnabled;
  final String appearanceMode;

  const ProfileEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.readerSince,
    required this.languageLabel,
    this.notificationsEnabled = true,
    this.appearanceMode = 'Light mode',
  });

  ProfileEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? avatarUrl,
    String? readerSince,
    String? languageLabel,
    bool? notificationsEnabled,
    String? appearanceMode,
  }) {
    return ProfileEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      readerSince: readerSince ?? this.readerSince,
      languageLabel: languageLabel ?? this.languageLabel,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      appearanceMode: appearanceMode ?? this.appearanceMode,
    );
  }
}
