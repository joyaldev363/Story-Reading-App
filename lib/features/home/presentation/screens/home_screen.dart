import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: AppColors.backgroundCream,
        elevation: 0,
        foregroundColor: AppColors.navyBlue,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home_rounded, size: 64, color: AppColors.navyBlue),
            SizedBox(height: 16),
            Text(
              'Home Screen',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.navyBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
