import 'package:flutter/material.dart';
import '../../domain/entities/profile.dart';
import '../../domain/usecases/get_profile.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/usecases/update_language.dart';
import '../../domain/usecases/update_profile.dart';

class ProfileController extends ChangeNotifier {
  final GetProfile getProfileUseCase;
  final UpdateProfile updateProfileUseCase;
  final UpdateLanguage updateLanguageUseCase;
  final Logout logoutUseCase;

  ProfileController({
    required this.getProfileUseCase,
    required this.updateProfileUseCase,
    required this.updateLanguageUseCase,
    required this.logoutUseCase,
  });

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  ProfileEntity? _profile;
  ProfileEntity? get profile => _profile;

  Future<void> loadProfile() async {
    _isLoading = true;
    notifyListeners();

    try {
      _profile = await getProfileUseCase();
    } catch (_) {
      // Handle error gracefully
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> changeLanguage(String newLanguage) async {
    if (_profile == null) return;
    _profile = _profile!.copyWith(languageLabel: newLanguage);
    notifyListeners();
    await updateLanguageUseCase(newLanguage);
  }

  Future<void> toggleNotifications() async {
    if (_profile == null) return;
    final updated = _profile!.copyWith(
      notificationsEnabled: !_profile!.notificationsEnabled,
    );
    _profile = updated;
    notifyListeners();
    await updateProfileUseCase(updated);
  }

  Future<void> toggleAppearanceMode() async {
    if (_profile == null) return;
    final newMode = _profile!.appearanceMode == 'Light mode' ? 'Dark mode' : 'Light mode';
    final updated = _profile!.copyWith(appearanceMode: newMode);
    _profile = updated;
    notifyListeners();
    await updateProfileUseCase(updated);
  }

  Future<void> performLogout() async {
    await logoutUseCase();
  }
}
