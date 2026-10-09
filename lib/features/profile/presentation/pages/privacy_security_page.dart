import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

class PrivacySecurityPage extends StatefulWidget {
  const PrivacySecurityPage({super.key});

  @override
  State<PrivacySecurityPage> createState() => _PrivacySecurityPageState();
}

class _PrivacySecurityPageState extends State<PrivacySecurityPage> {
  bool _biometricLock = true;
  bool _readingAnalytics = true;
  bool _personalizedRecommendations = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.navyBlue),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Privacy & Security',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.navyBlue,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero info banner
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF635BFF).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.shield_outlined,
                      color: Color(0xFF635BFF),
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Privacy is Protected',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.navyBlue,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Storyly encrypts your reading history & account preferences securely.',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF718096),
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Security Controls Section
            const Text(
              'Security Controls',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppColors.navyBlue,
              ),
            ),
            const SizedBox(height: 12),
            Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  SwitchListTile(
                    activeColor: const Color(0xFF635BFF),
                    title: const Text(
                      'Biometric App Lock',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.navyBlue,
                      ),
                    ),
                    subtitle: const Text(
                      'Require Face ID or Fingerprint on app launch',
                      style: TextStyle(fontSize: 12.5, color: Color(0xFF718096)),
                    ),
                    value: _biometricLock,
                    onChanged: (val) {
                      setState(() => _biometricLock = val);
                    },
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  ListTile(
                    title: const Text(
                      'Change Password',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.navyBlue,
                      ),
                    ),
                    subtitle: const Text(
                      'Update your password & login credentials',
                      style: TextStyle(fontSize: 12.5, color: Color(0xFF718096)),
                    ),
                    trailing: const Icon(Icons.chevron_right_rounded, color: Color(0xFFA0AEC0)),
                    onTap: () {
                      _showSnackBar(context, 'Change password screen opened');
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Data & Privacy Preferences
            const Text(
              'Data Preferences',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppColors.navyBlue,
              ),
            ),
            const SizedBox(height: 12),
            Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  SwitchListTile(
                    activeColor: const Color(0xFF635BFF),
                    title: const Text(
                      'Reading Analytics',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.navyBlue,
                      ),
                    ),
                    subtitle: const Text(
                      'Allow anonymous analytics to improve story recommendations',
                      style: TextStyle(fontSize: 12.5, color: Color(0xFF718096)),
                    ),
                    value: _readingAnalytics,
                    onChanged: (val) {
                      setState(() => _readingAnalytics = val);
                    },
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  SwitchListTile(
                    activeColor: const Color(0xFF635BFF),
                    title: const Text(
                      'Personalized Story Suggestions',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.navyBlue,
                      ),
                    ),
                    subtitle: const Text(
                      'Tailor story recommendations based on read history',
                      style: TextStyle(fontSize: 12.5, color: Color(0xFF718096)),
                    ),
                    value: _personalizedRecommendations,
                    onChanged: (val) {
                      setState(() => _personalizedRecommendations = val);
                    },
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  ListTile(
                    title: const Text(
                      'Clear Local Search Cache',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.navyBlue,
                      ),
                    ),
                    subtitle: const Text(
                      'Remove cached story searches from this device',
                      style: TextStyle(fontSize: 12.5, color: Color(0xFF718096)),
                    ),
                    onTap: () {
                      _showSnackBar(context, 'Local search cache cleared');
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Account Actions
            Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                leading: const Icon(Icons.download_rounded, color: Color(0xFF635BFF)),
                title: const Text(
                  'Download My Data Archive',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.navyBlue,
                  ),
                ),
                trailing: const Icon(Icons.chevron_right_rounded, color: Color(0xFFA0AEC0)),
                onTap: () {
                  _showSnackBar(context, 'Data archive requested');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 1)),
    );
  }
}
