import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../data/datasources/profile_datasource.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../domain/usecases/get_profile.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/usecases/update_language.dart';
import '../../domain/usecases/update_profile.dart';
import '../controller/profile_controller.dart';
import 'about_storyly_page.dart';
import 'help_support_page.dart';
import 'privacy_security_page.dart';
import '../widgets/account_section.dart';
import '../widgets/logout_button.dart';
import '../widgets/preferences_section.dart';
import '../widgets/profile_card.dart';
import '../widgets/profile_header.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final ProfileController _controller;

  @override
  void initState() {
    super.initState();
    final dataSource = ProfileLocalDataSourceImpl();
    final repository = ProfileRepositoryImpl(dataSource: dataSource);

    _controller = ProfileController(
      getProfileUseCase: GetProfile(repository),
      updateProfileUseCase: UpdateProfile(repository),
      updateLanguageUseCase: UpdateLanguage(repository),
      logoutUseCase: Logout(repository),
    );

    _controller.loadProfile();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            if (_controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFF635BFF)),
              );
            }

            final profile = _controller.profile;
            if (profile == null) {
              return const Center(child: Text('Unable to load profile data.'));
            }

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Header
                  ProfileHeader(
                    onSettingsTap: () {
                      _showSnackBar('Settings opened');
                    },
                  ),

                  // Profile Info Card
                  ProfileCard(
                    profile: profile,
                    onEditAvatarTap: () {
                      _showSnackBar('Edit avatar tapped');
                    },
                  ),

                  // Preferences Section
                  PreferencesSection(
                    profile: profile,
                    onLanguageTap: () {
                      _showLanguageDialog(context);
                    },
                    onNotificationsTap: () {
                      _controller.toggleNotifications();
                      _showSnackBar(
                        profile.notificationsEnabled
                            ? 'Notifications enabled'
                            : 'Notifications disabled',
                      );
                    },
                    onAppearanceTap: () {
                      _controller.toggleAppearanceMode();
                    },
                  ),

                  // Account Section
                  AccountSection(
                    onEditProfileTap: () {
                      _showSnackBar('Edit profile details');
                    },
                    onPrivacyTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PrivacySecurityPage(),
                        ),
                      );
                    },
                    onHelpTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HelpSupportPage(),
                        ),
                      );
                    },
                    onAboutTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AboutStorylyPage(),
                        ),
                      );
                    },
                  ),

                  // Logout Button
                  LogoutButton(
                    onTap: () {
                      _showLogoutConfirmationDialog(context);
                    },
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 1)),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Preferred Language',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.navyBlue,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('English • தமிழ்'),
                trailing:
                    _controller.profile?.languageLabel == 'English • தமிழ்'
                    ? const Icon(
                        Icons.check_circle_rounded,
                        color: Color(0xFF635BFF),
                      )
                    : null,
                onTap: () {
                  _controller.changeLanguage('English • தமிழ்');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('English Only'),
                trailing: _controller.profile?.languageLabel == 'English Only'
                    ? const Icon(
                        Icons.check_circle_rounded,
                        color: Color(0xFF635BFF),
                      )
                    : null,
                onTap: () {
                  _controller.changeLanguage('English Only');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('தமிழ் மட்டும்'),
                trailing: _controller.profile?.languageLabel == 'தமிழ் மட்டும்'
                    ? const Icon(
                        Icons.check_circle_rounded,
                        color: Color(0xFF635BFF),
                      )
                    : null,
                onTap: () {
                  _controller.changeLanguage('தமிழ் மட்டும்');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Storyly',
      applicationVersion: '1.0.0+1',
      applicationIcon: const Icon(
        Icons.auto_stories_rounded,
        size: 48,
        color: Color(0xFF635BFF),
      ),
      children: [
        const SizedBox(height: 8),
        const Text(
          'Storyly is a bilingual Tamil and English story reading platform designed for immersive learning and entertainment.',
        ),
      ],
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Log Out'),
          content: const Text('Are you sure you want to log out of Storyly?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF4D4D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                Navigator.pop(context);
                await _controller.performLogout();
                _showSnackBar('Logged out successfully');
              },
              child: const Text(
                'Log Out',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
