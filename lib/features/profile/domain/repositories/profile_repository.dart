import '../entities/profile.dart';

abstract class ProfileRepository {
  Future<ProfileEntity> getProfile();
  Future<void> updateProfile(ProfileEntity profile);
  Future<void> updateLanguage(String languageLabel);
  Future<void> logout();
}
