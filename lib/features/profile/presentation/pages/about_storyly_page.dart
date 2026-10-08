import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

class AboutStorylyPage extends StatelessWidget {
  const AboutStorylyPage({super.key});

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
          'About Storyly',
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
          children: [
            const SizedBox(height: 12),
            // App Branding Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: 76,
                    height: 76,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF635BFF), Color(0xFF8C85FF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF635BFF).withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.auto_stories_rounded,
                      size: 42,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Storyly',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: AppColors.navyBlue,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF635BFF).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Version 1.0.0 (Build 1)',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF635BFF),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Storyly is a modern bilingual reading platform designed to preserve rich Tamil literature alongside English translations with synchronized audio narration.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13.5,
                      color: Color(0xFF718096),
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Key Highlights Card
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: const [
                  _FeatureHighlightTile(
                    icon: Icons.graphic_eq_rounded,
                    title: 'Synchronized Audio Narration',
                    subtitle: 'Real-time sentence highlighting in Tamil and English',
                  ),
                  Divider(height: 1, indent: 56),
                  _FeatureHighlightTile(
                    icon: Icons.translate_rounded,
                    title: 'Bilingual Reader',
                    subtitle: 'Seamless side-by-side or toggleable Tamil & English text',
                  ),
                  Divider(height: 1, indent: 56),
                  _FeatureHighlightTile(
                    icon: Icons.offline_pin_rounded,
                    title: 'Offline Reading & Audio',
                    subtitle: 'Download your favorite stories for offline access',
                  ),
                  Divider(height: 1, indent: 56),
                  _FeatureHighlightTile(
                    icon: Icons.workspace_premium_rounded,
                    title: 'Gamified Reading Streaks',
                    subtitle: 'Earn badges and expand your vocabulary',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Legal & Terms Section
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Terms of Service'),
                    trailing: const Icon(Icons.chevron_right_rounded, color: Color(0xFFA0AEC0)),
                    onTap: () => _showSnackBar(context, 'Terms of Service opened'),
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  ListTile(
                    title: const Text('Privacy Policy'),
                    trailing: const Icon(Icons.chevron_right_rounded, color: Color(0xFFA0AEC0)),
                    onTap: () => _showSnackBar(context, 'Privacy Policy opened'),
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  ListTile(
                    title: const Text('Open Source Licenses'),
                    trailing: const Icon(Icons.chevron_right_rounded, color: Color(0xFFA0AEC0)),
                    onTap: () {
                      showLicensePage(
                        context: context,
                        applicationName: 'Storyly',
                        applicationVersion: '1.0.0+1',
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Copyright Footer
            const Text(
              '© 2026 Storyly Inc. All rights reserved.',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFFA0AEC0),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  static void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 1)),
    );
  }
}

class _FeatureHighlightTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _FeatureHighlightTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF635BFF), size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: AppColors.navyBlue,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: Color(0xFF718096),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
