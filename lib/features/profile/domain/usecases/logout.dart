import '../repositories/profile_repository.dart';

class Logout {
  final ProfileRepository repository;

  Logout(this.repository);

  Future<void> call() async {
    return await repository.logout();
  }
}
