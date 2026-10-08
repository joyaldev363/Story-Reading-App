import '../models/profile_model.dart';

abstract class ProfileDataSource {
  Future<ProfileModel> getProfile();
  Future<void> updateProfile(ProfileModel profile);
  Future<void> updateLanguage(String languageLabel);
  Future<void> logout();
}

class ProfileLocalDataSourceImpl implements ProfileDataSource {
  ProfileModel _currentProfile = const ProfileModel(
    id: 'usr_001',
    name: 'Abin Joyal',
    email: 'joyal9301@gmail.com',
    avatarUrl: 'assets/images/illustrations/avatar.png',
    readerSince: '2026',
    languageLabel: 'English • தமிழ்',
    notificationsEnabled: true,
    appearanceMode: 'Light mode',
  );

  @override
  Future<ProfileModel> getProfile() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _currentProfile;
  }

  @override
  Future<void> updateProfile(ProfileModel profile) async {
    await Future.delayed(const Duration(milliseconds: 150));
    _currentProfile = profile;
  }

  @override
  Future<void> updateLanguage(String languageLabel) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _currentProfile = ProfileModel.fromEntity(
      _currentProfile.copyWith(languageLabel: languageLabel),
    );
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 200));
  }
}
