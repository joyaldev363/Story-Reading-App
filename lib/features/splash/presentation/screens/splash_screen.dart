import 'package:flutter/material.dart';
import '../../../../app/router/dashboard_screen.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/storage/local_storage.dart';
import '../../../onboarding/presentation/screens/onboarding_screen.dart';
import '../widgets/splash_logo.dart';
import '../widgets/splash_tagline.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _navigateToNext();
        }
      })
      ..forward();
  }

  Future<void> _navigateToNext() async {
    if (!mounted) return;
    final isCompleted = await LocalStorage.isOnboardingCompleted();
    if (!mounted) return;

    final targetScreen = isCompleted
        ? const DashboardScreen()
        : const OnboardingScreen();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => targetScreen,
      ),
    );
  }


  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // Center Logo & Title Area
              const SplashLogo(),

              // Storyly Title
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Story',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                        color: AppColors.navyBlue,
                        letterSpacing: -0.5,
                      ),
                    ),
                    TextSpan(
                      text: 'ly',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                        color: AppColors.accentGold,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              // Tagline
              const SplashTagline(),

              const Spacer(flex: 3),

              // Bottom Progress Bar & Loading Message
              
              AnimatedBuilder(
                animation: _progressController,
                builder: (context, child) {
                  return Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 10,
                        decoration: BoxDecoration(
                          color: AppColors.progressTrack,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: FractionallySizedBox(
                            widthFactor: _progressController.value,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.accentGold,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Bringing stories to life...',
                        style: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: AppColors.subtitleSlate.withValues(alpha: 0.8),
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
