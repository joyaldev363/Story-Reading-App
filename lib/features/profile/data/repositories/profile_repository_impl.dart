import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_datasource.dart';
import '../models/profile_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource dataSource;

  ProfileRepositoryImpl({required this.dataSource});

  @override
  Future<ProfileEntity> getProfile() async {
    return await dataSource.getProfile();
  }

  @override
  Future<void> updateProfile(ProfileEntity profile) async {
    final model = ProfileModel.fromEntity(profile);
    await dataSource.updateProfile(model);
  }

  @override
  Future<void> updateLanguage(String languageLabel) async {
    await dataSource.updateLanguage(languageLabel);
  }

  @override
  Future<void> logout() async {
    await dataSource.logout();
  }
}
