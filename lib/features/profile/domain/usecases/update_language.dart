import '../repositories/profile_repository.dart';

class UpdateLanguage {
  final ProfileRepository repository;

  UpdateLanguage(this.repository);

  Future<void> call(String languageLabel) async {
    return await repository.updateLanguage(languageLabel);
  }
}
